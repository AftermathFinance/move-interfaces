// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

/// Module: lst_registry
module meta_vault_lst_exchange_rate_registry::registry;

// Note: The two aliases are purposeful and allow for better contextual naming.
use meta_vault::math::exchange_rate_one_to_one as exchange_rate_scaling_factor;
use meta_vault::math::exchange_rate_one_to_one as sui_to_sui_exchange_rate;
use meta_vault::vault::Vault;

use sui::package::claim_and_keep as claim_package;
use sui::table::Table;
use sui::sui::SUI;

use std::type_name::{Self, TypeName};

//************************************************************************************************//
// Constants                                                                                      //
//************************************************************************************************//

const ZERO: u64 = 0;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error]
const ECointypeNotRegistered: vector<u8> = b"The specified `CoinType` does not have an exchange rate stored within the `Registry`.";

//************************************************************************************************//
// Package Init                                                                                   //
//************************************************************************************************//

public struct REGISTRY has drop {}

fun init(witness: REGISTRY, ctx: &mut TxContext) {
    abort 404
}

//************************************************************************************************//
// Registry                                                                                       //
//************************************************************************************************//

/// Stores all coin-to-SUI exchange rates for the supported Meta `Vault`s. This allows accessing
/// these exchange rates on demand in order to calculate a Meta `Vault`'s TVL denominated in SUI
/// when calculating the SUI-to-meta-coin exchange rate.
///
/// This `Registry` allows the supported meta-coins to be yield-bearing.
public struct Registry has key {
    id: UID,

    /// Maps a specific `Coin` type  to its respective `Coin`:`SUI` exchange rate.
    exchange_rates: Table<TypeName, /* --> */ u128>,

    /// Tracks all `Coin` types that are being tracked by the `Registry`; i.e., for each key in
    /// `exchange_rates`, there will be a corresponding element on `types.
    types: vector<TypeName>,
}

//****************************************** Constructor *****************************************//

/// Create the global `Registry` object and initialize the static SUI:SUI exchange rate.
fun create(
    _: &REGISTRY,
    ctx: &mut TxContext
) {
    abort 404
}

//******************************************** Getters *******************************************//

#[syntax(index)]
/// Returns the coin-to-SUI exchange rate for the provided `TypeName` and aborts if the `Registry`
/// is not tracking the provided `TypeName`.
///
/// Aborts:
///   i. [meta_vault_lst_exchange_rate_registry::registry::ECointypeNotRegistered]
public fun exchange_rate(
    registry: &Registry,
    type_name: TypeName,
): &u128 {
    abort 404
}

use fun is_tracking_type_name as Registry.is_tracking;
// Note: These next two functions are named `..._type` and `..._type_name`, respectively, to allow
// the caller to set up their own `is_tracking` function alias for how they will interact with
// the `Registry`'s underlying types: through `Type` parameters directly or through `TypeName`.
//
/// Returns true if the `Registry` has an entry within the `exchange_rates` `Table` for the
/// provided `TypeName`, false otherwise.
public fun is_tracking_type_name(
    registry: &Registry,
    type_name: TypeName,
): bool {
    abort 404
}

/// Returns true if the `Registry` has an entry within the `exchange_rates` `Table` for the
/// provided `CoinType`, false otherwise.
public fun is_tracking_type<CoinType>(
    registry: &Registry,
): bool {
    abort 404
}

/// Return the `CoinType`:`MetaCoin` exchange rate. This is calculated as `CoinType`:SUI x
/// SUI:`MetaCoin`.
public fun coin_to_meta_coin_exchange_rate<MetaCoin, CoinType>(
    registry: &Registry,
    vault: &Vault<MetaCoin>,
): u128 {
    abort 404
}

/// Return the SUI:`MetaCoin` exchange rate. This is calculated by dividing the total supply of
/// `MetaCoin` by the `Vault's total TVL denominated in SUI.
public fun sui_to_meta_coin_exchange_rate<MetaCoin>(
    registry: &Registry,
    vault: &Vault<MetaCoin>,
): u128 {
    abort 404
}

/// Return the `MetaCoin`:SUI exchange rate. This is calculated by dividing the `Vault's total TVL
/// denominated in SUI by the total supply of `MetaCoin`.
public fun meta_coin_to_sui_exchange_rate<MetaCoin>(
    registry: &Registry,
    vault: &Vault<MetaCoin>,
): u128 {
    abort 404
}

//***************************** Mutators [Permissioned] [Object Auth] ****************************//

/// Update the `exchange_rate` for `CoinType` within `Registry`.
///
/// Aborts:
///    i. [meta_vault::admin::ENotAuthorized]
public fun update_exchange_rate<CoinType>(
    id: &UID,
    registry: &mut Registry,
    exchange_rate: u128,
) {
    abort 404
}

//************************************************************************************************//
// Public Functions                                                                               //
//************************************************************************************************//

use fun calculate_current_liquidity_denominated_in_sui
    as Vault.calculate_current_liquidity_denominated_in_sui;
/// Calculate the `Vault`'s TVL after converted to SUI. This is calculated by applying the
/// `CoinType`:SUI exchange rate on all of the `Vault`'s assets.
public fun calculate_current_liquidity_denominated_in_sui<MetaCoin>(
    vault: &Vault<MetaCoin>,
    registry: &Registry,
): u64 {
    abort 404
}

//************************************************************************************************//
// Internal Functions                                                                             //
//************************************************************************************************//

use fun sum as vector.sum;
fun sum(vaults_current_liquidity_denominated_in_sui: vector<u64>): u64 {
    abort 404
}

use fun divide_by as u64.divide_by;
fun divide_by(
    numerator: u64,
    denominator: u64
): u128 {
    abort 404
}

use fun multiply_by as u128.multiply_by;
fun multiply_by(
    numerator_1: u128,
    numerator_2: u128
): u128 {
    abort 404
}
