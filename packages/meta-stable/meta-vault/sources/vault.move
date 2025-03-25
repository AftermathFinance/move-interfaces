// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

/// Module: meta_vault
module meta_vault::vault;

use meta_vault::math::{
    calculate_dynamic_fee, normalize_decimals, multiply_and_divide,
    exchange_rate_one_to_one, one_hundred_percent_base_18
};
use meta_vault::vault_assistant::{VaultAssistantCap, create_vault_assistant_cap};
use meta_vault::admin::{Self, AdminCap};
use meta_vault::version::{Self, Version};
use meta_vault::events;
use sui::coin::{Self, Coin, CoinMetadata, TreasuryCap};
use sui::object_bag::{Self, ObjectBag};
use sui::transfer::public_transfer;
use sui::balance::Supply;
use sui::package;

use std::type_name::{Self, TypeName};

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error]
const ETreasuryCapMustHaveZeroValue: vector<u8> = b"The `TreasuryCap` passed to `create_vault` has a nonzero `value`.";

#[error]
const ECoinIsNotSupported: vector<u8> = b"The `Coin` type is not supported by this Vault.";

#[error]
const ENotEnoughSpaceToHandleDeposit: vector<u8> = b"This deposit is larger than the `Vault`'s deposit cap for this `Coin` would allow.";

#[error]
const ENotEnoughLiquidityToHandleWithdraw: vector<u8> = b"The `Vault` does not have enough liquidity of this `Coin` type to handle this withdraw request.";

#[error]
const EAlreadySupported: vector<u8> = b"The `Coin` type is already whitelisted.";

#[error]
const EZeroValue: vector<u8> = b"The input `Coin` has zero value.";

#[error]
const EInvalidAppWasUsedToCreateDepositCap: vector<u8> = b"The exchange rate for the input coin was obtained from an invalid source.";

#[error]
const EInvalidAppWasUsedToCreateWithdrawCap: vector<u8> = b"The exchange rate for the output coin was obtained from an invalid source.";

#[error]
const EInvalidAmountOut: vector<u8> = b"The output `Coin` has zero value.";

#[error]
const EUnacceptableSlippage: vector<u8> = b"This action resulted in an `amount_out` below you're slippage tolerance.";

#[error]
const EInvalidVaultAssistantCap: vector<u8> = b"Only the `Vault`'s active `VaultAssistantCap` can interact with the `Vault`.";

#[error]
const EInvalidFlashLoan: vector<u8> = b"The flash loan was not repaid in full.";

//**************************************************************************************************//
// Constants                                                                                        //
//**************************************************************************************************//

const ZERO: u64 = 0;

//**************************************************************************************************//
// Package Init                                                                                     //
//**************************************************************************************************//

public struct VAULT has drop {}

fun init(witness: VAULT, ctx: &mut TxContext) {
    abort 404
}

//************************************************************************************************//
// Metadata                                                                                       //
//************************************************************************************************//

/// Contains `Vault`-specific parameters for a certain `Coin` type that define how the `Coin` type
/// can be used within the `Vault`.
///
/// This object is created when adding support for a new `Coin` type` to a `Vault`, either through
/// `add_support_for_new_coin` or `add_support_for_new_coin_unsafe`.
///
/// Only the admin can add support for new `Coin` type. The admin has the permissioned ability to
/// update all of the fields of an already created `Metadata`, while the active
/// `VaultAssistantCap` is only allowed to update a subset of its fields.
public struct Metadata has key, store {
    id: UID,

    /// The associated `Vault`'s `ID`. Required for better tracking off-chain.
    vault_id: ID,

    /// The maximum amount of `Coin` that can be deposited into this `Vault`. Setting to
    /// `u64::max` allows limitless deposits. Setting `0 <= x <= balance` disables deposits.
    deposit_cap: u64,
    /// The total amount of this asset that has been deposited into the `Vault`.
    balance: u64,

    // Restricts which `app_id` can be used to create a `DepositCap` or `WithdrawCap. This should
    // be set to the `ID` of the singleton object which is used to calculate the `Coin<MetaCoin>`
    // -> `Coin<ThisCoin>` exchange rates.
    whitelisted_app_id: ID,

