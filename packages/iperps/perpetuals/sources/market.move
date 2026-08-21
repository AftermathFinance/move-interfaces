// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: BUSL-1.1

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module perpetuals::market;

use perpetuals::constants;
use perpetuals::events;
use perpetuals::registry::Config as RegistryConfig;

use oracle_aggregator::price_feed_storage::{Self, PriceFeedStorage};
use oracle_aggregator::price_feed;

use ifixed::ifixed;
use ifixed::macros;

use sui::clock::{Self, Clock};

use std::option::{Self, Option};
use std::u64::max;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//
// Error code range: 1000-1999.

macro fun bad_index_price(): u64 { 1000 }

macro fun invalid_base_price_feed_storage(): u64 { 1001 }

macro fun invalid_collateral_price_feed_storage(): u64 { 1002 }

macro fun index_twap_divergence(): u64 { 1003 }

macro fun priority_gas_price_not_allowed(): u64 { 1004 }

macro fun invalid_lot_and_tick_size_update(): u64 { 1007 }

macro fun invalid_min_order_usd_value(): u64 { 1008 }

macro fun invalid_max_pending_orders(): u64 { 1009 }

macro fun invalid_max_open_interest(): u64 { 1010 }

macro fun invalid_max_open_interest_position_percent(): u64 { 1011 }

macro fun invalid_max_open_interest_position_threshold(): u64 { 1012 }

macro fun invalid_max_bad_debt(): u64 { 1013 }

macro fun invalid_max_socialize_losses_mr_decrease(): u64 { 1014 }

macro fun invalid_collateral_haircut(): u64 { 1015 }

macro fun invalid_margin_ratios(): u64 { 1016 }

macro fun invalid_funding_parameters(): u64 { 1017 }

macro fun invalid_priority_taker_fee(): u64 { 1018 }

macro fun invalid_twap_parameters(): u64 { 1019 }

macro fun invalid_market_fees(): u64 { 1020 }

macro fun negative_maker_fee_not_covered(): u64 { 1021 }

macro fun negative_taker_fee_not_covered(): u64 { 1022 }

macro fun invalid_liquidation_fees(): u64 { 1023 }

macro fun liquidation_fees_exceed_maintenance_margin_ratio(): u64 { 1024 }

macro fun invalid_oracle_tolerance(): u64 { 1025 }

macro fun invalid_lot_and_tick_sizes(): u64 { 1026 }

macro fun invalid_max_book_index_spread(): u64 { 1027 }

macro fun invalid_max_index_twap_divergence(): u64 { 1028 }

// =========================================================================
//  Module Structs
// =========================================================================

public struct MarketParams has copy, drop, store {
    core_params: CoreParams,
    fees_params: FeesParams,
    twap_params: TwapParams,
    limits_params: LimitsParams
}

public struct CoreParams has copy, drop, store {
    base_storage_id: u32,
    collateral_storage_id: u32,
    base_source_id: u16,
    collateral_source_id: u16,
    base_pfs_tolerance: u64,
    collateral_pfs_tolerance: u64,
    lot_size: u64,
    tick_size: u64,
    scaling_factor: u256,
    collateral_haircut: u256,
    margin_ratio_initial: u256,
    margin_ratio_maintenance: u256,
}

public struct FeesParams has copy, drop, store {
    maker_fee: u256,
    taker_fee: u256,
    liquidation_fee: u256,
    insurance_fund_fee: u256,
    priority_taker_fee: Option<u256>,
}

public struct TwapParams has copy, drop, store {
    funding_frequency_ms: u64,
    funding_period_ms: u64,
    premium_twap_frequency_ms: u64,
    premium_twap_period_ms: u64,
    spread_twap_frequency_ms: u64,
    spread_twap_period_ms: u64,
}

public struct LimitsParams has copy, drop, store {
    min_order_usd_value: u256,
    max_pending_orders: u64,
    max_open_interest: u256,
    max_open_interest_threshold: u256,
    max_open_interest_position_percent: u256,
    max_book_index_spread: u256,
    max_index_twap_divergence: u256,
    max_bad_debt: u256,
    max_socialize_losses_mr_decrease: u256,
}

public struct MarketState has store {
    cum_funding_rate_long: u256,
    cum_funding_rate_short: u256,
    funding_last_upd_ms: u64,
    premium_twap: u256,
    premium_twap_last_upd_ms: u64,
    spread_twap: u256,
    spread_twap_last_upd_ms: u64,
    open_interest: u256,
    fees_accrued: u256,
}

