// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

/// Module: exchange_rate
module meta_vault_sui_integration::exchange_rate;

use meta_vault_lst_exchange_rate_registry::registry::Registry;

use meta_vault::vault::{Vault, DepositCap, WithdrawCap};
use meta_vault::admin::AdminCap;

use sui::sui::SUI;

//************************************************************************************************//
// MetaVaultSuiIntegration                                                                        //
//************************************************************************************************//

/// This singleton object allows mimicing `public(package)` across package boundaries through
/// the Object Auth pattern.
///
/// The `MetaVault` package's `AdminCap` must grant this object the authority to call
/// `create_deposit_cap` and `create_withdraw_cap`.
public struct MetaVaultSuiIntegration has key, store {
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

/// Grant the `MetaVaultSuiIntegration` object the ability to call `create_deposit_cap` and
/// `create_withdraw_cap`.
public fun authorize(
    admin_cap: &AdminCap,
    wrapper: &mut MetaVaultSuiIntegration,
) {
    abort 404
}

/// Revoke the ability for the `MetaVaultSuiIntegration` object to call `create_deposit_cap` and
/// `create_withdraw_cap`.
public fun deauthorize(
    admin_cap: &AdminCap,
    wrapper: &mut MetaVaultSuiIntegration,
) {
    abort 404
}

//************************************************************************************************//
// DepositCap                                                                                     //
//************************************************************************************************//

/// Get the exchange rate between a meta-coin and SUI. This wrapper should only be used for cases
/// where the `MetaVault` is denominated in SUI, in which case the meta-coin <> SUI exchange rate
/// is 1:1. The returned exchnage rate is `1__000_000_000_000_000_000`.
///
/// Aborts:
///   i. [meta_vault::admin::ENotAuthorized]
///  ii. [meta_vault::vault::EInvalidAppWasUsedToCreateDepositCap]
public fun create_deposit_cap<MetaCoin>(
    wrapper: &MetaVaultSuiIntegration,
    vault: &Vault<MetaCoin>,
    registry: &mut Registry,
): DepositCap<MetaCoin, SUI> {
    abort 404
}

//************************************************************************************************//
// WithdrawCap                                                                                    //
//************************************************************************************************//

/// Get the exchange rate between a meta-coin and SUI. This wrapper should only be used for cases
/// where the `MetaVault` is denominated in SUI, in which case the meta-coin <> SUI exchange rate
/// is 1:1. The returned exchnage rate is `1__000_000_000_000_000_000`.
///
/// Aborts:
///   i. [meta_vault::admin::ENotAuthorized]
///  ii. [meta_vault::vault::EInvalidAppWasUsedToCreateWithdrawCap]
public fun create_withdraw_cap<MetaCoin>(
    wrapper: &MetaVaultSuiIntegration,
    vault: &Vault<MetaCoin>,
    registry: &mut Registry,
): WithdrawCap<MetaCoin, SUI> {
    abort 404
}