    /// The `Vault`'s relative priority to hold this asset. This value is used to calculate the
    /// `Vault`'s target liquidity of this asset; i.e.,
    ///                                           /      this.priority     \
    ///     target_liquidity = vault.total_value | ------------------------ |
    ///                                           \ vault.total_priorities /
    ///
    /// `priority` values only hold meaning are relative to one another within a `Vault`, thus
    /// they should be set among the same magnitude for each `Vault` specifically.
    priority: u64,
    /// Sets a lower bound on the amount of fee that will be charged when the associated `Coin`
    /// type is withdrawn from the `Vault`. This amount will be charged when the `Vault` holds
    /// *more* than its target liquidity (derived from this asset's pro-rata `priority`) of the
    /// respective `Coin` type.
    min_fee: u64,
    /// Sets an upper bound on the amount of fee that will be charged when the associated `Coin`
    /// type is withdrawn from the `Vault`. A fee within the range [`min_fee`, `max_fee`] will be
    /// charged when the `Vault` has *less* than its target liquidity (derived from this asset's
    /// pro-rata `priority`) of the respective `Coin` type.
    max_fee: u64,
    /// Fee rate charged for when returning a flash loan on this asset, represented with
    /// 18 decimal places.
    flash_loan_fee: u64,

    /// Number of decimal places the `Coin` uses. Obtained from the respective `Coin` type's
    /// `CoinMetadata` object.
    decimals: u8,
}

//******************************************** Getters *******************************************//

public fun whitelisted_app_id(
    metadata: &Metadata,
): ID {
    abort 404
}

public fun balance(
    metadata: &Metadata,
): u64 {
    abort 404
}

public fun deposit_cap(
    metadata: &Metadata,
): u64 {
    abort 404
}

public fun min_fee(
    metadata: &Metadata,
): u64 {
    abort 404
}

public fun max_fee(
    metadata: &Metadata,
): u64 {
    abort 404
}

public fun flash_loan_fee(
    metadata: &Metadata,
): u64 {
    abort 404
}

public fun priority(
    metadata: &Metadata,
): u64 {
    abort 404
}

public fun decimals(
    metadata: &Metadata,
): u8 {
    abort 404
}

//**************************************************************************************************//
// DynamicFeeParams                                                                                 //
//**************************************************************************************************//

/// Defines the parameters that will be used to derive the `Vault`'s target liquidity of
/// `Coin<CoinOut>` when calculating the dynamic fee during `withdraw` and `swap`.
///
/// `withdraw` calculates the target liquidity in absolute terms; i.e., the `Vault`'s total minted
/// amount of `Coin<MetaCoin>` is used as a proxy for the `Vault`'s total TVL, normalized to
/// `Coin<CoinOut>`, and the target liquidity is derived off of the `Vault`'s absolute priority to
/// hold `Coin<CoinOut>`.
///
/// `swap` calculates the target liquidity in relative terms; i.e., the `Vault`'s total liquidity
/// is calculated as the sum of the `Vault`'s balances of `Coin<CoinIn>` and `Coin<coinOut>`,
/// normalized to `Coin<CoinOut>`, and the target liquidity is derived as the `Vault`'s priority
/// to hold `Coin<CoinOut>` vs `Coin<CoinIn>` (out / (in + out)).
///
/// This enum allows us to unify the function signatures to `split` and `take_fee` while differing
/// how they function during `withdraw` and `swap`.
public enum DynamicFeeParams has drop {
    Absolute {
	exchange_rate_meta_coin_to_coin_out: u128,
    },
    Relative {
	exchange_rate_meta_coin_to_coin_out: u128,
	exchange_rate_meta_coin_to_coin_in: u128,
        coin_in_type_name: TypeName,
    },
}

//**************************************************************************************************//
// Vault                                                                                            //
//**************************************************************************************************//

/// MetaStable's core struct. Holds all idle liquidity that is deposited by users to mint a
/// specific `Coin<MetaCoin>`. Each `Vault` is parameterized by its `Coin<MetaCoin>` type and
/// holds the `Supply` required to mint or burn `Balance<MetaCoin>` (or `Coin<MetaCoin>`).
///
/// A `Vault` is created within (you guessed it) `create_vault` and assets can be whitelsited
/// (for deposits and subsequent withdrawals) through one of `add_support_for_new_coin` /
/// `add_support_for_new_coin_unsafe`.
///
/// Each `Vault` has an associated assistant who has access to a subset of the permissioned
/// functionality for the `Vault`. The `VaultAssistantCap` is meant to be held by a hot wallet and has access to expected-to-be-more-commonly called `Vault` mutators.
public struct Vault<phantom MetaCoin> has key {
    id: UID,

    /// The `Vault`'s `Supply` to allow minting and burning of `Balance<MetaCoin>`.
    supply: Supply<MetaCoin>,
    /// The `decimal` value of the `Vault`'s corresponding `Coin<MetaCoin>`.
    meta_coin_decimals: u8,
    /// The `ID` of the only active `VaultAssistantCap`.
    active_assistant_cap: ID,