// =========================================================================
//  Interface Functions
// =========================================================================

fun option_u64_or(value: &Option<u64>, fallback: u64): u64 {
    abort 404
}

fun option_u256_or(value: &Option<u256>, fallback: u256): u256 {
    abort 404
}

fun option_u16_or(value: &Option<u16>, fallback: u16): u16 {
    abort 404
}

public(package) fun create_market_objects(
    registry_config: &RegistryConfig,
    clock: &Clock,
    margin_ratio_initial: u256,
    margin_ratio_maintenance: u256,
    base_storage_id: u32,
    collateral_storage_id: u32,
    base_source_id: u16,
    collateral_source_id: u16,
    funding_frequency_ms: u64,
    funding_period_ms: u64,
    premium_twap_frequency_ms: u64,
    premium_twap_period_ms: u64,
    spread_twap_frequency_ms: u64,
    spread_twap_period_ms: u64,
    maker_fee: u256,
    taker_fee: u256,
    liquidation_fee: u256,
    insurance_fund_fee: u256,
    lot_size: u64,
    tick_size: u64,
    scaling_factor: u256,
): (MarketParams, MarketState) {
    abort 404
}

public(package) fun try_update_funding(
    params: &MarketParams,
    state: &mut MarketState,
    oracle: &PriceFeedStorage,
    clock: &Clock,
    ch_id: &ID,
    book_price_opt: Option<u256>
) {
    abort 404
}

public(package) fun try_update_twaps(
    params: &MarketParams,
    state: &mut MarketState,
    oracle: &PriceFeedStorage,
    clock: &Clock,
    ch_id: &ID,
    book_price_opt: Option<u256>
) {
    abort 404
}

public(package) fun set_core_params(
    params: &mut MarketParams,
    ch_id: &ID,
    lot_size: Option<u64>,
    tick_size: Option<u64>,
    collateral_haircut: Option<u256>,
) {
    abort 404
}

public(package) fun update_margin_ratios(
    params: &mut MarketParams,
    margin_ratio_initial: u256,
    margin_ratio_maintenance: u256,
) {
    abort 404
}

public(package) fun set_fee_params(
    params: &mut MarketParams,
    registry_config: &RegistryConfig,
    ch_id: &ID,
    maker_fee: Option<u256>,
    taker_fee: Option<u256>,
    liquidation_fee: Option<u256>,
    insurance_fund_fee: Option<u256>,
    priority_taker_fee: Option<Option<u256>>,
) {
    abort 404
}

public(package) fun set_twap_params(
    params: &mut MarketParams,
    registry_config: &RegistryConfig,
    ch_id: &ID,
    funding_frequency_ms: Option<u64>,
    funding_period_ms: Option<u64>,
    premium_twap_frequency_ms: Option<u64>,
    premium_twap_period_ms: Option<u64>,
    spread_twap_frequency_ms: Option<u64>,
    spread_twap_period_ms: Option<u64>,
) {
    abort 404
}

public(package) fun set_risk_limit_params(
    params: &mut MarketParams,
    registry_config: &RegistryConfig,
    ch_id: &ID,
    min_order_usd_value: Option<u256>,
    max_pending_orders: Option<u64>,
    max_open_interest: Option<u256>,
    max_open_interest_threshold: Option<u256>,
    max_open_interest_position_percent: Option<u256>,
    max_book_index_spread: Option<u256>,
    max_index_twap_divergence: Option<u256>,
    max_bad_debt: Option<u256>,
    max_socialize_losses_mr_decrease: Option<u256>,
) {
    abort 404
}

public(package) fun set_base_oracle_params(
    params: &mut MarketParams,
    registry_config: &RegistryConfig,
    ch_id: &ID,
    storage_id: u32,
    source_id: Option<u16>,
    oracle_tolerance: Option<u64>,
) {
    abort 404
}

public(package) fun set_collateral_oracle_params(
    params: &mut MarketParams,
    registry_config: &RegistryConfig,
    ch_id: &ID,
    storage_id: u32,
    source_id: Option<u16>,
    oracle_tolerance: Option<u64>,
) {
    abort 404
}

// =========================================================================
//  Module Functions
// =========================================================================

