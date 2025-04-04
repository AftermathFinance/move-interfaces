// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

/// Module: pyth
module meta_vault_pyth_integration_denominated::pyth;

use meta_vault::vault::{Vault, DepositCap, WithdrawCap};
use meta_vault::admin::AdminCap;

use pyth::price_info::PriceInfoObject;
use pyth::price::Price;

use sui::table::Table;
use sui::clock::Clock;

use std::type_name::TypeName;

//************************************************************************************************//
// Constants                                                                                      //
//************************************************************************************************//

const DEFAULT_PRICE_THRESHOLD_SECS: u64 = 30;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error]
const EInvalidBasePriceInfoObject: vector<u8> = b"The `PriceInfoObject` passed in for the base coin price feed is not the correct one.";

#[error]
const ETypeNotRegistered: vector<u8> = b"The price feed is not associated with this coin type.";

#[error]
const EInvalidPriceInfoObject: vector<u8> = b"The `PriceInfoObject` is not associated with the coin type.";

#[error]
const EInvalidExponent: vector<u8> = b"The Price's exponent is too large.";

//************************************************************************************************//
// MetaVaultPythIntegrationDenominatedFeed                                                        //
//************************************************************************************************//

/// This singleton object allows mimicing `public(package)` across package boundaries through
/// the Object Auth pattern.
///
/// The `MetaVault` package's `AdminCap` must grant this object the authority to call
/// `create_deposit_cap` and `create_withdraw_cap`.
public struct MetaVaultPythIntegrationDenominatedFeed has key, store {
    // [dynamic field] if `authorize` has been called on this object, it will then contain a
    // `meta_vault::admin::AuthKey` -> `meta_vault::admin::AuthCap` dynamic field. If present,
    // this object will have the authority to call `router::router::update_path_metadata`.
    //
    id: UID,

    // The `ID` of the Pyth `PriceInfoObject` that corresponds to the `<Base>/USD` price feed.
    base_usd_price_feed_id: ID,

    /// Mapping from coin type to its Pyth price feed ID
    price_feed_registry: Table<TypeName, ID>,

    /// Maps custom `stale_price_threshold_secs` for `PriceInfoObject` `ID`s.
    stale_price_threshold_secs_registry: Table<ID, u64>,
    /// The default `stale_price_threshold_secs` assumed by any `PriceInfoObject` that does
    /// not have a custom value set in `stale_price_threshold_secs_registry`.
    default_stale_price_threshold_secs: u64,
}

//***************************************** Constructors *****************************************//

public fun create_vault(
    _: &AdminCap,
    price_info_object: &PriceInfoObject,
    ctx: &mut TxContext,
) {
    abort 404
}

//******************************************** Getters *******************************************//

/// Gets the `ID` of the wrapper object's base `PriceInfoObject`.
public fun base_usd_price_feed_id(
    wrapper: &MetaVaultPythIntegrationDenominatedFeed,
): ID {
    abort 404
}

/// Gets the price feed ID for a given coin type
public fun price_feed_id<CoinType>(
    wrapper: &MetaVaultPythIntegrationDenominatedFeed,
): ID {
    abort 404
}

/// Returns the `stale_price_threshold_secs` associated with `price_info_object` or the default
/// if none has been registered yet.
public fun stale_price_threshold_secs(
    wrapper: &MetaVaultPythIntegrationDenominatedFeed,
    price_info_object: &PriceInfoObject,
): u64 {
    abort 404
}

/// Returns the wrapper object's `default_stale_price_threshold_secs` field.
public fun default_stale_price_threshold_secs(
    wrapper: &MetaVaultPythIntegrationDenominatedFeed,
): u64 {
    abort 404
}

//******************************************* Mutators *******************************************//

/// Grant the `MetaVaultPythIntegrationDenominatedFeed` object the ability to call `deposit_cap` and `withdraw_cap`.
public fun authorize(
    admin_cap: &AdminCap,
    wrapper: &mut MetaVaultPythIntegrationDenominatedFeed,
) {
    abort 404
}