    /// Maintains a mapping of `TypeName` -> `Metadata` for all `Coin` types underlying the
    /// `Vault`; i.e., for which `add_support_for_new_coin` has been called.
    metadata: ObjectBag,
    /// Sum of all `Metadata` priorities. This value is only updated during one of:
    ///  - `add_support_for_new_coin` / `add_support_for_new_coin_unsafe`.
    ///  - `set_priority`.
    total_priorities: u64,

    /// Holds all of the `Vault`'s idle liquidity through a `TypeName` -> `Coin<CoinType>` mapping.
    funds: ObjectBag,
    /// Holds all collected fees through a `TypeName` -> `Coin<CoinType>` mapping.
    fees: ObjectBag,
}

//****************************************** Constructor *****************************************//

/// Creates and shares a new `Vault`. The `TreasuryCap<MetaCoin>` is converted to a `Supply<MetaCoin>` and stored within the `Vault`. The `CoinMetadata<MetaCoin>` is only required to query the `Coin<MetaCoin>`'s `decimal`s value.
///
/// After calling `create_vault`, the admin will need to call `add_support_for_new_coin` /
/// `add_support_for_new_coin_unsafe` before the `Vault` can be publicly interacted with.
///
/// Aborts:
///   i. [meta_vault::version::EInvalidVersion]
///  ii. [meta_vault::vault::ETreasuryCapMustHaveZeroValue]
public fun create_vault<MetaCoin>(
    _: &AdminCap,
    version: &Version,
    treasury_cap: TreasuryCap<MetaCoin>,
    coin_metadata: &CoinMetadata<MetaCoin>,
    ctx: &mut TxContext
) {
    abort 404
}

//******************************************** Getters *******************************************//

/// Returns the total amount of `Coin<MetaCoin>` that has been minted.
public fun supply_value<MetaCoin>(
    vault: &Vault<MetaCoin>,
): u64 {
    abort 404
}

#[syntax(index)]
/// Returns a read only reference to the `Metadata` object keyed by `type_name` within the
/// `Vault`'s `metadata` registry.
public fun borrow<MetaCoin>(
    vault: &Vault<MetaCoin>,
    type_name: TypeName,
): &Metadata {
    abort 404
}

#[syntax(index)]
/// Returns a mutable only reference to the `Metadata` object keyed by `type_name` within the
/// `Vault`'s `metadata` registry.
fun borrow_mut<MetaCoin>(
    vault: &mut Vault<MetaCoin>,
    type_name: TypeName,
): &mut Metadata {
    abort 404
}

/// Returns the `Coin<CoinType>`s `decimal` value.
public fun decimals_of<MetaCoin, CoinType>(
    vault: &Vault<MetaCoin>,
): u8 {
    abort 404
}

/// Returns the total (idle + active) amount `Coin<CoinType>` held within the `Vault`.
public fun balance_of<MetaCoin, CoinType>(
    vault: &Vault<MetaCoin>,
): u64 {
    abort 404
}

/// Returns the `Vault`'s priority to hold the given `CoinType`.
public fun priority_of<MetaCoin, CoinType>(
    vault: &Vault<MetaCoin>,
): u64 {
    abort 404
}

//*************************************** Mutators [Public] **************************************//

/// Swaps an input coin (`Coin<CoinIn>`) for a desired output coin (`Coin<CoinOut>`) using a
/// common intermediary asset (`Coin<MetaCoin>`) to determine the equivalent value of the
/// two assets. The exchange rates between the three assets are provided through the
/// `DepositCap` and `WithdrawCap` inputs.
///
/// The `Vault`'s `deposit_cap` field associated with the `CoinIn` type restricts the total
/// `Balance<CoinIn>` it can hold.
///
/// This function assumes that the `Vault` has sufficient [active] liquidity for both the input and output coins.
///
/// Aborts:
///   i. [meta_vault::version::EInvalidVersion]
///  ii. [meta_vault::vault::EZeroValue]
/// iii. [meta_vault::vault::ECoinIsNotSupported]
///  iv. [meta_vault::vault::ENotEnoughSpaceToHandleDeposit]
///   v. [meta_vault::vault::ENotEnoughLiquidityToHandleWithdraw]
public fun swap<MetaCoin, CoinIn, CoinOut>(
    vault: &mut Vault<MetaCoin>,
    version: &Version,
    deposit_cap: DepositCap<MetaCoin, CoinIn>,
    withdraw_cap: WithdrawCap<MetaCoin, CoinOut>,
    coin_in: Coin<CoinIn>,
    min_amount_out: u64,
    ctx: &mut TxContext,
): Coin<CoinOut> {
    abort 404
}

