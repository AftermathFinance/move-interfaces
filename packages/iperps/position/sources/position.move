// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: BUSL-1.1

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module position::position;

use position::constants;

use ifixed::ifixed;
use ifixed::macros;
use ifixed::constants as ifixed_constants;

use control_flow::conditionals;

use std::option::{Self, Option};

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//
// Error code range: 2000-2999.

macro fun ifixed_overflow(): u64 { 2000 }

macro fun initial_margin_requirement_violated(): u64 { 2001 }

macro fun position_bad_debt(): u64 { 2002 }

macro fun invalid_position_imr(): u64 { 2003 }

// =========================================================================
//  Module Structs
// =========================================================================

public struct Position has store {
    collateral: u256,
    base_asset_amount: u256,
    quote_asset_notional_amount: u256,
    cum_funding_rate_long: u256,
    cum_funding_rate_short: u256,
    asks_quantity: u256,
    bids_quantity: u256,
    pending_orders: u64,
    initial_margin_ratio: u256
}

// =========================================================================
//  Position Functions
// =========================================================================

public fun create_position(
    mkt_funding_rate_long: u256,
    mkt_funding_rate_short: u256,
): Position {
    abort 404
}

public fun is_long_or_flat(position: &Position): bool {
    abort 404
}

public fun collateral(position: &Position): u256 {
    abort 404
}

public fun base_and_quote_amounts(position: &Position): (u256, u256) {
    abort 404
}

public fun pending_base_amounts_by_side(position: &Position): (u256, u256) {
    abort 404
}

public fun funding_rate_snapshots(position: &Position): (u256, u256) {
    abort 404
}

public fun pending_order_count(position: &Position): u64 {
    abort 404
}

public fun initial_margin_ratio(position: &Position): u256 {
    abort 404
}

public fun effective_initial_margin_ratio(position: &Position, market_imr: u256): u256 {
    abort 404
}

public fun add_to_collateral(position: &mut Position, fixed: u256) {
    abort 404
}

public fun sub_from_collateral(position: &mut Position, fixed: u256) {
    abort 404
}

public fun reset_collateral(position: &mut Position): u256 {
    abort 404
}

public fun add_to_collateral_usd(
    position: &mut Position,
    fixed_usd: u256,
    collateral_price: u256
): u256 {
    abort 404
}

#[allow(dead_code)]
public fun add_base_to_position(
    position: &mut Position,
    side: bool,
    base_asset_delta: u256,
    quote_asset_delta: u256,
): (u256, u256) {
    abort 404
}

public fun apply_taker_fills_and_settle(
    position: &mut Position,
    collateral_price: u256,
    base_filled_ask: u256,
    quote_filled_ask: u256,
    base_filled_bid: u256,
    quote_filled_bid: u256,
    taker_fee: u256,
    integrator_fee: u256,
): (u256, u256, u256, u256) {
    abort 404
}

public fun add_to_pending_amount(
    position: &mut Position,
    side: bool,
    fixed_value: u256
) {
    abort 404
}

public fun sub_from_pending_amount(
    position: &mut Position,
    side: bool,
    fixed_value: u256
) {
    abort 404
}

public fun update_pending_orders(
    position: &mut Position,
    to_add: bool,
    pending_orders: u64
) {
    abort 404
}

public fun set_initial_margin_ratio(
    position: &mut Position,
    initial_margin_ratio: u256,
    market_initial_margin_ratio: u256,
) {
    abort 404
}

public fun compute_free_collateral_with_fundings(
    position: &Position,
    collateral_price: u256,
    mark_price: u256,
    margin_ratio: u256,
    mkt_funding_rate_long: u256,
    mkt_funding_rate_short: u256,
    collateral_haircut: u256,
): u256 {
    abort 404
}

public fun compute_free_collateral(
    position: &Position,
    collateral_price: u256,
    mark_price: u256,
    margin_ratio: u256,
    collateral_haircut: u256
): u256 {
    abort 404
}

public fun compute_margin_and_free_collateral(
    position: &Position,
    collateral_price: u256,
    mark_price: u256,
    margin_ratio: u256,
    collateral_haircut: u256
): (u256, u256, u256) {
    abort 404
}

public fun compute_margin_with_fundings(
    position: &Position,
    collateral_price: u256,
    mark_price: u256,
    margin_ratio: u256,
    mkt_funding_rate_long: u256,
    mkt_funding_rate_short: u256,
    collateral_haircut: u256,
): (u256, u256) {
    abort 404
}

public fun compute_margin_and_requirement(
    position: &Position,
    collateral_price: u256,
    mark_price: u256,
    margin_ratio: u256,
    collateral_haircut: u256
): (u256, u256) {
    abort 404
}

public fun apply_maker_fill_or_restore_if_bad_debt(
    position: &mut Position,
    order_is_ask: bool,
    base_asset_delta: u256,
    quote_asset_delta: u256,
    fees: u256,
    liquidation_fee: u256,
    collateral_price: u256,
    mark_price: u256,
    collateral_haircut: u256,
    max_maker_abs_base: Option<u256>,
): (bool, u256, u256) {
    abort 404
}

fun effective_collateral_usd_value(
    position: &Position,
    collateral_price: u256,
    collateral_haircut: u256
): u256 {
    abort 404
}

fun effective_collateral_usd_value_with_funding(
    position: &Position,
    collateral_price: u256,
    collateral_haircut: u256,
    funding: u256
): u256 {
    abort 404
}

public fun ensure_margin_requirements(
    margin_before: u256,
    min_margin_before: u256,
    margin_now: u256,
    min_margin_now: u256,
    base_before: u256,
    base_now: u256,
) {
    abort 404
}

public fun unrealized_pnl(position: &Position, mark_price: u256): u256 {
    abort 404
}

public fun margin_requirement(
    position: &Position,
    mark_price: u256,
    margin_ratio: u256,
): u256 {
    abort 404
}

public fun abs_net_base(position: &Position): u256 {
    abort 404
}

// =========================================================================
//  Funding Rates Functions
// =========================================================================

#[allow(dead_code)]
public fun settle_position_funding(
    position: &mut Position,
    collateral_price: u256,
    mkt_funding_rate_long: u256,
    mkt_funding_rate_short: u256,
): (bool, u256, u256) {
    abort 404
}

public fun calculate_position_funding_internal(
    position: &Position,
    mkt_funding_rate_long: u256,
    mkt_funding_rate_short: u256,
): u256 {
    abort 404
}

public fun unrealized_funding(
    cum_funding_rate_now: u256,
    cum_funding_rate_before: u256,
    base_asset_amount: u256,
): u256 {
    abort 404
}

public fun calculate_bankruptcy_price(
    position: &Position,
    collateral_price: u256,
    tick_size: u64,
): u64 {
    abort 404
}