/// Revoke the ability for the `MetaVaultPythIntegrationDenominatedFeed` object to call `deposit_cap` and `withdraw_cap`.
public fun deauthorize(
    admin_cap: &AdminCap,
    wrapper: &mut MetaVaultPythIntegrationDenominatedFeed,
) {
    abort 404
}

/// Adds a new price feed ID mapping for a coin type. Only callable by admin.
public fun set_price_feed_id<CoinType>(
    _: &AdminCap,
    wrapper: &mut MetaVaultPythIntegrationDenominatedFeed,
    price_info_object: &PriceInfoObject,
) {
    abort 404
}

/// Updates the `stale_price_threshold_secs` associated with `price_info_object`.
public fun set_stale_price_threshold_secs(
    _: &AdminCap,
    wrapper: &mut MetaVaultPythIntegrationDenominatedFeed,
    price_info_object: &PriceInfoObject,
    new_stale_price_threshold_secs: u64,
) {
    abort 404
}

/// Updates the `MetaVaultPythIntegrationDenominatedFeed`'s `default_stale_price_threshold_secs` field.
public fun set_default_stale_price_threshold_secs(
    _: &AdminCap,
    wrapper: &mut MetaVaultPythIntegrationDenominatedFeed,
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
///   i. [meta_vault_pyth_integration_denominated::pyth::EInvalidBasePriceInfoObject]
///  ii. [meta_vault_pyth_integration_denominated::pyth::ETypeNotRegistered]
/// iii. [meta_vault_pyth_integration_denominated::pyth::EInvalidPriceInfoObject]
///  iv. [meta_vault_pyth_integration_denominated::pyth::EInvalidExponent]
///   v. [meta_vault::admin::ENotAuthorized]
///  vi. [meta_vault::vault::EInvalidAppWasUsedToCreateDepositCap]
public fun create_deposit_cap<MetaCoin, CoinIn>(
    wrapper: &MetaVaultPythIntegrationDenominatedFeed,
    vault: &Vault<MetaCoin>,
    coin_in_price_info: &PriceInfoObject,
    base_price_info: &PriceInfoObject,
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
///   i. [meta_vault_pyth_integration_denominated::pyth::EInvalidBasePriceInfoObject]
///  ii. [meta_vault_pyth_integration_denominated::pyth::ETypeNotRegistered]
/// iii. [meta_vault_pyth_integration_denominated::pyth::EInvalidPriceInfoObject]
///  iv. [meta_vault_pyth_integration_denominated::pyth::EInvalidExponent]
///   v. [meta_vault::admin::ENotAuthorized]
///  vi. [meta_vault::vault::EInvalidAppWasUsedToCreateWithdrawCap]
public fun create_withdraw_cap<MetaCoin, CoinOut>(
    wrapper: &MetaVaultPythIntegrationDenominatedFeed,
    vault: &Vault<MetaCoin>,
    coin_out_price_info: &PriceInfoObject,
    base_price_info: &PriceInfoObject,
    clock: &Clock,
): WithdrawCap<MetaCoin, CoinOut> {
    abort 404
}

//************************************************************************************************//
// Internal Functions                                                                             //
//************************************************************************************************//

/// Return the price of `Coin<CoinType>` normalized to 18 decimals.
///
/// Aborts:
///   i. [meta_vault_pyth_integration_denominated::pyth::EInvalidBasePriceInfoObject]
///  ii. [meta_vault_pyth_integration_denominated::pyth::ETypeNotRegistered]
/// iii. [meta_vault_pyth_integration_denominated::pyth::EInvalidPriceInfoObject]
///  iv. [meta_vault_pyth_integration_denominated::pyth::EInvalidExponent]
fun price_of<CoinType>(
    wrapper: &MetaVaultPythIntegrationDenominatedFeed,
    coin_price_info: &PriceInfoObject,
    base_price_info: &PriceInfoObject,
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

use fun divide_by as u128.divide_by;
fun divide_by(
    numerator: u128,
    denominator: u128,
): u128 {
    abort 404
}