/// Deposits an input coin (`Coin<CoinIn>`) into the `Vault` and mints an equivalent worth
/// of `Coin<MetaCoin>`.
///
/// A `DepositCap` must first be obtained from the `CoinIn`'s `whitelisted_app_id`. This
/// `DepositCap` holds the exchange rate between `Coin<CoinIn>` -> `Coin<CoinMeta>`.
///
/// The `Vault`'s `deposit_cap` field associated with the `CoinIn` type restricts the
/// total `Balance<CoinIn>` it can hold.
///
/// Aborts:
///   i. [meta_vault::version::EInvalidVersion]
///  ii. [meta_vault::vault::EZeroValue]
/// iii. [meta_vault::vault::ECoinIsNotSupported]
///  iv. [meta_vault::vault::ENotEnoughSpaceToHandleDeposit]
public fun deposit<MetaCoin, CoinIn>(
    vault: &mut Vault<MetaCoin>,
    version: &Version,
    deposit_cap: DepositCap<MetaCoin, CoinIn>,
    coin_in: Coin<CoinIn>,
    min_amount_out: u64,
    ctx: &mut TxContext,
): Coin<MetaCoin> {
    abort 404
}

/// Burns the input `Coin<MetaCoin>` and withdraws an equivalent worth of `Coin<CoinOut>` from
/// the `Vault`.
///
/// A `WithdrawCap` must first be obtained from the `CoinOut`'s `whitelisted_app_id`. This
/// `WithdrawCap` holds the exchange rate between `Coin<CoinMetaCoin>` -> `Coin<CoinOut>`.
///
/// Aborts:
///   i. [meta_vault::version::EInvalidVersion]
///  ii. [meta_vault::vault::ENotEnoughLiquidityToHandleWithdraw]
public fun withdraw<MetaCoin, CoinOut>(
    vault: &mut Vault<MetaCoin>,
    version: &Version,
    withdraw_cap: WithdrawCap<MetaCoin, CoinOut>,
    meta_coin: Coin<MetaCoin>,
    min_amount_out: u64,
    ctx: &mut TxContext,
): Coin<CoinOut> {
    abort 404
}

//****************************** Mutators [Permissioned] [AdminCap] ******************************//

/// Whitelist the `Coin<NewCoin>` type within the `Vault`. This allows `Coin<NewCoin>` to be
/// deposited into and subsequently within from the `Vault`. All fields underlying the `Metadata`
/// struct must be passed in as input. A `Metadata` struct corresponding with this `Coin<NewCoin>`
/// is created and added to the `Vault`s `metadata` registry.
///
/// Only the holder of the `AdminCap` can create a new `Vault`.
///
/// Aborts:
///   i. [meta_vault::version::EInvalidVersion]
///  ii. [meta_vault::version::EAlreadySupported]
public fun add_support_for_new_coin<MetaCoin, NewCoin>(
    admin_cap: &AdminCap,
    version: &Version,
    vault: &mut Vault<MetaCoin>,
    whitelisted_app_id: address,
    deposit_cap: u64,
    min_fee: u64,
    max_fee: u64,
    priority: u64,
    coin_metadata: &CoinMetadata<NewCoin>,
    ctx: &mut TxContext,
) {
    abort 404
}

use fun add_support_for_new_coin_unsafe as AdminCap.add_support_for_new_coin_unsafe;
/// Important: this function takes a `Coin<NewCoin>` `decimals` value directly instead of obtaining
/// from the `CoinMetadata<NewCoin>` struct. The safe variant of this function should always be
/// preferred. This variant is only provided to cover an edge case where the `CoinMetadata` struct
/// cannot be accessed to be passed in as input to `add_support_for_new_coin`.
///
/// Whitelist the `Coin<NewCoin>` type within the `Vault`. This allows `Coin<NewCoin>` to be
/// deposited into and subsequently within from the `Vault`. All fields underlying the `Metadata`
/// struct must be passed in as input. A `Metadata` struct corresponding with this `Coin<NewCoin>`
/// is created and added to the `Vault`s `metadata` registry.
///
/// Only the holder of the `AdminCap` can create a new `Vault`.
///
/// Aborts:
///   i. [meta_vault::version::EInvalidVersion]
///  ii. [meta_vault::version::EAlreadySupported]
public fun add_support_for_new_coin_unsafe<MetaCoin, NewCoin>(
    _: &AdminCap,
    version: &Version,
    vault: &mut Vault<MetaCoin>,
    whitelisted_app_id: address,
    deposit_cap: u64,
    min_fee: u64,
    max_fee: u64,
    priority: u64,
    decimals: u8,
    ctx: &mut TxContext,
) {
    abort 404
}

