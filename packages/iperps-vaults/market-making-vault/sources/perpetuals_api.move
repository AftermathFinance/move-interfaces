// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module market_making_vault::perpetuals_api;

use market_making_vault::vault::{Self, Vault};
use market_making_vault::errors;

use perpetuals::clearing_house::{Self as ch, ClearingHouse, SessionHotPotato, SessionSummary};
use perpetuals::twap_orders::{Self, TWAPOrderDetails};
use perpetuals::account::{Account, IntegratorInfo};
use perpetuals::market::MarketParams;
use perpetuals::registry::Registry;
use perpetuals::stop_orders;

use position::position::Position;

use oracle_aggregator::price_feed_storage::PriceFeedStorage;

use authority_cap::authority::ADMIN;

use std::option::{Self as option, Option};

use sui::clock::Clock;
use sui::coin::Coin;
use sui::object;
use sui::sui::SUI;

/* ================= Perpetuals functionality ================= */

public(package) fun allocate_collateral_to_position<L, C>(
    vault: &mut Vault<L, C>,
    account: &mut Account<C>,
    clearing_house: &mut ClearingHouse<C>,
    amount: u64,
    clock: &Clock,
) {
    abort 404
}

public(package) fun deallocate_collateral_from_position<L, C>(
    vault: &mut Vault<L, C>,
    account: &mut Account<C>,
    clearing_house: &mut ClearingHouse<C>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    amount: Option<u64>,
    clock: &Clock,
) {
    abort 404
}

public(package) fun close_position_at_settlement_prices<L, C>(
    vault: &mut Vault<L, C>,
    account: &mut Account<C>,
    clearing_house: &mut ClearingHouse<C>,
    order_ids: &vector<u128>,
) {
    abort 404
}

public(package) fun reconcile_clearing_house<L, C>(
    vault: &mut Vault<L, C>,
    account: &Account<C>,
    clearing_house: &ClearingHouse<C>,
) {
    abort 404
}

public(package) fun remove_empty_clearing_house<L, C>(
    vault: &mut Vault<L, C>,
    account: &Account<C>,
    clearing_house: &ClearingHouse<C>,
) {
    abort 404
}

public(package) fun place_market_order<L, C>(
    vault: &mut Vault<L, C>,
    account: &mut Account<C>,
    clearing_house: ClearingHouse<C>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    side: bool,
    size: u64,
    reduce_only: bool,
    integrator_info: Option<IntegratorInfo>,
    clock: &Clock,
    ctx: &TxContext,
): ClearingHouse<C> {
    abort 404
}

public(package) fun place_limit_order<L, C>(
    vault: &mut Vault<L, C>,
    account: &mut Account<C>,
    clearing_house: ClearingHouse<C>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    side: bool,
    size: u64,
    price: u64,
    order_type: u64,
    client_order_id: Option<u64>,
    reduce_only: bool,
    expiration_timestamp_ms: Option<u64>,
    integrator_info: Option<IntegratorInfo>,
    clock: &Clock,
    ctx: &TxContext
): (ClearingHouse<C>, Option<u128>)  {
    abort 404
}

public(package) fun cancel_orders<L, C>(
    vault: &mut Vault<L, C>,
    account: &Account<C>,
    clearing_house: &mut ClearingHouse<C>,
    order_ids: &vector<u128>,
    clock: &Clock,
) {
    abort 404
}

public(package) fun try_cancel_orders<L, C>(
    vault: &mut Vault<L, C>,
    account: &Account<C>,
    clearing_house: &mut ClearingHouse<C>,
    order_ids: &vector<u128>,
    clock: &Clock,
): vector<bool> {
    abort 404
}

public(package) fun liquidate<L, C>(
    vault: &mut Vault<L, C>,
    account: &mut Account<C>,
    clearing_house: ClearingHouse<C>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    liqee_account_id: u64,
    cancel_order_ids: &vector<u128>,
    integrator_info: Option<IntegratorInfo>,
    clock: &Clock,
    ctx: &TxContext
) {
    abort 404
}

public(package) fun set_position_initial_margin_ratio<L, C>(
    vault: &Vault<L, C>,
    account: &Account<C>,
    clearing_house: &mut ClearingHouse<C>,
    initial_margin_ratio: u256
) {
    abort 404
}

public(package) fun create_market_position<L, C>(
    vault: &Vault<L, C>,
    account: &Account<C>,
    clearing_house: &mut ClearingHouse<C>,
) {
    abort 404
}

public(package) fun start_perpetuals_session<L, C>(
    vault: &Vault<L, C>,
    account: &mut Account<C>,
    clearing_house: ClearingHouse<C>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    integrator_info: Option<IntegratorInfo>,
    clock: &Clock,
    ctx: &TxContext,
): SessionHotPotato<C> {
    abort 404
}

public(package) fun end_perpetuals_session<L, C>(
    vault: &mut Vault<L, C>,
    account: &mut Account<C>,
    hot_potato: SessionHotPotato<C>,
    allocate_missing_margin: bool,
    deallocate_free_collateral: bool,
): ClearingHouse<C> {
    abort 404
}

