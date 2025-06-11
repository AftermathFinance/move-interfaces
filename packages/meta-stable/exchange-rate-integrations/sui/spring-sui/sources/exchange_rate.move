// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

/// Module: exchange_rate
module meta_vault_spring_sui_integration::exchange_rate;

use meta_vault_lst_exchange_rate_registry::registry::Registry;

use meta_vault::vault::{Vault, DepositCap, WithdrawCap};
use meta_vault::math::exchange_rate_one_to_one;
use meta_vault::version::Version;
use meta_vault::admin::AdminCap;

use liquid_staking::liquid_staking::LiquidStakingInfo;

use sui::coin::CoinMetadata;

//************************************************************************************************//
// MetaVaultSpringSuiIntegration                                                                      //
//************************************************************************************************//

/// This singleton object allows mimicing `public(package)` across package boundaries through
/// the Object Auth pattern.
///
/// The `MetaVault` package's `AdminCap` must grant this object the authority to call
/// `create_deposit_cap` and `create_withdraw_cap`.
public struct MetaVaultSpringSuiIntegration has key, store {
    // [dynamic field] if `authorize` has been called on this object, it will then contain a
    // `meta_vault::admin::AuthKey` -> `meta_vault::admin::AuthCap` dynamic field. If present,
    // this object will have the authority to call `meta_vault::vault::create_deposit_cap` and
    // `meta_vault::vault::create_withdraw_cap`.
    //
    id: UID,
}

//***************************************** Constructors *****************************************//

fun init(ctx: &mut TxContext) {
    abort 404
}

//******************************************* Mutators *******************************************//

/// Grant the `MetaVaultSpringSuiIntegration` object the ability to call `create_deposit_cap` and
/// `create_withdraw_cap`.
public fun authorize(
    admin_cap: &AdminCap,
    wrapper: &mut MetaVaultSpringSuiIntegration,
) {
    abort 404
}

/// Revoke the ability for the `MetaVaultSpringSuiIntegration` object to call `create_deposit_cap` and
/// `create_withdraw_cap`.
public fun deauthorize(
    admin_cap: &AdminCap,
    wrapper: &mut MetaVaultSpringSuiIntegration,
) {
    abort 404
}

//************************************************************************************************//
// DepositCap                                                                                     //
//************************************************************************************************//

/// Get the exchange rate between a meta-coin and LSD in 10^18 fixed point. This wrapper should
/// only be used for cases where the `MetaVault` is denominated in SUI, in which case the
/// meta-coin:LSD exchange rate is equivalent to the SUI:LSD exchange rate. This exchange rate
/// is queried directly from the `liquid_staking` package.
///
///  e.g.   1LST:1SUI = 1__000_000_000_000_000_000,
///       1LST:1.5SUI = 1__500_000_000_000_000_000.
///
/// Aborts:
///   i. [meta_vault::admin::ENotAuthorized]
///  ii. [meta_vault::vault::EInvalidAppWasUsedToCreateDepositCap]
public fun create_deposit_cap<MetaCoin, LSD>(
    wrapper: &MetaVaultSpringSuiIntegration,
    vault: &Vault<MetaCoin>,
    registry: &mut Registry,
): DepositCap<MetaCoin, LSD> {
    abort 404
}

//************************************************************************************************//
// WithdrawCap                                                                                    //
//************************************************************************************************//

/// Get the exchange rate between a meta-coin and LSD in 10^18 fixed point. This wrapper should
/// only be used for cases where the `MetaVault` is denominated in SUI, in which case the
/// meta-coin:LSD exchange rate is equivalent to the SUI:LSD exchange rate. This exchange rate
/// is queried directly from the `liquid_staking` package.
///
///  e.g.   1LST:1SUI = 1__000_000_000_000_000_000,
///       1LST:1.5SUI = 1__500_000_000_000_000_000.
///
/// Aborts:
///   i. [meta_vault::admin::ENotAuthorized]
///  ii. [meta_vault::vault::EInvalidAppWasUsedToCreateWithdrawCap]
public fun create_withdraw_cap<MetaCoin, LSD>(
    wrapper: &MetaVaultSpringSuiIntegration,
    vault: &Vault<MetaCoin>,
    registry: &mut Registry,
): WithdrawCap<MetaCoin, LSD> {
    abort 404
}

//************************************************************************************************//
// Public Functions                                                                               //
//************************************************************************************************//

/// Query the `LSD:SUI` exchange rate from the `LSD` package and set it within the `Registry`.
///
/// Aborts:
///    i. [meta_vault::admin::ENotAuthorized]
public fun update_exchange_rate<LSD>(
    wrapper: &MetaVaultSpringSuiIntegration,
    registry: &mut Registry,
    staked_sui_vault: &LiquidStakingInfo<LSD>,
) {
    abort 404
}

/// This is a helper function that wraps the `Vault`'s `add_support_for_new_coin` + the
/// `Registry`'s `update_exchange_rate`. This function shoould be favored over
/// `add_support_for_new_coin` directly to safely initialize the `Registry` too. See the
/// documentation for `add_support_for_new_coin` and `update_exchange_rate` for more info.
///
/// Aborts:
///   i. [meta_vault::version::EInvalidVersion]
///  ii. [meta_vault::version::EAlreadySupported]
public fun add_support_for_new_coin<MetaCoin, LSD>(
    wrapper: &MetaVaultSpringSuiIntegration,
    admin_cap: &AdminCap,
    version: &Version,
    vault: &mut Vault<MetaCoin>,
    whitelisted_app_id: address,
    deposit_cap: u64,
    min_fee: u64,
    max_fee: u64,
    priority: u64,
    coin_metadata: &CoinMetadata<LSD>,
    registry: &mut Registry,
    staked_sui_vault: &LiquidStakingInfo<LSD>,
    ctx: &mut TxContext,
) {
    abort 404
}

//************************************************************************************************//
// Internal Functions                                                                             //
//************************************************************************************************//

/// Return the exchange rate of `Coin<LSD>` to `COIN<SUI>` normalized to 10^18. e.g. an exchange
///  rate of 10^18 means you can exchange `Coin<LSD>` 1:1 to `COIN<SUI>`.
fun lsd_to_sui_exchange_rate<LSD>(
    staked_sui_vault: &LiquidStakingInfo<LSD>,
): u128 {
    abort 404
}