/// Allows the admin to withdraw all of the collected `Coin<CoinType>` fees.
///
/// Aborts:
///   i. [meta_vault::version::EInvalidVersion]
///  ii. [meta_vault::vault::ECoinIsNotSupported]
public fun withdraw_fees<MetaCoin, CoinType>(
    _: &AdminCap,
    version: &Version,
    vault: &mut Vault<MetaCoin>,
    ctx: &mut TxContext
): Coin<CoinType> {
    abort 404
}

/// Creates a new `VaultAssistantCap` and sets the `Vault`'s `active_assitant_id` field to its
/// `ID`. This function is meant as a safety net in case an address owning a `VaultAssistantCap`
/// is compromised.
///

/// As the old `VaultAssistantCap` is owned by a seperate address, this function only  removes
/// the previous `VaultAssistantCap`s ability to call any permissioned function for the `Vault`
/// without destroying the old `VaultAssistantCap` object.
///
/// Aborts:
///   i. [meta_vault::version::EInvalidVersion]
///  ii. [meta_vault::vault::ECoinIsNotSupported]
public fun rotate_assistant_cap<MetaCoin>(
    _: &AdminCap,
    version: &Version,
    vault: &mut Vault<MetaCoin>,
    recipient: address,
    ctx: &mut TxContext,
) {
    abort 404
}

/// Updates the `deposit_cap` field in the `Coin<CoinType>`'s `Metadata` object  within the
/// `Vault`.
///
/// Aborts:
///   i. [meta_vault::version::EInvalidVersion]
///  ii. [meta_vault::vault::ECoinIsNotSupported]
public fun set_deposit_cap<MetaCoin, CoinType>(
    _: &AdminCap,
    version: &Version,
    vault: &mut Vault<MetaCoin>,
    new_deposit_cap: u64,
) {
    abort 404
}

/// Updates the `balance` field in the `Coin<CoinType>`'s `Metadata` object  within the `Vault`.
///
/// Aborts:
///   i. [meta_vault::version::EInvalidVersion]
///  ii. [meta_vault::vault::ECoinIsNotSupported]
public fun set_balance<MetaCoin, CoinType>(
    _: &AdminCap,
    version: &Version,
    vault: &mut Vault<MetaCoin>,
    new_balance: u64,
) {
    abort 404
}

/// Updates the `whitelisted_app_id` field in the `Coin<CoinType>`'s `Metadata` object  within the
/// `Vault`.
///
/// Aborts:
///   i. [meta_vault::version::EInvalidVersion]
///  ii. [meta_vault::vault::ECoinIsNotSupported]
public fun set_whitelisted_app_id<MetaCoin, CoinType>(
    _: &AdminCap,
    version: &Version,
    vault: &mut Vault<MetaCoin>,
    new_whitelisted_app_id: address,
) {
    abort 404
}

/// Updates the `priority` field in the `Coin<CoinType>`'s `Metadata` object  within the `Vault`.
///
/// Aborts:
///   i. [meta_vault::version::EInvalidVersion]
///  ii. [meta_vault::vault::ECoinIsNotSupported]
public fun set_priority<MetaCoin, CoinType>(
    _: &AdminCap,
    version: &Version,
    vault: &mut Vault<MetaCoin>,
    new_priority: u64,
) {
    abort 404
}

/// Updates the `min_fee` field in the `Coin<CoinType>`'s `Metadata` object  within the `Vault`.
///
/// Aborts:
///   i. [meta_vault::version::EInvalidVersion]
///  ii. [meta_vault::vault::ECoinIsNotSupported]
public fun set_min_fee<MetaCoin, CoinType>(
    _: &AdminCap,
    version: &Version,
    vault: &mut Vault<MetaCoin>,
    new_min_fee: u64,
) {
    abort 404
}

/// Updates the `max_fee` field in the `Coin<CoinType>`'s `Metadata` object  within the `Vault`.
///
/// Aborts:
///   i. [meta_vault::version::EInvalidVersion]
///  ii. [meta_vault::vault::ECoinIsNotSupported]
public fun set_max_fee<MetaCoin, CoinType>(
    _: &AdminCap,
    version: &Version,
    vault: &mut Vault<MetaCoin>,
    new_max_fee: u64,
) {
    abort 404
}