fun create_market_params(
    registry_config: &RegistryConfig,
    margin_ratio_initial: u256,
    margin_ratio_maintenance: u256,
    base_storage_id: u32,
    collateral_storage_id: u32,
    base_source_id: u16,
    collateral_source_id: u16,
    funding_frequency_ms: u64,
    funding_period_ms: u64,
    premium_twap_frequency_ms: u64,
    premium_twap_period_ms: u64,
    spread_twap_frequency_ms: u64,
    spread_twap_period_ms: u64,
    maker_fee: u256,
    taker_fee: u256,
    liquidation_fee: u256,
    insurance_fund_fee: u256,
    lot_size: u64,
    tick_size: u64,
    scaling_factor: u256
): MarketParams {
    abort 404
}

fun create_market_state(
    now: u64,
): MarketState {
    abort 404
}

public(package) fun add_to_open_interest(
    market_state: &mut MarketState,
    delta: u256,
) {
    abort 404
}

public(package) fun add_fees_accrued_usd(
    state: &mut MarketState,
    fees: u256,
    collateral_price: u256
) {
    abort 404
}

public(package) fun sub_fees_accrued(state: &mut MarketState, fees: u256) {
    abort 404
}

public(package) fun try_update_fundings_and_twaps(
    params: &MarketParams,
    state: &mut MarketState,
    now: u64,
    index_price: u256,
    book_price: u256,
    ch_id: &ID
) {
    abort 404
}

public fun calculate_funding_price(
    market_state: &MarketState,
    market_params: &MarketParams,
    index_price: u256,
    now: u64
): u256 {
    abort 404
}

public(package) fun add_bad_debt_to_market(
    market_state: &mut MarketState,
    ch_id: &ID,
    add_to_long: bool,
    bad_debt_usd: u256,
    delta: u256,
) {
    abort 404
}

public fun clip_max_book_index_spread(params: &MarketParams, book: u256, index: u256): u256 {
    abort 404
}

public fun assert_index_twap_divergence_within_limit(
    params: &MarketParams,
    index_price: u256,
    index_twap_price: u256,
) {
    abort 404
}

public(package) fun try_update_fundings(
    params: &MarketParams,
    state: &mut MarketState,
    now: u64,
    ch_id: &ID
) {
    abort 404
}

fun update_premium_twap(
    state: &mut MarketState,
    params: &MarketParams,
    index_price: u256,
    actual_book_price: u256,
    clipped_book_price: u256,
    now: u64,
    ch_id: &ID
) {
    abort 404
}

fun update_spread_twap(
    state: &mut MarketState,
    params: &MarketParams,
    index_price: u256,
    actual_book_price: u256,
    clipped_book_price: u256,
    now: u64,
    ch_id: &ID
) {
    abort 404
}

public fun update_twap(
    price_now: u256,
    last_twap: u256,
    time_now: u64,
    last_twap_ts: u64,
    twap_period_ms: u64,
): u256 {
    abort 404
}

public fun is_time_to_update(
    now: u64,
    last_upd_ms: u64,
    frequency_ms: u64
): bool {
    abort 404
}

public fun next_funding_update_time(last_upd_ms: u64, frequency_ms: u64): u64 {
    abort 404
}

public fun funding_period_adjustment(
    now: u64,
    funding_last_upd_ms: u64,
    funding_frequency_ms: u64,
    funding_period_ms: u64,
): u256 {
    abort 404
}

// =========================================================================
//  MarketParams Getters
// =========================================================================

public fun margin_ratio_initial(market_params: &MarketParams): u256 {
    abort 404
}

public fun margin_ratio_maintenance(market_params: &MarketParams): u256 {
    abort 404
}

public fun funding_params(market_params: &MarketParams): (u64, u64) {
    abort 404
}

public fun premium_twap_params(market_params: &MarketParams): (u64, u64) {
    abort 404
}

public fun spread_twap_params(market_params: &MarketParams): (u64, u64) {
    abort 404
}

public fun priority_taker_fee(market_params: &MarketParams): Option<u256> {
    abort 404
}

public fun resolve_priority_taker_fee(priority_taker_fee: Option<u256>): u256 {
    abort 404
}

public fun maker_fee(market_params: &MarketParams): u256 {
    abort 404
}

public fun taker_fee(market_params: &MarketParams): u256 {
    abort 404
}

public fun maker_taker_fees(market_params: &MarketParams): (u256, u256) {
    abort 404
}

