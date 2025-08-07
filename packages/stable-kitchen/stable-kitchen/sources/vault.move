// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_variable, unused_field, unused_function, unused_let_mut, unused_mut_parameter)]
module stable_kitchen::vault;

use stable_kitchen::authority::{AuthorityCap, VAULT, ADMIN};
use stable_kitchen::config::Config;

use sui::coin::{Coin, CoinMetadata, TreasuryCap};
use sui::balance::Balance;
use sui::clock::Clock;

use std::type_name::TypeName;

//************************************************************************************************//
// CreateVaultCap                                                                                 //
//************************************************************************************************//

public struct CreateVaultCap<phantom QuoteStable> has key, store {
    id: UID,
}

//****************************************** Constructor *****************************************//

public fun to_create_vault_cap<QuoteStable>(
    treasury_cap: TreasuryCap<QuoteStable>,
    coin_metadata: CoinMetadata<QuoteStable>,
    ctx: &mut TxContext,
): CreateVaultCap<QuoteStable> {
    abort 404
}

//******************************************* Mutators ******************************************//

public fun update_coin_metadata<QuoteStable>(
    cap: &mut CreateVaultCap<QuoteStable>,
    symbol: vector<u8>,
    name: vector<u8>,
    description: vector<u8>,
    icon_url: Option<vector<u8>>,
) {
    abort 404
}

//***************************************** Deconstructor ****************************************//

fun unwrap<QuoteStable>(
    mut cap: CreateVaultCap<QuoteStable>,
): (TreasuryCap<QuoteStable>, CoinMetadata<QuoteStable>) {
    abort 404
}

//************************************************************************************************//
// RewardKey                                                                                      //
//************************************************************************************************//

public struct RewardKey(TypeName) has copy, drop, store;

//****************************************** Constructor *****************************************//

fun from(type_name: TypeName): RewardKey {
    abort 404
}

//************************************************************************************************//
// RewardValue                                                                                    //
//************************************************************************************************//

public struct RewardValue<phantom CoinType> has key, store {
    id: UID,
    /// A backwards link of the `ID` of the `Vault` that this `RewardValue` is associated with.
    vault: ID,
    /// The `Balance<Reward>` that is deposited into the `Vault`.
    balance: Balance<CoinType>,
}

//****************************************** Constructor *****************************************//

fun default<CoinType>(
    vault: ID,
    ctx: &mut TxContext,
): RewardValue<CoinType> {
    abort 404
}

//************************************************************************************************//
// Vault                                                                                          //
//************************************************************************************************//

public struct Vault<phantom BaseStable, phantom QuoteStable> has key, store {
    id: UID,

    /// Used to mint and burn `Coin<QuoteStable>`.
    treasury_cap: TreasuryCap<QuoteStable>,

    /// Underlying liquidity of `Coin<BaseStable>` that backs the minted `Coin<QuoteStable>`.
    funds: Balance<BaseStable>,

    /// Underlying fees that are collected when burning `Coin<QuoteStable>`.
    fees: Balance<BaseStable>,

    /// Fee that is charged when burning `Coin<QuoteStable>`.
    fee_bps: u64,

    creator: address,
    created_at_timestamp_ms: u64,

    active_assistant: ID,
}

//****************************************** Constructor *****************************************//

/// Create a new `Vault` object that is capable of minting and burning `Coin<QuoteStable>`.
///
/// Aborts:
///   i. [stable_kitchen::config::EInvalidVersion]
///  ii. [stable_kitchen::config::ENotWhitelisted]
/// iii. [stable_kitchen::config::EInvalidFeeBps]
///  iv. [stable_kitchen::vault::EInvalidTreasuryCap]
///   v. [stable_kitchen::vault::EInvalidDecimals]
public fun new<BaseStable, QuoteStable>(
    config: &Config,
    create_vault_cap: CreateVaultCap<QuoteStable>,
    base_metadata: &CoinMetadata<BaseStable>,
    fee_bps: u64,
    clock: &Clock,
    ctx: &mut TxContext,
): (Vault<BaseStable, QuoteStable>, AuthorityCap<VAULT, ADMIN>) {
    abort 404
}

