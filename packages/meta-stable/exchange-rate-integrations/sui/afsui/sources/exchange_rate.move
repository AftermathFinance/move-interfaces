// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

/// Module: exchange_rate
module meta_vault_afsui_integration::exchange_rate;

use meta_vault_lst_exchange_rate_registry::registry::Registry;

use meta_vault::vault::{Vault, DepositCap, WithdrawCap};
use meta_vault::version::Version;
use meta_vault::admin::AdminCap;

use lsd::staked_sui_vault::StakedSuiVault;
use afsui::afsui::AFSUI;
use safe::safe::Safe;

use sui::coin::{CoinMetadata, TreasuryCap};

//************************************************************************************************//
// MetaVaultAfSuiIntegration                                                                      //
//************************************************************************************************//

/// This singleton object allows mimicing `public(package)` across package boundaries through
/// the Object Auth pattern.
///
/// The `MetaVault` package's `AdminCap` must grant this object the authority to call
/// `create_deposit_cap` and `create_withdraw_cap`.
public struct MetaVaultAfSuiIntegration has key, store {
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

/// Grant the `MetaVaultAfSuiIntegration` object the ability to call `create_deposit_cap` and
/// `create_withdraw_cap`.
public fun authorize(
    admin_cap: &AdminCap,
    wrapper: &mut MetaVaultAfSuiIntegration,
) {
    abort 404
}

/// Revoke the ability for the `MetaVaultAfSuiIntegration` object to call `create_deposit_cap` and
/// `create_withdraw_cap`.
public fun deauthorize(
    admin_cap: &AdminCap,
    wrapper: &mut MetaVaultAfSuiIntegration,
) {
    abort 404
}

//************************************************************************************************//
// DepositCap                                                                                     //
//************************************************************************************************//

/// Get the exchange rate between a meta-coin and afSUI in 10^18 fixed point. This wrapper should
/// only be used for cases where the `MetaVault` is denominated in SUI, in which case the
/// meta-coin:afSUI exchange rate is equivalent to the SUI:afSUI exchange rate. This exchange rate
/// is queried directly from the `AftermathLSD` package.
///
///  e.g.   1afSUI:1SUI = 1__000_000_000_000_000_000,
///       1afSUI:1.5SUI = 1__500_000_000_000_000_000.
///
/// Aborts:
///   i. [meta_vault::admin::ENotAuthorized]
///  ii. [meta_vault::vault::EInvalidAppWasUsedToCreateDepositCap]
public fun create_deposit_cap<MetaCoin>(
    wrapper: &MetaVaultAfSuiIntegration,
    vault: &Vault<MetaCoin>,
    registry: &mut Registry,
): DepositCap<MetaCoin, AFSUI> {
    abort 404
}

//************************************************************************************************//
// WithdrawCap                                                                                    //
//************************************************************************************************//

/// Get the exchange rate between a meta-coin and afSUI in 10^18 fixed point. This wrapper should
/// only be used for cases where the `MetaVault` is denominated in SUI, in which case the
/// meta-coin:afSUI exchange rate is equivalent to the SUI:afSUI exchange rate. This exchange rate
/// is queried directly from the `AftermathLSD` package.
///
///  e.g.   1afSUI:1SUI = 1__000_000_000_000_000_000,
///       1afSUI:1.5SUI = 1__500_000_000_000_000_000.
///
/// Aborts:
///   i. [meta_vault::admin::ENotAuthorized]
///  ii. [meta_vault::vault::EInvalidAppWasUsedToCreateWithdrawCap]
public fun create_withdraw_cap<MetaCoin>(
    wrapper: &MetaVaultAfSuiIntegration,
    vault: &Vault<MetaCoin>,
    registry: &mut Registry,
): WithdrawCap<MetaCoin, AFSUI> {
    abort 404
}

//************************************************************************************************//
// Public Functions                                                                               //
//************************************************************************************************//

/// Query the `afSUI:SUI` exchange rate from the `afSUI` package and set it within the `Registry`.
///
/// Aborts:
///    i. [meta_vault::admin::ENotAuthorized]
public fun update_exchange_rate(
    wrapper: &MetaVaultAfSuiIntegration,
    registry: &mut Registry,
    staked_sui_vault: &StakedSuiVault,
    safe: &Safe<TreasuryCap<AFSUI>>,
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
    wrapper: &MetaVaultAfSuiIntegration,
    admin_cap: &AdminCap,
    version: &Version,
    vault: &mut Vault<MetaCoin>,
    whitelisted_app_id: address,
    deposit_cap: u64,
    min_fee: u64,
    max_fee: u64,
    priority: u64,
    coin_metadata: &CoinMetadata<AFSUI>,
    registry: &mut Registry,
    staked_sui_vault: &StakedSuiVault,
    safe: &Safe<TreasuryCap<AFSUI>>,
    ctx: &mut TxContext,
) {
    abort 404
}

//************************************************************************************************//
// Internal Functions                                                                             //
//************************************************************************************************//

#[allow(unused_function)]
// Note: this function is designed to only be used with dev inspect.
//
/// Return the exchange rate of `Coin<AFSUI>` to `COIN<SUI>` normalized to 10^18. e.g. an exchange
///  rate of 10^18 means you can exchange `Coin<AFSUI>` 1:1 to `COIN<SUI>`.
fun afsui_to_sui_exchange_rate(
    staked_sui_vault: &StakedSuiVault,
    safe: &Safe<TreasuryCap<AFSUI>>,
): u128 {
    abort 404
}