/// Updates the `flash_loan_fee` field in the `Coin<CoinType>`'s `Metadata` object  within the
/// `Vault`.
///
/// Aborts:
///   i. [meta_vault::version::EInvalidVersion]
///  ii. [meta_vault::vault::ECoinIsNotSupported]
public fun set_flash_loan_fee<MetaCoin, CoinType>(
    _: &AdminCap,
    version: &Version,
    vault: &mut Vault<MetaCoin>,
    new_flash_loan_fee: u64,
) {
    abort 404
}

/// Updates the `decimals` field in the `Coin<CoinType>`'s `Metadata` object  within the `Vault`.
///
/// Aborts:
///   i. [meta_vault::version::EInvalidVersion]
///  ii. [meta_vault::vault::ECoinIsNotSupported]
public fun set_decimals<MetaCoin, CoinType>(
    _: &AdminCap,
    version: &Version,
    vault: &mut Vault<MetaCoin>,
    new_decimals: u8,
) {
    abort 404
}

//************************** Mutators [Permissioned] [VaultAssistantCap] *************************//

/// Updates the `min_fee` field in the `Coin<CoinType>`'s `Metadata` object  within the `Vault`.
///
/// Aborts:
///   i. [meta_vault::version::EInvalidVersion]
///  ii. [meta_vault::vault::ECoinIsNotSupported]
public fun assistant_set_min_fee<MetaCoin, CoinType>(
    vault_assistant_cap: &VaultAssistantCap,
    version: &Version,
    vault: &mut Vault<MetaCoin>,
    new_min_fee: u64,
) {
    abort 404
}

/// Updates the `max_fee` field in the `Coin<CoinType>`'s `Metadata` object  within the `Vault`.
///
/// Aborts:
///   i. [meta_vault::version::EInvalidVersion]
///  ii. [meta_vault::vault::ECoinIsNotSupported]
public fun assistant_set_max_fee<MetaCoin, CoinType>(
    vault_assistant_cap: &VaultAssistantCap,
    version: &Version,
    vault: &mut Vault<MetaCoin>,
    new_max_fee: u64,
) {
    abort 404
}


/// Allows the active `VaultAssistantCap` to perform a fee-less flash loan. See `begin_flash_loan` for more info.
///
/// Aborts:
///   i. [meta_vault::version::EInvalidVersion]
///  ii. [meta_vault::vault::ECoinIsNotSupported]
public fun assistant_begin_flash_loan<MetaCoin, CoinType>(
    vault_assistant_cap: &VaultAssistantCap,
    vault: &mut Vault<MetaCoin>,
    version: &Version,
    amount: u64,
    ctx: &mut TxContext,
): (Coin<CoinType>, FlashLoanReceipt<MetaCoin, CoinType>) {
    abort 404
}

//************************************************************************************************//
// DepositCap                                                                                     //
//************************************************************************************************//

/// Grants the holder the ability to deposit coins *into* a `Vault`; i.e., a `DepositCap` must
///  be acquired before the holder can call `deposit` or `swap`.
public struct DepositCap<phantom MetaCoin, phantom CoinIn> /* has hot_potato */ {
    /// The current exchange rate of `Coin<MetaCoin>` to `Coin<CoinIn>`. This exchange rate
    /// must be acquired from a trusted source (e.g., an oracle or on-chain-derived exchange
    /// rate).
    exchange_rate_meta_coin_to_coin_in: u128,
}

//****************************************** Constructor *****************************************//

/// Create a `DepositCap` with a provided, trusted exchange rate. An authorized `UID` is required as
/// input; i.e., the admin must have both called `authorize` on the respective singleton object
/// that the `UID` corresponds to and the admin must have set the `whitelisted_app_id` field of
/// the `Vault`'s `Coin<CoinIn>`-associated `Metadata` field to the singleton's `ID`.
///
/// Aborts:
///   i. [meta_vault::admin::ENotAuthorized]
///  ii. [meta_vault::vault::EInvalidAppWasUsedToCreateDepositCap]
public fun create_deposit_cap<MetaCoin, CoinIn>(
    app_id: &UID,
    vault: &Vault<MetaCoin>,
    exchange_rate_meta_coin_to_coin_in: u128,
): DepositCap<MetaCoin, CoinIn> {
    abort 404
}

//************************************************************************************************//
// WithdrawCap                                                                                    //
//************************************************************************************************//