public fun liquidation_fee_rates(market_params: &MarketParams): (u256, u256) {
    abort 404
}

public fun base_storage_id(market_params: &MarketParams): u32 {
    abort 404
}

public fun collateral_storage_id(market_params: &MarketParams): u32 {
    abort 404
}

public fun base_source_id(market_params: &MarketParams): u16 {
    abort 404
}

public fun collateral_source_id(market_params: &MarketParams): u16 {
    abort 404
}

public fun base_pfs_tolerance(market_params: &MarketParams): u64 {
    abort 404
}

public fun collateral_pfs_tolerance(market_params: &MarketParams): u64 {
    abort 404
}

public fun min_order_usd_value(market_params: &MarketParams): u256 {
    abort 404
}

public fun lot_size(market_params: &MarketParams): u64 {
    abort 404
}

public fun tick_size(market_params: &MarketParams): u64 {
    abort 404
}

public fun max_pending_orders(market_params: &MarketParams): u64 {
    abort 404
}

public fun max_open_interest(market_params: &MarketParams): u256 {
    abort 404
}

public fun max_book_index_spread(market_params: &MarketParams): u256 {
    abort 404
}

public fun max_index_twap_divergence(market_params: &MarketParams): u256 {
    abort 404
}

public fun max_open_interest_position_params(market_params: &MarketParams): (u256, u256) {
    abort 404
}

public fun max_bad_debt_thresholds(market_params: &MarketParams): (u256, u256) {
    abort 404
}

public fun collateral_haircut(market_params: &MarketParams): u256 {
    abort 404
}

public fun scaling_factor(market_params: &MarketParams): u256 {
    abort 404
}

public fun base_oracle_price(
    market_params: &MarketParams,
    oracle: &PriceFeedStorage,
    clock: &Clock
): u256 {
    abort 404
}

public fun base_oracle_price_and_twap_price(
    market_params: &MarketParams,
    oracle: &PriceFeedStorage,
    clock: &Clock
): (u256, u256) {
    abort 404
}

public fun collateral_oracle_price(
    market_params: &MarketParams,
    oracle: &PriceFeedStorage,
    clock: &Clock
): u256 {
    abort 404
}

// =========================================================================
//  MarketState Getters
// =========================================================================

public fun cum_funding_rates(market_state: &MarketState): (u256, u256) {
    abort 404
}

public fun funding_last_upd_ms(market_state: &MarketState): u64 {
    abort 404
}

public fun twap_last_upd_ms(market_state: &MarketState): (u64, u64) {
    abort 404
}

public fun premium_twap(market_state: &MarketState): u256 {
    abort 404
}

public fun spread_twap(market_state: &MarketState): u256 {
    abort 404
}

public fun open_interest(market_state: &MarketState): u256 {
    abort 404
}

public fun fees_accrued(state: &MarketState): u256 {
    abort 404
}

public fun calculate_mark_price(
    market_state: &MarketState,
    market_params: &MarketParams,
    index_twap_price: u256,
    book_price: u256,
    now: u64
): u256 {
    abort 404
}

public(package) fun assert_margin_ratios(
    margin_ratio_initial: u256,
    margin_ratio_maintenance: u256,
) {
    abort 404
}

fun assert_funding_parameters(
    registry_config: &RegistryConfig,
    funding_frequency_ms: u64,
    funding_period_ms: u64,
    premium_twap_frequency_ms: u64,
    premium_twap_period_ms: u64,
) {
    abort 404
}

fun assert_spread_twap_parameters(
    registry_config: &RegistryConfig,
    spread_twap_frequency_ms: u64,
    spread_twap_period_ms: u64,
) {
    abort 404
}

fun assert_priority_taker_fee(
    registry_config: &RegistryConfig,
    priority_taker_fee: Option<u256>
) {
    abort 404
}

fun assert_market_fees(registry_config: &RegistryConfig, maker_fee: u256, taker_fee: u256) {
    abort 404
}

fun assert_liquidation_fees(
    registry_config: &RegistryConfig,
    liquidation_fee: u256,
    insurance_fund_fee: u256,
) {
    abort 404
}

public(package) fun assert_liquidation_fees_against_mmr(
    margin_ratio_maintenance: u256,
    liquidation_fee: u256,
    insurance_fund_fee: u256,
) {
    abort 404
}

fun assert_lot_and_tick_sizes(
    lot_size: u64,
    tick_size: u64
) {
    abort 404
}