//******************************************** Getters *******************************************//

public fun total_supply<BaseStable, QuoteStable>(
    vault: &Vault<BaseStable, QuoteStable>,
): u64 {
    abort 404
}

public fun total_liquidity<BaseStable, QuoteStable>(
    vault: &Vault<BaseStable, QuoteStable>,
): u64 {
    abort 404
}

//******************************************* Mutators ******************************************//

/// Deposit `coin_in` into the vault and mint an equivalent amount of `Coin<QuoteStable>`.
///
/// Aborts:
///   i. [stable_kitchen::config::EInvalidVersion]
public fun mint<BaseStable, QuoteStable>(
    vault: &mut Vault<BaseStable, QuoteStable>,
    config: &Config,
    coin_in: Coin<BaseStable>,
    ctx: &mut TxContext,
): Coin<QuoteStable> {
    abort 404
}

/// Burn `coin_in` and withdraw an equivalent amount of `Coin<BaseStable>` from the vault.
///
/// Aborts:
///   i. [stable_kitchen::config::EInvalidVersion]
public fun burn<BaseStable, QuoteStable>(
    vault: &mut Vault<BaseStable, QuoteStable>,
    config: &Config,
    coin_in: Coin<QuoteStable>,
    ctx: &mut TxContext,
): Coin<BaseStable> {
    abort 404
}

/// Add `Coin<BaseStable>` to the `Vault`'s funds, without minting any new `Coin<QuoteStable>`.
///
/// Aborts:
///   i. [stable_kitchen::config::EInvalidVersion]
public fun add_yield<BaseStable, QuoteStable>(
    vault: &mut Vault<BaseStable, QuoteStable>,
    config: &Config,
    coin: Coin<BaseStable>,
) {
    abort 404
}

/// Deposit rewards into the `Vault` that can be later withdraw by the `Vault`'s Admin or Assistant.
///
/// Aborts:
///   i. [stable_kitchen::config::EInvalidVersion]
public fun deposit_reward<BaseStable, QuoteStable, Reward>(
    vault: &mut Vault<BaseStable, QuoteStable>,
    config: &Config,
    coin: Coin<Reward>,
    ctx: &mut TxContext,
) {
    abort 404
}

//****************************** Mutators [AuthorityCap<Vault, ---->] ****************************//

/// Aborts:
///   i. [stable_kitchen::config::EInvalidVersion]
///  ii. [stable_kitchen::vault::EInvalidAuthorityCap]
/// iii. [stable_kitchen::config::EInvalidFeeBps]
public fun set_fee_bps<Role, BaseStable, QuoteStable>(
    vault: &mut Vault<BaseStable, QuoteStable>,
    authority_cap: &AuthorityCap<VAULT, Role>,
    config: &Config,
    fee_bps: u64,
) {
    abort 404
}

/// Aborts:
///   i. [stable_kitchen::config::EInvalidVersion]
///  ii. [stable_kitchen::vault::EInvalidAuthorityCap]
public fun withdraw_fees<Role, BaseStable, QuoteStable>(
    vault: &mut Vault<BaseStable, QuoteStable>,
    authority_cap: &AuthorityCap<VAULT, Role>,
    config: &Config,
    ctx: &mut TxContext,
): Coin<BaseStable> {
    abort 404
}

/// Withdraw all rewards that have been deposited into the `Vault`.
///
/// Aborts:
///   i. [stable_kitchen::config::EInvalidVersion]
///  ii. [stable_kitchen::vault::EInvalidAuthorityCap]
public fun withdraw_reward<Role, BaseStable, QuoteStable, Reward>(
    vault: &mut Vault<BaseStable, QuoteStable>,
    authority_cap: &AuthorityCap<VAULT, Role>,
    config: &Config,
    ctx: &mut TxContext,
): Coin<Reward> {
    abort 404
}