/// Grants the holder the ability to withdraw coins *from* the `Vault`; i.e., a `WithdrawCap` must
/// be aquired before the holder can call `withdraw` or `swap`.
public struct WithdrawCap<phantom MetaCoin, phantom CoinOut> /* has hot_potato */ {
    /// The current exchange rate of `Coin<MetaCoin>` to `Coin<CoinOut>`. This exchange rate
    /// rate must be acquired from a trusted source (e.g., an oracle or on-chain-derived exchange
    /// rate).
    exchange_rate_meta_coin_to_coin_out: u128,
}

//******************************************* Constructor ****************************************//

/// Create a `WithdrawCap` with a provided, trusted exchange rate. An authorized `UID` is required as
/// input; i.e., the admin must have both called `authorize` on the respective singleton object
/// that the `UID` corresponds to and the admin must have set the `whitelisted_app_id` field of
/// the `Vault`'s `Coin<CoinIn>`-associated `Metadata` field to the singleton's `ID`.
///
/// Aborts:
///   i. [meta_vault::admin::ENotAuthorized]
///  ii. [meta_vault::vault::EInvalidAppWasUsedToCreateWithdrawCap]
public fun create_withdraw_cap<MetaCoin, CoinOut>(
    app_id: &UID,
    vault: &Vault<MetaCoin>,
    exchange_rate_meta_coin_to_coin_out: u128,
): WithdrawCap<MetaCoin, CoinOut> {
    abort 404
}

//************************************************************************************************//
// FlashLoanReceipt                                                                               //
//************************************************************************************************//

/// Hot-potato object granting the holder the ability to perform a flash loan. This object is
/// created during `begin_flash_loan` and must be destroyed in `finish_flash_loan`.
public struct FlashLoanReceipt<phantom MetaCoin, phantom CoinType> /* has hot_potato */ {
    /// The amount of `Coin<CoinType>` borrowed.
    amount: u64,
    /// The fee that must be paid.
    fee: u64,
}

//****************************************** Constructor *****************************************//

/// Pulls `amount` of `Coin<CoinType>` from the `Vault` and returns it to caller with an
/// associated `FlashLoanReceipt` hot-potato object. `finish_flash_loan` must be called to
/// destroy the `FlashLoanReceiptObject` and repay the loan's fee.
///
/// Aborts:
///   i. [meta_vault::version::EInvalidVersion]
///  ii. [meta_vault::vault::ECoinIsNotSupported]
public fun begin_flash_loan<MetaCoin, CoinType>(
    vault: &mut Vault<MetaCoin>,
    version: &Version,
    amount: u64,
    ctx: &mut TxContext,
): (Coin<CoinType>, FlashLoanReceipt<MetaCoin, CoinType>) {
    abort 404
}

//***************************************** Deconstructor ****************************************//


/// Destroys a `FlashLoanReceipt` object, repays the associated fee, and returns all borrowed
/// `Coin<CoinType>` to the `Vault`.
///
/// Aborts:
///   i. [meta_vault::version::EInvalidVersion]
public fun finish_flash_loan<MetaCoin, CoinType>(
    vault: &mut Vault<MetaCoin>,
    version: &Version,
    mut coin_in: Coin<CoinType>,
    receipt: FlashLoanReceipt<MetaCoin, CoinType>,
    ctx: &mut TxContext,
) {
    abort 404
}

//************************************************************************************************//
// Internal Functions                                                                             //
//************************************************************************************************//

/// Mint a `Coin<MetaCoin>` object with a value of `amount`.
fun mint<MetaCoin>(
    vault: &mut Vault<MetaCoin>,
    amount: u64,
    ctx: &mut TxContext,
): Coin<MetaCoin> {
    abort 404
}

/// Burn the provided `Coin<MetaCoin>` object.
fun burn<MetaCoin>(
    vault: &mut Vault<MetaCoin>,
    coin: Coin<MetaCoin>,
) {
    abort 404
}

///
fun join_fee<MetaCoin, CoinIn>(
    vault: &mut Vault<MetaCoin>,
    coin: Coin<CoinIn>,
) {
    abort 404
}

/// Add liquidity to the `Vault` and enforce the `Coin<CoinIn>`'s respective deposit cap.
///
/// Aborts:
///   i. [meta_vault::vault::EZeroValue]
///  ii. [meta_vault::vault::ECoinIsNotSupported]
/// iii. [meta_vault::vault::ENotEnoughSpaceToHandleDeposit]
fun join<MetaCoin, CoinIn>(
    vault: &mut Vault<MetaCoin>,
    coin_in: Coin<CoinIn>,
) {
    abort 404
}

