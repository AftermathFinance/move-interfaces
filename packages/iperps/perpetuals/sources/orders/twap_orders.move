// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module perpetuals::twap_orders;

use perpetuals::clearing_house::{
    Self as ch,
    ClearingHouse,
    Executor,
    SessionSummary,
    SessionHotPotato,
    deallocate_collateral_internal
};
use perpetuals::account::{Account, IntegratorInfo};
use perpetuals::authority::ACCOUNT;
use perpetuals::registry::Registry;
use perpetuals::constants;
use perpetuals::events;

use oracle_aggregator::price_feed_storage::PriceFeedStorage;

use authority_cap::authority::AuthorityCap;

use ifixed::ifixed;

use sui::balance::{Self, Balance};
use sui::clock::Clock;
use sui::coin::Coin;
use sui::sui::SUI;

use std::option::{Self, Option};

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//
// Error code range: 6300-6399.

macro fun invalid_order_details(): u64 { 6300 }

macro fun twap_order_ticket_expired(): u64 { 6301 }

macro fun twap_order_amount_uncertainty_violated(): u64 { 6302 }

macro fun twap_order_execution_gap_violated(): u64 { 6303 }

macro fun twap_order_fully_executed(): u64 { 6304 }

macro fun twap_order_executed_after_retry_time(): u64 { 6305 }

macro fun twap_order_invalid_executor(): u64 { 6306 }

macro fun twap_order_cannot_edit_active_order(): u64 { 6307 }

macro fun twap_order_not_completed(): u64 { 6308 }

macro fun twap_order_invalid_clearing_house(): u64 { 6309 }

macro fun twap_order_first_run_expired(): u64 { 6310 }

macro fun invalid_twap_order_gas_price(): u64 { 6311 }

macro fun twap_order_invalid_lot_size(): u64 { 6312 }

//************************************************************************************************//
// TWAPOrderDetails                                                                               //
//************************************************************************************************//

public struct TWAPOrderDetails has drop {
    first_run_expire_timestamp: Option<u64>,
    expire_timestamp: Option<u64>,
    execution_gap_ms: u64,
    execution_time_uncertainty_ms: u64,
    chunks_amount: u64,
    small_tail_merge_threshold_bps: u64,
    time_for_retry_ms: u64,
    amount_uncertainty_bps: u64,
    max_one_execution_amount_bps: u64,
    side: bool,
    size: u64,
    max_slippage_bps: u64,
    reduce_only: bool,
    integrator_info: Option<IntegratorInfo>,
    salt: vector<u8>
}

//****************************************** Constructor *****************************************//

public fun new_details(
    first_run_expire_timestamp: Option<u64>,
    expire_timestamp: Option<u64>,
    execution_gap_ms: u64,
    execution_time_uncertainty_ms: u64,
    chunks_amount: u64,
    small_tail_merge_threshold_bps: u64,
    time_for_retry_ms: u64,
    amount_uncertainty_bps: u64,
    max_one_execution_amount_bps: u64,
    side: bool,
    size: u64,
    max_slippage_bps: u64,
    reduce_only: bool,
    integrator_info: Option<IntegratorInfo>,
    salt: vector<u8>
): TWAPOrderDetails {
    abort 404
}

public(package) fun target_chunk_amount(
    new_details: &TWAPOrderDetails,
    lot_size: u64,
): u64 {
    abort 404
}

//************************************************************************************************//
// TWAPOrderTicket                                                                                //
//************************************************************************************************//

public struct TWAPOrderTicket<phantom T> has key, store {
    id: UID,
    clearing_house_id: ID,
    executors: vector<address>,
    execution_domain: Option<address>,
    gas: Balance<SUI>,
    gas_execution_budget: u64,
    account_id: u64,
    encrypted_details: vector<u8>,

    // Ticket progress tracking (Mutable part)

    processed_amount: u64,
    scheduled_amount: u64,
    last_attempt_timestamp_ms: u64,
    retry_anchor_timestamp_ms: u64,
    last_execution_timestamp_ms: u64,
    paid_execution_gas: u64,
}

//************* Constructor [Permissioned] [AuthorityCap<ACCOUNT, ADMIN | ASSISTANT>] ************//

public fun create_twap_order_ticket<T, ADMIN_OR_ASSISTANT>(
    account: &mut Account<T>,
    cap: &AuthorityCap<ACCOUNT, ADMIN_OR_ASSISTANT>,
    clearing_house: &ClearingHouse<T>,
    executors: vector<address>,
    execution_domain: Option<address>,
    gas: Coin<SUI>,
    encrypted_details: vector<u8>,
    ctx: &mut TxContext
): ID {
    abort 404
}

