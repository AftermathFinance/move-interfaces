// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: BUSL-1.1

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module shared_gas_pool::gas_pool;

use shared_gas_pool::authority::{PACKAGE, MAINTENANCE};
use shared_gas_pool::config::Config;
use shared_gas_pool::events;

use authority_cap::authority::AuthorityCap;

use sui::balance::{Self, Balance};
use sui::derived_object;
use sui::coin::Coin;
use sui::sui::SUI;

use fun create_with_share_policy as Config.create_with_share_policy;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error(code = 0)]
const ENotAuthorized: vector<u8> = b"The sender is not authorized to rebate-sponsor from this gas pool.";

#[error(code = 1)]
const ENotOwner: vector<u8> = b"Only the gas pool owner can perform this action.";

#[error(code = 2)]
const EAlreadyAuthorized: vector<u8> = b"The provided address is already authorized for this gas pool.";

#[error(code = 3)]
const EInvalidSharePolicy: vector<u8> = b"The provided GasPoolSharePolicy does not match the GasPool object.";

#[error(code = 4)]
const EBelowMinimumBalance: vector<u8> = b"This would leave the gas pool below the minimum balance it must retain.";

#[error(code = 5)]
const ESettlementNotAdvancing: vector<u8> = b"The settlement checkpoint must be greater than the one already recorded for this gas pool.";

#[error(code = 6)]
const EUnapprovedSponsor: vector<u8> = b"The gas payer of this transaction is not an approved sponsor.";

#[error(code = 7)]
const EWhitelistFull: vector<u8> = b"This gas pool already has the maximum number of whitelisted addresses.";

#[error(code = 8)]
const EInvalidAmount: vector<u8> = b"Trying to rebate more SUI than the GasPool currently holds.";

//************************************************************************************************//
// Constants                                                                                      //
//************************************************************************************************//

const MAX_WHITELISTED: u64 = 32;

//************************************************************************************************//
// GasPool                                                                                        //
//************************************************************************************************//

public struct GasPool has key {
    id: UID,

    owner: address,
    whitelisted: vector<address>,

    balance: Balance<SUI>,

    last_settled_checkpoint: u64,
}

public struct GasPoolSharePolicy(ID)

//****************************************** Constructor *****************************************//

public fun new(config: &mut Config, address: address) {
    let (pool, share_policy) = config.create_with_share_policy(address);

    pool.consume_policy_and_share(share_policy);
}

public fun create_with_share_policy(
    config: &mut Config,
    address: address,
): (GasPool, GasPoolSharePolicy) {
    abort 404
}

#[allow(lint(share_owned, custom_state_change))]
public fun consume_policy_and_share(
    pool: GasPool,
    share_policy: GasPoolSharePolicy,
) {
    abort 404
}

//***************** Mutators [Permissioned] [AuthorityCap<PACKAGE, MAINTENANCE>] *****************//

public fun admin_split(
    pool: &mut GasPool,
    maintenance_cap: &AuthorityCap<PACKAGE, MAINTENANCE>,
    config: &Config,
    amount: u64,
    settled_to: u64,
    ctx: &TxContext,
): Balance<SUI> {
    abort 404
}

public fun admin_join(
    pool: &mut GasPool,
    maintenance_cap: &AuthorityCap<PACKAGE, MAINTENANCE>,
    config: &Config,
    funds: Balance<SUI>,
    settled_to: u64,
    ctx: &TxContext,
) {
    abort 404
}

//******************************************* Mutators *******************************************//

public fun join(pool: &mut GasPool, config: &Config, coin: Coin<SUI>) {
    abort 404
}

public fun split(
    pool: &mut GasPool,
    config: &Config,
    amount: u64,
    ctx: &mut TxContext,
): Coin<SUI> {
    abort 404
}

public fun rebate_sponsor(
    pool: &mut GasPool,
    config: &Config,
    amount: u64,
    ctx: &TxContext,
) {
    abort 404
}

public fun authorize(
    pool: &mut GasPool,
    config: &Config,
    address: address,
    ctx: &TxContext,
) {
    abort 404
}

public fun deauthorize(
    pool: &mut GasPool,
    config: &Config,
    address: address,
    ctx: &TxContext,
) {
    abort 404
}

public fun deauthorize_self(
    pool: &mut GasPool,
    config: &Config,
    ctx: &TxContext,
) {
    abort 404
}

//******************************************** Getters *******************************************//

public fun owner(pool: &GasPool): address {
    abort 404
}

public fun last_settled_checkpoint(pool: &GasPool): u64 {
    abort 404
}

public fun balance(pool: &GasPool): u64 {
    abort 404
}

public fun is_authorized(pool: &GasPool, address: address): bool {
    abort 404
}

public fun derive_gas_pool_address(config: &Config, address: address): address {
    abort 404
}

//************************************************************************************************//
// Validity Functions                                                                             //
//************************************************************************************************//

public(package) fun assert_sender_is_owner(pool: &GasPool, sender: address) {
    abort 404
}

public(package) fun assert_sender_is_authorized(pool: &GasPool, sender: address) {
    abort 404
}

public(package) fun advance_settlement_checkpoint(pool: &mut GasPool, settled_to: u64): u64 {
    abort 404
}

public(package) fun assert_retains_minimum(pool: &GasPool, config: &Config, amount: u64) {
    abort 404
}
