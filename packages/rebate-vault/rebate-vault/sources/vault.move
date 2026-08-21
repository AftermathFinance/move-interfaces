// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module rebate_vault::vault;

use rebate_vault::authority::PACKAGE;
use rebate_vault::config::Config;
use rebate_vault::events;

use authority_cap::authority::AuthorityCap;

use sui::object_table::ObjectTable;
use sui::transfer::share_object;
use sui::object_bag::ObjectBag;
use sui::derived_object;
use sui::table::Table;
use sui::coin::Coin;

use std::type_name::{Self, TypeName};
use std::ascii;

use fun sui::object_table::new as TxContext.new_object_table;
use fun sui::object_bag::new as TxContext.new_object_bag;
use fun sui::table::new as TxContext.new_table;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error(code = 0)]
const EVectorLengthsDontMatch: vector<u8> =
    b"The provided `users` and `allocations` vector lengths don't match.";

#[error(code = 1)]
const EInvalidCoinIn: vector<u8> =
    b"The provided `Coin` does not have an value equivalent to the amount of allocations dispersed during this deposit.";

#[error(code = 2)]
const EInvalidVault: vector<u8> =
    b"The `DepositCap` or `WithdrawCap` is associated with another `Vault`.";

#[error(code = 3)]
const EVaultAlreadyCreated: vector<u8> = b"The singleton `Vault` has already been created.";

//************************************************************************************************//
// VaultKey                                                                                       //
//************************************************************************************************//

public struct VaultKey() has copy, drop, store;

//************************************************************************************************//
// Vault                                                                                          //
//************************************************************************************************//

public struct Vault has key, store {
    id: UID,

    unclaimed_rebates: ObjectBag/*<TypeName, --> Coin>*/,

    allocation_registry: ObjectTable<address, Table<TypeName, /* --> */ u64>>,
}

//******************************* Constructor [Permissioned] [init] ******************************//

public(package) fun create_vault_and_share<T: drop>(
    witness: &T,
    config_id: &mut UID,
    ctx: &mut TxContext,
) {
    abort 404
}

//********************************************* Getters ******************************************//

#[syntax(index)]
public fun rebates_for(
    vault: &Vault,
    address: address,
    type_name: TypeName,
): &u64 {
    abort 404
}

public fun address_has_rebate(
    vault: &Vault,
    address: address
): bool {
    abort 404
}

public fun address_has_rebate_with_type<CoinType>(
    vault: &Vault,
    address: address,
): bool {
    abort 404
}

public fun address_has_rebate_with_type_name(
    vault: &Vault,
    address: address,
    type_name: TypeName,
): bool {
    abort 404
}

//************************************************************************************************//
// DepositCap                                                                                     //
//************************************************************************************************//

public struct DepositCap<phantom CoinType> /* has hot_potato */ {
    vault_id: ID,
    added_rebates: u64,
    num_of_addresses: u64,
}

//************ Constructor [Permissioned] [AuthorityCap<PACKAGE, ADMIN | ASSISTANT>] *************//

public fun begin_deposit_tx<ADMIN_OR_ASSISTANT, CoinType>(
    vault: &Vault,
    authority_cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    config: &Config,
): DepositCap<CoinType> {
    abort 404
}

//******************************************* Mutators *******************************************//

public fun update_allocations<CoinType>(
    vault: &mut Vault,
    deposit_cap: &mut DepositCap<CoinType>,
    config: &Config,
    addresses: vector<address>,
    allocations: vector<u64>,
    ctx: &mut TxContext,
) {
    abort 404
}

//***************************************** Deconstructor ****************************************//

public fun end_deposit_tx<CoinType>(
    vault: &mut Vault,
    deposit_cap: DepositCap<CoinType>,
    config: &Config,
    rebate: Coin<CoinType>,
    domain: ascii::String,
    epoch_start_timestamp_ms: u64,
    epoch_end_timestamp_ms: u64,
) {
    abort 404
}

//************************************************************************************************//
// WithdrawCap                                                                                    //
//************************************************************************************************//

public struct WithdrawCap /* has hot_potato */ {
    vault_id: ID,
    types: vector<ascii::String>,
    amounts: vector<u64>,
}

//****************************************** Constructor *****************************************//

public fun begin_withdraw_tx(
    vault: &Vault,
    config: &Config,
): WithdrawCap {
    abort 404
}

//******************************************* Mutators *******************************************//

public fun withdraw_rebate<CoinType>(
    vault: &mut Vault,
    withdraw_cap: &mut WithdrawCap,
    config: &Config,
    ctx: &mut TxContext,
): Coin<CoinType> {
    abort 404
}

//***************************************** Deconstructor ****************************************//

public fun end_withdraw_tx(
    withdraw_cap: WithdrawCap,
    config: &Config,
    ctx: &TxContext,
) {
    abort 404
}

//************************************************************************************************//
// Internal Functions                                                                             //
//************************************************************************************************//

fun join<CoinType>(
    vault: &mut Vault,
    coin: Coin<CoinType>,
) {
    abort 404
}

fun split<CoinType>(
    vault: &mut Vault,
    address: address,
    type_name: TypeName,
    ctx: &mut TxContext,
): Coin<CoinType> {
    abort 404
}

fun add_allocation(
    vault: &mut Vault,
    address: address,
    type_name: TypeName,
    allocation: u64,
    ctx: &mut TxContext,
) {
    abort 404
}

fun remove_allocation(
    vault: &mut Vault,
    address: address,
    type_name: TypeName,
): u64 /* allocation */ {
    abort 404
}

use fun sum as vector.sum;
fun sum(allocations: vector<u64>): u64 {
    abort 404
}
