// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

/// Module: pyth
module meta_vault_pyth_integration::pyth;

use meta_vault::vault::{Vault, DepositCap, WithdrawCap};
use meta_vault::admin::AdminCap;

use pyth::price_info::PriceInfoObject;
use pyth::price::Price;

use sui::table::Table;
use sui::clock::Clock;

use std::type_name::TypeName;

//**************************************************************************************************//
// Constants                                                                                        //
//**************************************************************************************************//

const DEFAULT_PRICE_THRESHOLD_SECS: u64 = 30;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error]
const ETypeNotRegistered: vector<u8> = b"The price feed is not associated with this coin type.";

#[error]
const EInvalidPriceInfoObject: vector<u8> = b"The `PriceInfoObject` is not associated with the coin type.";

#[error]
const EInvalidExponent: vector<u8> = b"The Price's exponent is too large.";

//************************************************************************************************//
// MetaVaultPythIntegration                                                                       //
//************************************************************************************************//

/// This singleton object allows mimicing `public(package)` across package boundaries through
/// the Object Auth pattern.
///
/// The `MetaVault` package's `AdminCap` must grant this object the authority to call
/// `create_deposit_cap` and `create_withdraw_cap`.
public struct MetaVaultPythIntegration has key, store {
    // [dynamic field] if `authorize` has been called on this object, it will then contain a
    // `meta_vault::admin::AuthKey` -> `meta_vault::admin::AuthCap` dynamic field. If present,
    // this object will have the authority to call `router::router::update_path_metadata`.
    //
    id: UID,
    /// Mapping from coin type to its Pyth price feed ID
    price_feed_registry: Table<TypeName, ID>,

    /// Maps custom `stale_price_threshold_secs` for `PriceInfoObject` `ID`s.
    stale_price_threshold_secs_registry: Table<ID, u64>,
    /// The default `stale_price_threshold_secs` assumed by any `PriceInfoObject` that does
    /// not have a custom value set in `stale_price_threshold_secs_registry`.
    default_stale_price_threshold_secs: u64,
}

//***************************************** Constructors *****************************************//

fun init(ctx: &mut TxContext) {
    abort 404
}

//******************************************** Getters *******************************************//

/// Gets the price feed ID for a given coin type
public fun price_feed_id<CoinType>(
    wrapper: &MetaVaultPythIntegration,
): ID {
    abort 404
}

//******************************************* Mutators *******************************************//

/// Grant the `MetaVaultPythIntegration` object the ability to call `deposit_cap` and `withdraw_cap`.
public fun authorize(
    admin_cap: &AdminCap,
    wrapper: &mut MetaVaultPythIntegration,
) {
    abort 404
}

/// Revoke the ability for the `MetaVaultPythIntegration` object to call `deposit_cap` and `withdraw_cap`.
public fun deauthorize(
    admin_cap: &AdminCap,
    wrapper: &mut MetaVaultPythIntegration,
) {
    abort 404
}

/// Adds a new price feed ID mapping for a coin type. Only callable by admin.
public fun set_price_feed_id<CoinType>(
    _: &AdminCap,
    wrapper: &mut MetaVaultPythIntegration,
    price_info_object: &PriceInfoObject,
) {
    abort 404
}

/// Updates the `stale_price_threshold_secs` associated with `price_info_object`.
public fun set_stale_price_threshold_secs(
    _: &AdminCap,
    wrapper: &mut MetaVaultPythIntegration,
    price_info_object: &PriceInfoObject,
    new_stale_price_threshold_secs: u64,
) {
    abort 404
}

/// Updates the `MetaVaultPythIntegration`'s `default_stale_price_threshold_secs` field.
public fun set_default_stale_price_threshold_secs(
    _: &AdminCap,
    wrapper: &mut MetaVaultPythIntegration,
    new_default_stale_price_threshold_secs: u64,
) {
    abort 404
}

//************************************************************************************************//
// DepositCap                                                                                     //
//************************************************************************************************//

/// Get the price feed associated with `Coin<CoinIn>` from the `PriceInfoObject` and
/// convert it to the `Coin<MetaCoin>` <> `Coin<CoinIn>` exchange rate. The exchange rate is
/// normalized to 18 decimals; e.g., $1 = `1__000_000_000_000_000_000`.
///
/// Aborts:
///   i. [meta_vault_pyth_integration::pyth::ETypeNotRegistered]
///  ii. [meta_vault_pyth_integration::pyth::EInvalidPriceInfoObject]
/// iii. [meta_vault_pyth_integration::pyth::EInvalidExponent]
///  iv. [meta_vault::admin::ENotAuthorized]
///   v. [meta_vault::vault::EInvalidAppWasUsedToCreateDepositCap]
public fun create_deposit_cap<MetaCoin, CoinIn>(
    wrapper: &MetaVaultPythIntegration,
    vault: &Vault<MetaCoin>,
    price_info_object: &PriceInfoObject,
    clock: &Clock,
): DepositCap<MetaCoin, CoinIn> {
    abort 404
}

//************************************************************************************************//
// WithdrawCap                                                                                    //
//************************************************************************************************//

/// Get the price feed associated with `Coin<CoinOut>` from the `PriceInfoObject` and
/// convert it to the `Coin<MetaCoin>` <> `Coin<CoinOut>` exchange rate. The exchange rate is
/// normalized to 18 decimals; e.g., $1 = `1__000_000_000_000_000_000`.
///
/// Aborts:
///   i. [meta_vault_pyth_integration::pyth::ETypeNotRegistered]
///  ii. [meta_vault_pyth_integration::pyth::EInvalidPriceInfoObject]
/// iii. [meta_vault_pyth_integration::pyth::EInvalidExponent]
///  iv. [meta_vault::admin::ENotAuthorized]
///   v. [meta_vault::vault::EInvalidAppWasUsedToCreateWithdrawCap]
public fun create_withdraw_cap<MetaCoin, CoinOut>(
    wrapper: &MetaVaultPythIntegration,
    vault: &Vault<MetaCoin>,
    price_info_object: &PriceInfoObject,
    clock: &Clock,
): WithdrawCap<MetaCoin, CoinOut> {
    abort 404
}

//************************************************************************************************//
// Internal Functions                                                                             //
//************************************************************************************************//

/// Return the price of `Coin<CoinType>` normalized to 18 decimals.
fun price_of<CoinType>(
    wrapper: &MetaVaultPythIntegration,
    price_info_object: &PriceInfoObject,
    clock: &Clock,
): u128 {
    abort 404
}

use fun normalize_to_18_point_decimals as Price.normalize_to_18_point_decimals;
/// Converts a Pyth price feed into an exchange rate for `Coin<MetaCoin>` -> `Coin<CoinType>`.
fun normalize_to_18_point_decimals(
    price: &Price
): u128 {
    abort 404
}