/// Remove liquidity from the `Vault` and charge the `Vault`'s dynamic fee on the withdrawn
/// `Coin<CoinOut>`.
///
/// Aborts:
///   i. [meta_vault::vault::ENotEnoughLiquidityToHandleWithdraw]
fun split<MetaCoin, CoinOut>(
    vault: &mut Vault<MetaCoin>,
    coin_out_amount: u64,
    dynamic_fee_params: DynamicFeeParams,
    ctx: &mut TxContext,
): Coin<CoinOut> {
    abort 404
}

/// Take the `Vault`'s dynamic fee on `coin_out`. This function is handled directly within the
/// `Vault`'s `split` function and thus automatically occurs whenever liquidity is withdrawn
/// from the `Vault`.
///
/// Take a look at `meta_vault::math::calculate_dynamic_fee` for more details on the dynamic fee
/// calculation.
fun take_fee<MetaCoin, CoinOut>(
    vault: &mut Vault<MetaCoin>,
    coin_out: &mut Coin<CoinOut>,
    dynamic_fee_params: DynamicFeeParams,
    ctx: &mut TxContext,
) {
    abort 404
}

/// Calculate how much of the `Vault`'s TVL should be denominated in `Coin<CoinOut>`. For more
/// context, read the doc comment for `DynamicFeeParams`.
fun calculate_target_liquidity_of_coin_out<MetaCoin, CoinOut>(
    vault: &Vault<MetaCoin>,
    dynamic_fee_params: DynamicFeeParams,
): u64 {
    abort 404
}

/// Calculate the `Vault`'s target liquidity of `Coin<CoinOut>` in absolute terms; i.e., how much
/// of its entire TVL should be denominated in `Coin<CoinOut>`.
fun calculate_absolute_target_liquidity_of_coin_out<MetaCoin, CoinOut>(
    vault: &Vault<MetaCoin>,
    exchange_rate_meta_coin_to_coin_out: u128,
): u64 {
    abort 404
}

/// Calculate the `Vault`'s target liquidity of `Coin<CoinOut>` in relative terms; i.e., between
/// the two assets types being interacted with, how much of the `Vault`'s TVL of these assets
/// should be denominated in `Coin<CoinOut>`.
fun calculate_relative_target_liquidity_of_coin_out<MetaCoin, CoinOut>(
    vault: &Vault<MetaCoin>,
    exchange_rate_meta_coin_to_coin_out: u128,
    exchange_rate_meta_coin_to_coin_in: u128,
    coin_in_type_name: TypeName,
): u64 {
    abort 404
}

/// Convert an amount of `Coin<CoinIn>` to its equivalent amount of `Coin<CoinOut>`.
fun convert_coin_in_amount_to_coin_out_amount<MetaCoin, CoinIn, CoinOut>(
    vault: &Vault<MetaCoin>,
    coin_in_amount: u64,
    exchange_rate_meta_coin_to_coin_in: u128,
    exchange_rate_meta_coin_to_coin_out: u128,
): u64 {
    abort 404
}

/// Convert an amount of `Coin<CoinIn>` to its equivalent amount of `Coin<MetaCoin>`.
fun convert_coin_in_amount_to_meta_coin_amount<MetaCoin, CoinIn>(
    vault: &Vault<MetaCoin>,
    coin_in_amount: u64,
    exchange_rate_meta_coin_to_coin_in: u128,
): u64 /* meta_coin_amount */ {
    abort 404
}

/// Convert an amount of `Coin<MetaCoin>` to its equivalent amount of `Coin<CoinOut>`.
fun convert_meta_coin_amount_to_coin_out_amount<MetaCoin, CoinOut>(
    vault: &Vault<MetaCoin>,
    meta_coin_amount: u64,
    exchange_rate_meta_coin_to_coin_out: u128,
): u64 /* coin_out_amount */ {
    abort 404
}

use fun apply_exchange_rate as u64.apply_exchange_rate;
/// Convert `coin_in_amount` to its `coin_out_amount` equivalent using their respective
/// `exchange_rate_meta_coin_to_coin_in` and `exchange_rate_meta_coin_to_coin_out` exchange rates
/// as well as both `Coin` type's `decimals` for normalization.
fun apply_exchange_rate(
    coin_in_amount: u64,
    exchange_rate_meta_coin_to_coin_in: u128,
    exchange_rate_meta_coin_to_coin_out: u128,
    coin_in_decimals: u8,
    coin_out_decimals: u8,
): u64 {
    abort 404
}
