// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

/// Module: registry
module mpoints::registry;

use mpoints::admin::AdminCap;
use mpoints::mpoints::MPOINTS;

use sui::coin::{Coin, TreasuryCap};
use sui::balance::Supply;
use sui::table::Table;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error]
const EInvalidVersion: vector<u8> = b"You are interacting with an old package version.";

//************************************************************************************************//
// Constants                                                                                      //
//************************************************************************************************//

const CURRENT_VERSION: u64 = 0;
const ZERO: u64 = 0;

//************************************************************************************************//
// Registry                                                                                       //
//************************************************************************************************//

/// The main registry object that tracks burned points
public struct Registry has key {
    id: UID,

    /// Versioning field to allow safe upgrades.
    version: u64,

    /// The `Registry`'s `Supply` to allow minting and burning of `Balance<MPOINTS>`.
    supply: Supply<MPOINTS>,
    ///
    mpoints_burned: Table<address, /* --> */ u64>,
    ///
    total_mpoints_burned: u64
}

//****************************************** Constructor *****************************************//

#[allow(lint(self_transfer))]
/// Unwrap the `TreasuryCap<MPOINTS>` into a `Supply<MPOINTS>`, create the `Registry` object,
/// and create the package's `AdminCap`.
public fun create_registry(
    treasury_cap: TreasuryCap<MPOINTS>,
    ctx: &mut TxContext,
) {
    abort 404
}


//******************************************** Getters *******************************************//

#[syntax(index)]
/// Returns the amount of `Coin<MPOINTS>` `address` has burned.
public fun mpoints_burned(
    registry: &Registry,
    address: address,
): &u64 {
    abort 404
}

// Returns the total amount of `Coin<MPOINTS>` that has ever been minted.
public fun total_mpoints_minted(registry: &Registry): u64 {
    abort 404
}

// Returns the total amount of `Coin<MPOINTS>` that has been minted and not yet burned.
public fun total_mpoints_not_burned(registry: &Registry): u64 {
    abort 404
}

// Returns the total amount of `Coin<MPOINTS>` that has ever been burned.
public fun total_mpoints_burned(registry: &Registry): u64 {
    abort 404
}

//*************************************** Mutators [Public] **************************************//

/// Burn the provided `Coin<MPOINTS>` and track the burned amount in the `Registry`.
///
/// Aborts:
///    i. [mpoints::registry::EInvalidversion]
public fun burn(
    registry: &mut Registry,
    coin: Coin<MPOINTS>,
    ctx: &mut TxContext
) {
    abort 404
}

//****************************** Mutators [Permissioned] [AdminCap] ******************************//

/// Mint `amount` of new `Coin<MPOINTS>`.
///
/// Aborts:
///    i. [mpoints::registry::EInvalidversion]
public fun mint(
    _: &AdminCap,
    registry: &mut Registry,
    amount: u64,
    ctx: &mut TxContext
): Coin<MPOINTS> {
    abort 404
}
