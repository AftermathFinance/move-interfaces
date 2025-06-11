// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

/// Module: exchange_rate
module meta_vault_stsui_integration::exchange_rate;

use meta_vault_lst_exchange_rate_registry::registry::Registry;

use meta_vault::vault::{Vault, DepositCap, WithdrawCap};
use meta_vault::math::exchange_rate_one_to_one;
use meta_vault::version::Version;
use meta_vault::admin::AdminCap;

use liquid_staking::liquid_staking::LiquidStakingInfo;
use stsui::stsui::STSUI;

use sui::coin::CoinMetadata;

//************************************************************************************************//
// MetaVaultStSuiIntegration                                                                      //
//************************************************************************************************//

/// This singleton object allows mimicing `public(package)` across package boundaries through
/// the Object Auth pattern.
///
/// The `MetaVault` package's `AdminCap` must grant this object the authority to call
/// `create_deposit_cap` and `create_withdraw_cap`.
public struct MetaVaultStSuiIntegration has key, store {
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

/// Grant the `MetaVaultStSuiIntegration` object the ability to call `create_deposit_cap` and
/// `create_withdraw_cap`.
public fun authorize(
    admin_cap: &AdminCap,
    wrapper: &mut MetaVaultStSuiIntegration,
) {
    abort 404
}

/// Revoke the ability for the `MetaVaultStSuiIntegration` object to call `create_deposit_cap` and
/// `create_withdraw_cap`.
public fun deauthorize(
    admin_cap: &AdminCap,
    wrapper: &mut MetaVaultStSuiIntegration,
) {
    abort 404
}

//************************************************************************************************//
// DepositCap                                                                                     //
//************************************************************************************************//

/// Get the exchange rate between a meta-coin and stSUI in 10^18 fixed point. This wrapper should
/// only be used for cases where the `MetaVault` is denominated in SUI, in which case the
/// meta-coin:stSUI exchange rate is equivalent to the SUI:stSUI exchange rate. This exchange rate
/// is queried directly from the `liquid_staking` package.
///
///  e.g.   1stSUI:1SUI = 1__000_000_000_000_000_000,
///       1stSUI:1.5SUI = 1__500_000_000_000_000_000.
///
/// Aborts:
///   i. [meta_vault::admin::ENotAuthorized]
///  ii. [meta_vault::vault::EInvalidAppWasUsedToCreateDepositCap]
public fun create_deposit_cap<MetaCoin>(
    wrapper: &MetaVaultStSuiIntegration,
    vault: &Vault<MetaCoin>,
    registry: &mut Registry,
): DepositCap<MetaCoin, STSUI> {
    abort 404
}

//************************************************************************************************//
// WithdrawCap                                                                                    //
//************************************************************************************************//

/// Get the exchange rate between a meta-coin and stSUI in 10^18 fixed point. This wrapper should
/// only be used for cases where the `MetaVault` is denominated in SUI, in which case the
/// meta-coin:stSUI exchange rate is equivalent to the SUI:stSUI exchange rate. This exchange rate
/// is queried directly from the `liquid_staking` package.
///
///  e.g.   1stSUI:1SUI = 1__000_000_000_000_000_000,
///       1stSUI:1.5SUI = 1__500_000_000_000_000_000.
///
/// Aborts:
///   i. [meta_vault::admin::ENotAuthorized]
///  ii. [meta_vault::vault::EInvalidAppWasUsedToCreateWithdrawCap]
public fun create_withdraw_cap<MetaCoin>(
    wrapper: &MetaVaultStSuiIntegration,
    vault: &Vault<MetaCoin>,
    registry: &mut Registry,
): WithdrawCap<MetaCoin, STSUI> {
    abort 404
}

//************************************************************************************************//
// Public Functions                                                                               //
//************************************************************************************************//

/// Query the `stSUI:SUI` exchange rate from the `stSUI` package and set it within the `Registry`.
///
/// Aborts:
///    i. [meta_vault::admin::ENotAuthorized]
public fun update_exchange_rate(
    wrapper: &MetaVaultStSuiIntegration,
    registry: &mut Registry,
    staked_sui_vault: &LiquidStakingInfo<STSUI>,
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
public fun add_support_for_new_coin<MetaCoin>(
    wrapper: &MetaVaultStSuiIntegration,
    admin_cap: &AdminCap,
    version: &Version,
    vault: &mut Vault<MetaCoin>,
    whitelisted_app_id: address,
    deposit_cap: u64,
    min_fee: u64,
    max_fee: u64,
    priority: u64,
    coin_metadata: &CoinMetadata<STSUI>,
    registry: &mut Registry,
    staked_sui_vault: &LiquidStakingInfo<STSUI>,
    ctx: &mut TxContext,
) {
    abort 404
}

//************************************************************************************************//
// Internal Functions                                                                             //
//************************************************************************************************//

/// Return the exchange rate of `Coin<STSUI>` to `COIN<SUI>` normalized to 10^18. e.g. an exchange
///  rate of 10^18 means you can exchange `Coin<STSUI>` 1:1 to `COIN<SUI>`.
fun stsui_to_sui_exchange_rate(
    staked_sui_vault: &LiquidStakingInfo<STSUI>,
): u128 {
    abort 404
}
