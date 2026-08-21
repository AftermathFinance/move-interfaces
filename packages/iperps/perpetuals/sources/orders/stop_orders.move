// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: BUSL-1.1

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module perpetuals::stop_orders;

use perpetuals::clearing_house::{Self as ch, ClearingHouse, Executor, SessionSummary};
use perpetuals::account::{Account, IntegratorInfo};
use perpetuals::authority::ACCOUNT;
use perpetuals::registry::Registry;
use perpetuals::constants;
use perpetuals::events;

use oracle_aggregator::price_feed_storage::PriceFeedStorage;

use authority_cap::authority::AuthorityCap;

use ifixed::ifixed;

use sui::balance::Balance;
use sui::clock::Clock;
use sui::coin::Coin;
use sui::sui::SUI;
use sui::hash;
use sui::bcs;

use std::option::{Self, Option};

use fun perpetuals::stop_orders::derive_stop_order_trigger_price
    as ClearingHouse.derive_stop_order_trigger_price;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//
// Error code range: 6200-6299.

macro fun stop_order_ticket_expired(): u64 { 6200 }

macro fun stop_order_conditions_violated(): u64 { 6201 }

macro fun wrong_order_details(): u64 { 6202 }

macro fun not_enough_gas_for_stop_order(): u64 { 6203 }

macro fun invalid_executor_for_stop_order(): u64 { 6204 }

macro fun invalid_stop_order_type(): u64 { 6205 }

macro fun invalid_position_for_sltp(): u64 { 6206 }

macro fun invalid_stop_order_trigger_price_type(): u64 { 6207 }

macro fun wrong_stop_order_type_for_execution(): u64 { 6208 }

macro fun stop_order_without_economic_activity(): u64 { 6209 }

macro fun invalid_stop_order_gas_price(): u64 { 6210 }

//************************************************************************************************//
// StopOrderTicket                                                                                //
//************************************************************************************************//

public struct StopOrderTicket<phantom T> has key, store {
    id: UID,
    executors: vector<address>,
    execution_domain: Option<address>,
    gas: Balance<SUI>,
    account_id: u64,
    stop_order_type: u64,
    encrypted_details: vector<u8>
}

//************* Constructor [Permissioned] [AuthorityCap<ACCOUNT, ADMIN | ASSISTANT>] ************//

public fun create_stop_order_ticket<T, ADMIN_OR_ASSISTANT>(
    account: &mut Account<T>,
    cap: &AuthorityCap<ACCOUNT, ADMIN_OR_ASSISTANT>,
    registry: &Registry,
    executors: vector<address>,
    execution_domain: Option<address>,
    gas: Coin<SUI>,
    stop_order_type: u64,
    encrypted_details: vector<u8>,
    ctx: &mut TxContext,
): ID {
    abort 404
}

//*********** Deconstructor [Permissioned] [AuthorityCap<ACCOUNT, ADMIN_OR_ASSISTANT>] ***********//

public fun cancel<T, ADMIN_OR_ASSISTANT>(
    account: &mut Account<T>,
    cap: &AuthorityCap<ACCOUNT, ADMIN_OR_ASSISTANT>,
    registry: &Registry,
    ticket_id: ID,
    ctx: &mut TxContext
): Coin<SUI> {
    abort 404
}

//**************************** Deconstructor [Permissioned] [Executor] ***************************//

public fun cancel_stop_order_ticket<T>(
    account: &mut Account<T>,
    registry: &Registry,
    ticket_id: ID,
    executor: &Executor,
    ctx: &mut TxContext
): Coin<SUI> {
    abort 404
}

//******************************************** Getters *******************************************//

//************** Mutators [Permissioned] [AuthorityCap<ACCOUNT, ADMIN | ASSISTANT>] **************//

public fun edit_stop_order_ticket_details<T, ADMIN_OR_ASSISTANT>(
    account: &mut Account<T>,
    cap: &AuthorityCap<ACCOUNT, ADMIN_OR_ASSISTANT>,
    registry: &Registry,
    ticket_id: ID,
    encrypted_details: vector<u8>,
) {
    abort 404
}

public fun edit_stop_order_ticket_executors<T, ADMIN_OR_ASSISTANT>(
    account: &mut Account<T>,
    cap: &AuthorityCap<ACCOUNT, ADMIN_OR_ASSISTANT>,
    registry: &Registry,
    ticket_id: ID,
    executors: vector<address>,
) {
    abort 404
}

//****************************** Mutators [Permissioned] [executors] *****************************//

public fun place_stop_order_sltp<T>(
    mut clearing_house: ClearingHouse<T>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    clock: &Clock,
    ticket_id: ID,
    account: &mut Account<T>,
    expire_timestamp: Option<u64>,
    is_limit_order: bool,
    trigger_price_type: u8,
    stop_loss_price: Option<u256>,
    take_profit_price: Option<u256>,
    position_is_ask: bool,
    size: u64,
    price: u64,
    order_type: u64,
    salt: vector<u8>,
    integrator_info: Option<IntegratorInfo>,
    executor: &Executor,
    ctx: &mut TxContext
): (SessionSummary, Coin<SUI>, ClearingHouse<T>) {
    abort 404
}

public fun place_stop_order_standalone<T>(
    mut clearing_house: ClearingHouse<T>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    clock: &Clock,
    ticket_id: ID,
    account: &mut Account<T>,
    expire_timestamp: Option<u64>,
    is_limit_order: bool,
    trigger_price_type: u8,
    stop_index_price: u256,
    ge_stop_index_price: bool,
    side: bool,
    size: u64,
    price: u64,
    order_type: u64,
    reduce_only: bool,
    salt: vector<u8>,
    integrator_info: Option<IntegratorInfo>,
    executor: &Executor,
    ctx: &mut TxContext
): (SessionSummary, Coin<SUI>, ClearingHouse<T>) {
    abort 404
}

//************************************************************************************************//
// Internal Functions                                                                             //
//************************************************************************************************//

fun derive_stop_order_trigger_price<T>(
    clearing_house: &mut ClearingHouse<T>,
    index_price: u256,
    index_twap_price: u256,
    trigger_price_type: u8,
    now: u64
): u256 {
    abort 404
}

//************************************************************************************************//
// Validity Checks                                                                                //
//************************************************************************************************//

fun assert_stop_order_trigger_price_type(trigger_price_type: u8) {
    abort 404
}

fun assert_valid_ticket_executor<T>(ticket: &StopOrderTicket<T>, executor: &Executor) {
    abort 404
}