public(package) fun create_stop_order_ticket<L, C>(
    vault: &Vault<L, C>,
    account: &mut Account<C>,
    registry: &Registry,
    executors: vector<address>,
    gas: Coin<SUI>,
    stop_order_type: u64,
    encrypted_details: vector<u8>,
    ctx: &mut TxContext
): ID {
    abort 404
}

public(package) fun edit_stop_order_ticket_details<L, C>(
    vault: &Vault<L, C>,
    account: &mut Account<C>,
    registry: &Registry,
    stop_order_ticket_id: ID,
    encrypted_details: vector<u8>,
) {
    abort 404
}

public(package) fun edit_stop_order_ticket_executors<L, C>(
    vault: &Vault<L, C>,
    account: &mut Account<C>,
    registry: &Registry,
    stop_order_ticket_id: ID,
    executors: vector<address>,
) {
    abort 404
}

public(package) fun delete_stop_order_ticket<L, C>(
    vault: &Vault<L, C>,
    account: &mut Account<C>,
    registry: &Registry,
    stop_order_ticket_id: ID,
    ctx: &mut TxContext
): Coin<SUI> {
    abort 404
}

public(package) fun user_delete_stop_order_ticket<L, C>(
    vault: &Vault<L, C>,
    account: &mut Account<C>,
    registry: &Registry,
    stop_order_ticket_id: ID,
    ctx: &mut TxContext
): Coin<SUI> {
    abort 404
}

public(package) fun create_twap_order_ticket<L, C>(
    vault: &Vault<L, C>,
    account: &mut Account<C>,
    clearing_house: &ClearingHouse<C>,
    executors: vector<address>,
    gas: Coin<SUI>,
    encrypted_details: vector<u8>,
    ctx: &mut TxContext
): ID {
    abort 404
}

public(package) fun edit_twap_order_ticket_details<L, C>(
    vault: &Vault<L, C>,
    account: &mut Account<C>,
    registry: &Registry,
    twap_order_ticket_id: ID,
    encrypted_details: vector<u8>,
) {
    abort 404
}

public(package) fun edit_twap_order_ticket_executors<L, C>(
    vault: &Vault<L, C>,
    account: &mut Account<C>,
    registry: &Registry,
    twap_order_ticket_id: ID,
    executors: vector<address>,
) {
    abort 404
}

public(package) fun execute_twap_order<L, C>(
    vault: &mut Vault<L, C>,
    clearing_house: ClearingHouse<C>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    clock: &Clock,
    twap_order_ticket_id: ID,
    account: &mut Account<C>,
    new_details: &TWAPOrderDetails,
    amount: u64,
    ctx: &mut TxContext
): (SessionSummary, Coin<SUI>, ClearingHouse<C>) {
    abort 404
}

public(package) fun finalize_twap_order<L, C>(
    vault: &mut Vault<L, C>,
    account: &mut Account<C>,
    clearing_house: &mut ClearingHouse<C>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    clock: &Clock,
    twap_order_ticket_id: ID,
    new_details: &TWAPOrderDetails,
    ctx: &mut TxContext
): Coin<SUI> {
    abort 404
}

public(package) fun cancel_twap_order<L, C>(
    vault: &mut Vault<L, C>,
    account: &mut Account<C>,
    clearing_house: &mut ClearingHouse<C>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    clock: &Clock,
    twap_order_ticket_id: ID,
    ctx: &mut TxContext
): Coin<SUI> {
    abort 404
}

public(package) fun user_cancel_twap_order<L, C>(
    vault: &mut Vault<L, C>,
    account: &mut Account<C>,
    clearing_house: &mut ClearingHouse<C>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    clock: &Clock,
    twap_order_ticket_id: ID,
    ctx: &mut TxContext
): Coin<SUI> {
    abort 404
}

public(package) fun place_stop_order_sltp<L, C>(
    vault: &mut Vault<L, C>,
    clearing_house: ClearingHouse<C>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    clock: &Clock,
    stop_order_ticket_id: ID,
    account: &mut Account<C>,
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
    ctx: &mut TxContext
): (SessionSummary, Coin<SUI>, ClearingHouse<C>) {
    abort 404
}

public(package) fun place_stop_order_standalone<L, C>(
    vault: &mut Vault<L, C>,
    clearing_house: ClearingHouse<C>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    clock: &Clock,
    stop_order_ticket_id: ID,
    account: &mut Account<C>,
    expire_timestamp: Option<u64>,
    is_limit_order: bool,
    trigger_price_type: u8,
    stop_trigger_price: u256,
    ge_stop_trigger_price: bool,
    side: bool,
    size: u64,
    price: u64,
    order_type: u64,
    reduce_only: bool,
    salt: vector<u8>,
    integrator_info: Option<IntegratorInfo>,
    ctx: &mut TxContext
): (SessionSummary, Coin<SUI>, ClearingHouse<C>) {
    abort 404
}

#[lint_allow(share_owned)]
fun share_clearing_house<C>(clearing_house: ClearingHouse<C>) {
    abort 404
}

fun assert_pending_orders_within_limit<L, C>(
    vault: &Vault<L, C>,
    clearing_house: &ClearingHouse<C>,
    account_id: u64,
) {
    abort 404
}