public fun cancel<T>(
    account: &mut Account<T>,
    clearing_house: &mut ClearingHouse<T>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    twap_order_ticket_id: ID,
    clock: &Clock,
    executor: &Executor,
    ctx: &mut TxContext,
): Coin<SUI> {
    abort 404
}

public fun user_cancel_twap_order<T, Role>(
    account: &mut Account<T>,
    cap: &AuthorityCap<ACCOUNT, Role>,
    clearing_house: &mut ClearingHouse<T>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    twap_order_ticket_id: ID,
    clock: &Clock,
    ctx: &mut TxContext,
): Coin<SUI> {
    abort 404
}

public fun finalize<T>(
    account: &mut Account<T>,
    clearing_house: &mut ClearingHouse<T>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    clock: &Clock,
    twap_order_ticket_id: ID,
    new_details: &TWAPOrderDetails,
    executor: &Executor,
    ctx: &mut TxContext,
): Coin<SUI> {
    abort 404
}

//******************************************** Getters *******************************************//

public fun unfilled_scheduled_amount<T>(ticket: &TWAPOrderTicket<T>): u64 {
    abort 404
}

public fun has_attempts<T>(ticket: &TWAPOrderTicket<T>): bool {
    abort 404
}

public fun is_first_execution<T>(ticket: &TWAPOrderTicket<T>): bool {
    abort 404
}

public fun is_complete<T>(ticket: &TWAPOrderTicket<T>, order_size: u64): bool {
    abort 404
}

fun is_not_spoiled<T>(
    ticket: &TWAPOrderTicket<T>,
    new_details: &TWAPOrderDetails,
    timestamp_ms: u64
): bool {
    abort 404
}

//****************************************** Mutators *****************************************//

public fun execute<T>(
    account: &mut Account<T>,
    clearing_house: ClearingHouse<T>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    twap_order_ticket_id: ID,
    new_details: &TWAPOrderDetails,
    amount: u64,
    clock: &Clock,
    executor: &Executor,
    ctx: &mut TxContext
): (SessionSummary, Coin<SUI>, ClearingHouse<T>) {
    abort 404
}

//************** Mutators [Permissioned] [AuthorityCap<ACCOUNT, ADMIN | ASSISTANT>] **************//

public fun set_details<T, ADMIN_OR_ASSISTANT>(
    account: &mut Account<T>,
    cap: &AuthorityCap<ACCOUNT, ADMIN_OR_ASSISTANT>,
    registry: &Registry,
    twap_order_ticket_id: ID,
    encrypted_details: vector<u8>,
) {
    abort 404
}

public fun set_executors<T, ADMIN_OR_ASSISTANT>(
    account: &mut Account<T>,
    cap: &AuthorityCap<ACCOUNT, ADMIN_OR_ASSISTANT>,
    registry: &Registry,
    twap_order_ticket_id: ID,
    executors: vector<address>,
) {
    abort 404
}

//************************************************************************************************//
// Validity Checks                                                                                //
//************************************************************************************************//

fun assert_order_details_are_valid(
    new_details: &TWAPOrderDetails,
    encrypted_details: &vector<u8>,
) {
    abort 404
}

public(package) fun assert_amount_within_uncertainty(
    new_details: &TWAPOrderDetails,
    desired_amount: u64,
    lot_size: u64,
) {
    abort 404
}

fun assert_lot_compatible(
    new_details: &TWAPOrderDetails,
    desired_amount: u64,
    lot_size: u64,
) {
    abort 404
}

fun assert_valid_ticket_clearing_house<T>(
    ticket: &TWAPOrderTicket<T>,
    clearing_house_id: ID,
) {
    abort 404
}

fun assert_valid_ticket_executor<T>(
    ticket: &TWAPOrderTicket<T>,
    executor: &Executor
) {
    abort 404
}

fun assert_execution_gap_within_uncertainty(
    new_details: &TWAPOrderDetails,
    actual_execution_gap_ms: u64,
) {
    abort 404
}

fun assert_twap_order_can_be_executed<T>(
    ticket: &TWAPOrderTicket<T>,
    new_details: &TWAPOrderDetails,
    amount: u64,
    timestamp_ms: u64,
    lot_size: u64,
) {
    abort 404
}
