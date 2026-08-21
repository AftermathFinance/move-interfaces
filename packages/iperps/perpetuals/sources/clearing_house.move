// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: BUSL-1.1

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module perpetuals::clearing_house;

use perpetuals::authority::{ACCOUNT, FREEZE_GUARDIAN, MAINTENANCE, PACKAGE, PAUSE_GUARDIAN, TREASURY, VENDOR};
use perpetuals::market::{Self, MarketState, MarketParams};
use perpetuals::orderbook::{Self, Orderbook, Order};
use perpetuals::account::{Account, IntegratorInfo};
use position::position::{Self, Position};
use perpetuals::registry::Registry;
use perpetuals::constants;
use perpetuals::order_id;
use perpetuals::events;
use perpetuals::keys;

use ordered_map::ordered_map::Self as map;

use oracle_aggregator::price_feed_storage::{Self, PriceFeedStorage};

use authority_cap::authority::AuthorityCap;

use ifixed::ifixed;
use ifixed::macros;

use control_flow::conditionals;

use sui::coin::{Self, Coin, CoinMetadata};
use sui::balance::{Self, Balance};
use sui::coin_registry::Currency;
use sui::clock::{Self, Clock};
use sui::dynamic_field as df;

use std::option::{Self, Option};
use std::string::{Self, String};
use std::u128::{min as min_u128, div_ceil as div_ceil_u128};
use std::u64::min;
use std::type_name;
use std::ascii;

use fun sui::coin::take as Balance.take;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//
// Error code range: 0-999.

macro fun deposit_or_withdraw_amount_zero(): u64 { 0 }

macro fun size_or_position_zero(): u64 { 1 }

macro fun invalid_version_upgrade_value(): u64 { 2 }

macro fun order_usd_value_too_low(): u64 { 3 }

macro fun invalid_force_cancel_ids(): u64 { 4 }

macro fun liquidate_not_first_operation(): u64 { 5 }

macro fun empty_cancel_order_ids(): u64 { 6 }

macro fun settlement_prices_not_set(): u64 { 7 }

macro fun self_liquidation(): u64 { 8 }

macro fun reduce_only_violated(): u64 { 9 }

macro fun invalid_version(): u64 { 10 }

macro fun empty_session(): u64 { 11 }

macro fun settlement_already_enabled(): u64 { 12 }

macro fun negative_fees_accrued(): u64 { 13 }

macro fun invalid_expiration_timestamp(): u64 { 14 }

macro fun max_open_interest_surpassed(): u64 { 15 }

macro fun max_open_interest_position_percent_surpassed(): u64 { 16 }

macro fun price_feed_source_does_not_exist(): u64 { 17 }

macro fun wrong_account_id_for_allocation(): u64 { 18 }

macro fun size_not_multiple_of_lot_size(): u64 { 19 }

macro fun price_not_multiple_of_tick_size(): u64 { 20 }

macro fun no_open_interest_to_socialize_bad_debt(): u64 { 21 }

macro fun bad_debt_notional_above_threshold(): u64 { 22 }

macro fun insufficient_vault_collateral(): u64 { 23 }

macro fun bad_debt_socialization_above_threshold(): u64 { 24 }

macro fun proposal_already_exists(): u64 { 25 }

macro fun premature_proposal(): u64 { 26 }

macro fun invalid_proposal_delay(): u64 { 27 }

macro fun proposal_does_not_exist(): u64 { 28 }

macro fun insufficient_insurance_surplus(): u64 { 29 }

macro fun not_enough_collateral_to_allocate_for_session(): u64 { 30 }

macro fun insufficient_settlement_insurance(): u64 { 31 }

macro fun market_is_paused(): u64 { 32 }

macro fun market_is_not_paused(): u64 { 33 }

macro fun market_is_not_closed(): u64 { 34 }

macro fun market_is_closed(): u64 { 35 }

macro fun settlement_prices_disabled(): u64 { 36 }

macro fun max_pending_orders_exceeded(): u64 { 37 }

macro fun position_above_mmr(): u64 { 38 }

macro fun position_bad_debt(): u64 { 39 }

macro fun insufficient_free_collateral(): u64 { 40 }

macro fun position_already_exists(): u64 { 41 }

macro fun deallocate_target_mr_too_low(): u64 { 42 }

macro fun liquidated_position_still_unhealthy(): u64 { 43 }

macro fun invalid_order_type(): u64 { 44 }

macro fun not_enough_liquidity(): u64 { 45 }

macro fun fill_or_kill_order_not_filled(): u64 { 46 }

macro fun post_only_order_would_match(): u64 { 47 }

macro fun pending_orders_not_canceled(): u64 { 48 }

macro fun invalid_settlement_prices(): u64 { 49 }

macro fun invalid_authority_cap(): u64 { 50 }

macro fun same_session_opposite_side_taker_fill(): u64 { 51 }

macro fun liquidation_requires_missing_margin_allocation(): u64 { 52 }

macro fun invalid_pause_mode(): u64 { 53 }

macro fun stale_pending_repost_requires_initial_margin(): u64 { 54 }

macro fun not_frozen(): u64 { 55 }

macro fun invalid_resume_version(): u64 { 56 }

macro fun below_mmr_cannot_rest_order(): u64 { 57 }

// =========================================================================
//  Module Structs
// =========================================================================

public struct ClearingHouse<phantom T> has key {
    id: UID,
    version: u64,
    paused: u8,
    market_params: MarketParams,
    market_state: MarketState,
    orderbook: Orderbook,
}

public struct Vault<phantom T> has store {
    collateral_balance: Balance<T>,
    insurance_fund_balance: Balance<T>,
}

public struct MarginRatioProposal has store {
    maturity: u64,
    margin_ratio_initial: u256,
    margin_ratio_maintenance: u256,
}

public struct SettlementPrices has store {
    base_price: Option<u256>,
    collateral_price: Option<u256>,
    enabled: bool,
}

public struct Executor has drop {
    sender: address,
    domain: Option<address>,
}

public struct SessionHotPotato<phantom T> {
    clearing_house: ClearingHouse<T>,
    account_id: u64,
    timestamp_ms: u64,
    collateral_price: u256,
    mark_price: u256,
    uses_priority_gas_price: bool,
    margin_before: u256,
    min_margin_before: u256,
    position_base_before: u256,
    total_open_interest: u256,
    total_fees: u256,
    taker_pending_cancelled: bool,
    maker_events: vector<events::FilledMakerOrder>,
    integrator_info: Option<IntegratorInfo>,
    liqee_account_id: Option<u64>,
    liquidator_fees: u256,
    session_summary: SessionSummary
}

public struct SessionSummary has copy, drop {
    base_filled_ask: u256,
    base_filled_bid: u256,
    quote_filled_ask: u256,
    quote_filled_bid: u256,
    base_posted_ask: u256,
    base_posted_bid: u256,
    posted_orders: u64,
    base_liquidated: u256,
    quote_liquidated: u256,
    is_liqee_long: bool,
    bad_debt: u256
}

//******************************************** Getters *******************************************//

public fun version<T>(ch: &ClearingHouse<T>): u64 {
    abort 404
}

public fun is_frozen<T>(clearing_house: &ClearingHouse<T>): bool {
    abort 404
}

public fun market_params<T>(ch: &ClearingHouse<T>): &MarketParams {
    abort 404
}

public(package) fun borrow_mut_market_params<T>(ch: &mut ClearingHouse<T>): &mut MarketParams {
    abort 404
}

public fun market_state<T>(ch: &ClearingHouse<T>): &MarketState {
    abort 404
}

public(package) fun borrow_mut_market_state<T>(ch: &mut ClearingHouse<T>): &mut MarketState {
    abort 404
}

public fun market_pause_mode<T>(ch: &ClearingHouse<T>): u8 {
    abort 404
}

public fun is_market_paused<T>(ch: &ClearingHouse<T>): bool {
    abort 404
}

public fun is_market_cancel_only<T>(ch: &ClearingHouse<T>): bool {
    abort 404
}

public fun market_objects<T>(ch: &ClearingHouse<T>): (&MarketParams, &MarketState) {
    abort 404
}

public(package) fun borrow_mut_market_objects<T>(
    ch: &mut ClearingHouse<T>
): (&MarketParams, &mut MarketState) {
    abort 404
}

public(package) fun settlement_prices<T>(ch: &ClearingHouse<T>): &SettlementPrices {
    abort 404
}

public fun settlement_valuation_prices<T>(ch: &ClearingHouse<T>): (bool, u256, u256) {
    abort 404
}

public(package) fun borrow_mut_settlement_prices<T>(ch: &mut ClearingHouse<T>): &mut SettlementPrices {
    abort 404
}

public(package) fun closed_market_adl_prices<T>(ch: &ClearingHouse<T>): (u256, u256) {
    abort 404
}

public fun book_price<T>(clearing_house: &ClearingHouse<T>): Option<u256> {
    abort 404
}

public fun best_price<T>(
    clearing_house: &ClearingHouse<T>,
    side: bool
): Option<u256> {
    abort 404
}

public fun best_price_u64<T>(
    clearing_house: &ClearingHouse<T>,
    side: bool
): Option<u64> {
    abort 404
}

public fun mark_price<T>(
    clearing_house: &ClearingHouse<T>,
    base_oracle: &PriceFeedStorage,
    clock: &Clock,
): u256 {
    abort 404
}

public fun create_client_order_id(client_order_id: u64): Option<u64> {
    abort 404
}

public fun market_vault<T>(ch: &ClearingHouse<T>): &Vault<T> {
    abort 404
}

public(package) fun borrow_mut_market_vault<T>(ch: &mut ClearingHouse<T>): &mut Vault<T> {
    abort 404
}

public fun collateral_and_insurance_fund_balances<T>(ch: &ClearingHouse<T>): (u64, u64) {
    abort 404
}

public fun orderbook<T>(ch: &ClearingHouse<T>): &Orderbook {
    abort 404
}

public(package) fun borrow_mut_orderbook<T>(ch: &mut ClearingHouse<T>): &mut Orderbook {
    abort 404
}

public fun position<T>(
    ch: &ClearingHouse<T>,
    account_id: u64
): &Position {
    abort 404
}

public fun exists_position<T>(
    ch: &ClearingHouse<T>,
    account_id: u64
): bool {
    abort 404
}

public(package) fun borrow_mut_position<T>(
    ch: &mut ClearingHouse<T>,
    account_id: u64
): &mut Position {
    abort 404
}

fun borrow_mut_position_from_id(
    ch_id: &mut UID,
    account_id: u64
): &mut Position {
    abort 404
}

public(package) fun settle_position_funding_and_emit(
    position: &mut Position,
    collateral_price: u256,
    mkt_funding_rate_long: u256,
    mkt_funding_rate_short: u256,
    ch_id: &ID,
    account_id: u64,
) {
    abort 404
}

use fun settle_position_funding_and_emit as Position.settle_position_funding_and_emit;

fun add_position<T>(
    ch: &mut ClearingHouse<T>,
    account_id: u64,
    position: Position
) {
    abort 404
}

public fun collateral_to_deallocate_for_margin_ratio<T>(
    clearing_house: &ClearingHouse<T>,
    account_id: u64,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    clock: &Clock,
    margin_ratio: Option<u256>,
): u64 {
    abort 404
}

public fun account_id<T>(
    session: &SessionHotPotato<T>,
): u64 {
    abort 404
}

public fun clearing_house<T>(
    session: &SessionHotPotato<T>,
): &ClearingHouse<T> {
    abort 404
}

public fun no_domain_executor(ctx: &TxContext): Executor {
    abort 404
}

public fun domain_executor(uid: &UID, ctx: &TxContext): Executor {
    abort 404
}

public fun executor_sender(executor: &Executor): address {
    abort 404
}

public fun executor_domain(executor: &Executor): Option<address> {
    abort 404
}

public use fun mark_price_in_session as SessionHotPotato.mark_price;
public fun mark_price_in_session<T>(
    session: &SessionHotPotato<T>,
): u256 {
    abort 404
}

public fun summary<T>(
    session: &SessionHotPotato<T>,
): &SessionSummary {
    abort 404
}

public use fun tick_rounded_liquidation_mark_price as SessionHotPotato.liquidation_mark_price_u64;
public fun tick_rounded_liquidation_mark_price<T>(
    hot_potato: &SessionHotPotato<T>,
): u64 {
    abort 404
}

fun session_has_activity(
    session_summary: &SessionSummary,
    maker_events: &vector<events::FilledMakerOrder>,
    liqee_account_id: &Option<u64>,
): bool {
    abort 404
}

public fun filled_base_and_quote(
    session_summary: &SessionSummary,
    side: bool
): (u256, u256) {
    abort 404
}

public fun base_filled_bid(
    session_summary: &SessionSummary,
): u256 {
    abort 404
}

public fun base_filled_ask(
    session_summary: &SessionSummary,
): u256 {
    abort 404
}

public fun posted_orders(
    session_summary: &SessionSummary,
): u64 {
    abort 404
}

public fun execution_price(
    session_summary: &SessionSummary,
    side: bool
): u256 {
    abort 404
}

public fun posted_base_by_side(
    session_summary: &SessionSummary,
): (u256, u256) {
    abort 404
}

public fun liquidation_base_quote_and_side(
    session_summary: &SessionSummary,
): (u256, u256, bool) {
    abort 404
}

public fun liquidated_size(
    session_summary: &SessionSummary,
): u64 {
    abort 404
}

public fun liquidation_mark_price(
    session_summary: &SessionSummary,
): u256 {
    abort 404
}

public use fun liquidation_mark_price_b9 as SessionSummary.liquidation_mark_price_u64;
public fun liquidation_mark_price_b9(
    session_summary: &SessionSummary,
): u64 {
    abort 404
}

public fun liquidation_bad_debt(
    session_summary: &SessionSummary,
): u256 {
    abort 404
}

fun create_session_summary(): SessionSummary {
    abort 404
}

//******* Constructors [Permissioned] [AuthorityCap<VENDOR<VendorKey>, ADMIN | ASSISTANT>] *******//

public fun create_orderbook<VendorKey, ADMIN_OR_ASSISTANT>(
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    registry: &Registry,
    branch_min: u64,
    branches_merge_max: u64,
    branch_max: u64,
    leaf_min: u64,
    leaves_merge_max: u64,
    leaf_max: u64,
    ctx: &mut TxContext,
): Orderbook {
    abort 404
}

public fun create_clearing_house<T, VendorKey, ADMIN_OR_ASSISTANT>(
    orderbook: Orderbook,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    registry: &mut Registry,
    coin_metadata: &CoinMetadata<T>,
    clock: &Clock,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    base_source_id: u16,
    collateral_source_id: u16,
    margin_ratio_initial: u256,
    margin_ratio_maintenance: u256,
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
    ctx: &mut TxContext,
): ClearingHouse<T> {
    abort 404
}

public fun create_clearing_house_with_currency<T, VendorKey, ADMIN_OR_ASSISTANT>(
    orderbook: Orderbook,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    registry: &mut Registry,
    currency: &Currency<T>,
    clock: &Clock,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    base_source_id: u16,
    collateral_source_id: u16,
    margin_ratio_initial: u256,
    margin_ratio_maintenance: u256,
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
    ctx: &mut TxContext,
): ClearingHouse<T> {
    abort 404
}

#[lint_allow(share_owned)]
public fun share<T>(ch: ClearingHouse<T>) {
    abort 404
}

//**************** Mutators [Permissioned] [AuthorityCap<PACKAGE, PAUSE_GUARDIAN>] ***************//

public fun admin_pause_market<T>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<PACKAGE, PAUSE_GUARDIAN>,
    registry: &Registry,
    pause_mode: u8,
) {
    abort 404
}

//************** Mutators [Permissioned] [AuthorityCap<PACKAGE, ADMIN | ASSISTANT>] **************//

public fun admin_resume_market<T, ADMIN_OR_ASSISTANT>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    registry: &Registry,
) {
    abort 404
}

entry fun upgrade_version<T, ADMIN_OR_ASSISTANT>(
    clearing_house: &mut ClearingHouse<T>,
    registry: &Registry,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
) {
    abort 404
}

public fun unfreeze_clearing_house<T>(
    clearing_house: &mut ClearingHouse<T>,
    _cap: &AuthorityCap<PACKAGE, authority_cap::authority::ADMIN>,
) {
    abort 404
}

//**************** Mutators [Permissioned] [AuthorityCap<PACKAGE, FREEZE_GUARDIAN>] **************//

public fun freeze_clearing_house<T>(
    clearing_house: &mut ClearingHouse<T>,
    registry: &Registry,
    cap: &AuthorityCap<PACKAGE, FREEZE_GUARDIAN>,
) {
    abort 404
}

public fun pause_market<T, VendorKey, ADMIN_OR_ASSISTANT_OR_PAUSE_GUARDIAN>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT_OR_PAUSE_GUARDIAN>,
    registry: &Registry,
    pause_mode: u8,
) {
    abort 404
}

//********* Mutators [Permissioned] [AuthorityCap<VENDOR<VendorKey>, ADMIN | ASSISTANT>] *********//

public fun resume_market<T, VendorKey, ADMIN_OR_ASSISTANT>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    registry: &Registry,
) {
    abort 404
}

public fun register_market<VendorKey, ADMIN_OR_ASSISTANT, T>(
    registry: &mut Registry,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    clearing_house: &ClearingHouse<T>,
) {
    abort 404
}

public fun remove_registered_market<VendorKey, ADMIN_OR_ASSISTANT, T>(
    registry: &mut Registry,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    clearing_house: &ClearingHouse<T>,
) {
    abort 404
}

public fun close_market<VendorKey, ADMIN_OR_ASSISTANT, T>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    registry: &Registry,
    clock: &Clock,
) {
    abort 404
}

public fun set_settlement_prices<VendorKey, ADMIN_OR_ASSISTANT, T>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    registry: &Registry,
    base_settlement_price: u256,
    collateral_settlement_price: u256,
) {
    abort 404
}

public fun enable_settlement<VendorKey, ADMIN_OR_ASSISTANT, T>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    registry: &Registry,
) {
    abort 404
}

public fun set_fee_params<VendorKey, ADMIN_OR_ASSISTANT, T>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    registry: &Registry,
    maker_fee: Option<u256>,
    taker_fee: Option<u256>,
    liquidation_fee: Option<u256>,
    insurance_fund_fee: Option<u256>,
    priority_taker_fee: Option<Option<u256>>,
) {
    abort 404
}

public fun set_twap_params<VendorKey, ADMIN_OR_ASSISTANT_OR_MAINTENANCE, T>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT_OR_MAINTENANCE>,
    registry: &Registry,
    funding_frequency_ms: Option<u64>,
    funding_period_ms: Option<u64>,
    premium_twap_frequency_ms: Option<u64>,
    premium_twap_period_ms: Option<u64>,
    spread_twap_frequency_ms: Option<u64>,
    spread_twap_period_ms: Option<u64>,
    clock: &Clock,
) {
    abort 404
}

public fun set_core_params<VendorKey, ADMIN_OR_ASSISTANT, T>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    registry: &Registry,
    lot_size: Option<u64>,
    tick_size: Option<u64>,
    collateral_haircut: Option<u256>,
) {
    abort 404
}

public fun set_risk_limit_params<VendorKey, ADMIN_OR_ASSISTANT, T>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    registry: &Registry,
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

public fun set_base_oracle_params<VendorKey, ADMIN_OR_ASSISTANT, T>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    registry: &mut Registry,
    price_feed_storage: &PriceFeedStorage,
    source_id: Option<u16>,
    oracle_tolerance: Option<u64>,
) {
    abort 404
}

//************** Mutators [Permissioned] [AuthorityCap<PACKAGE, ADMIN | ASSISTANT>] **************//

public fun set_collateral_oracle_params<T, ADMIN_OR_ASSISTANT>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    registry: &mut Registry,
    price_feed_storage: &PriceFeedStorage,
    source_id: Option<u16>,
    oracle_tolerance: Option<u64>,
) {
    abort 404
}

//********* Mutators [Permissioned] [AuthorityCap<VENDOR<VendorKey>, ADMIN | ASSISTANT>] *********//

public fun create_margin_ratios_proposal<VendorKey, ADMIN_OR_ASSISTANT, T>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    registry: &Registry,
    delay_ms: u64,
    margin_ratio_initial: u256,
    margin_ratio_maintenance: u256,
    clock: &Clock,
) {
    abort 404
}

public fun delete_margin_ratios_proposal<VendorKey, ADMIN_OR_ASSISTANT, T>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    registry: &Registry,
) {
    abort 404
}

//************************************************************************************************//
// Public Functions                                                                               //
//************************************************************************************************//

public fun commit_margin_ratios_proposal<T>(
    clearing_house: &mut ClearingHouse<T>,
    clock: &Clock,
) {
    abort 404
}

public fun donate_to_insurance_fund<T>(
    clearing_house: &mut ClearingHouse<T>,
    coin: Coin<T>,
    ctx: &mut TxContext
) {
    abort 404
}

public fun update_funding<T>(
    clearing_house: &mut ClearingHouse<T>,
    oracle: &PriceFeedStorage,
    clock: &Clock,
) {
    abort 404
}

public fun update_twaps<T>(
    clearing_house: &mut ClearingHouse<T>,
    oracle: &PriceFeedStorage,
    clock: &Clock,
) {
    abort 404
}

public fun settle_position_funding<T>(
    clearing_house: &mut ClearingHouse<T>,
    oracle: &PriceFeedStorage,
    account_id: u64,
    clock: &Clock,
) {
    abort 404
}

//************** Mutators [Permissioned] [AuthorityCap<VENDOR<VendorKey>, TREASURY>] *************//

public fun withdraw_fees<T, VendorKey>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<VENDOR<VendorKey>, TREASURY>,
    registry: &Registry,
    ctx: &mut TxContext,
): Coin<T> {
    abort 404
}

public fun withdraw_insurance_fund<T, VendorKey>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<VENDOR<VendorKey>, TREASURY>,
    registry: &Registry,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    clock: &Clock,
    amount: u64,
    ctx: &mut TxContext,
): Coin<T> {
    abort 404
}

//******************* Mutators [Permissioned] [AuthorityCap<VENDOR, MAINTENANCE>] ****************//

public fun try_cancel_stale_orders<T, VendorKey>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<VENDOR<VendorKey>, MAINTENANCE>,
    registry: &Registry,
    account_id: u64,
    order_ids: &vector<u128>,
    clock: &Clock,
): vector<bool> {
    abort 404
}

//************** Mutators [Permissioned] [AuthorityCap<ACCOUNT, ADMIN | ASSISTANT>] **************//

public fun allocate_collateral<T, ADMIN_OR_ASSISTANT>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<ACCOUNT, ADMIN_OR_ASSISTANT>,
    account: &mut Account<T>,
    amount: u64,
) {
    abort 404
}

public fun deallocate_collateral<T, ADMIN_OR_ASSISTANT>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<ACCOUNT, ADMIN_OR_ASSISTANT>,
    account: &mut Account<T>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    amount: u64,
    clock: &Clock,
): u64 {
    abort 404
}

public fun deallocate_free_collateral<T, ADMIN_OR_ASSISTANT>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<ACCOUNT, ADMIN_OR_ASSISTANT>,
    account: &mut Account<T>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    clock: &Clock,
): u64 {
    abort 404
}

public fun create_market_position<T, ADMIN_OR_ASSISTANT>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<ACCOUNT, ADMIN_OR_ASSISTANT>,
    account: &Account<T>,
) {
    abort 404
}

public fun set_position_initial_margin_ratio<T, ADMIN_OR_ASSISTANT>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<ACCOUNT, ADMIN_OR_ASSISTANT>,
    account: &Account<T>,
    initial_margin_ratio: u256
) {
    abort 404
}

public fun cancel_orders<T, ADMIN_OR_ASSISTANT>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<ACCOUNT, ADMIN_OR_ASSISTANT>,
    account: &Account<T>,
    order_ids: vector<u128>,
) {
    abort 404
}

public fun try_cancel_orders<T, ADMIN_OR_ASSISTANT>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<ACCOUNT, ADMIN_OR_ASSISTANT>,
    account: &Account<T>,
    order_ids: &vector<u128>,
): vector<bool> {
    abort 404
}

public fun close_position_at_settlement_prices<T>(
    clearing_house: &mut ClearingHouse<T>,
    account: &mut Account<T>,
    order_ids: &vector<u128>,
) {
    abort 404
}

public fun start_session<T, ADMIN_OR_ASSISTANT>(
    clearing_house: ClearingHouse<T>,
    cap: &AuthorityCap<ACCOUNT, ADMIN_OR_ASSISTANT>,
    account: &mut Account<T>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    integrator_info: Option<IntegratorInfo>,
    clock: &Clock,
    ctx: &TxContext
): SessionHotPotato<T> {
    abort 404
}

//************************** Mutators [Permissioned] [SessionHotPotato] **************************//

public fun place_limit_order<T>(
    hot_potato: &mut SessionHotPotato<T>,
    side: bool,
    size: u64,
    price: u64,
    order_type: u64,
    client_order_id: Option<u64>,
    reduce_only: bool,
    expiration_timestamp_ms: Option<u64>
): Option<u128> {
    abort 404
}

public fun place_market_order<T>(
    hot_potato: &mut SessionHotPotato<T>,
    side: bool,
    size: u64,
    reduce_only: bool,
) {
    abort 404
}

public fun liquidate<T>(
    hot_potato: &mut SessionHotPotato<T>,
    liqee_account_id: u64,
    cancel_order_ids: &vector<u128>
) {
    abort 404
}

public fun end_session<T, ADMIN_OR_ASSISTANT>(
    hot_potato: SessionHotPotato<T>,
    cap: &AuthorityCap<ACCOUNT, ADMIN_OR_ASSISTANT>,
    account: &mut Account<T>,
    allocate_missing_margin: bool,
    deallocate_free_collateral: bool,
): (ClearingHouse<T>, SessionSummary) {
    abort 404
}

public(package) fun end_session_<T>(
    hot_potato: SessionHotPotato<T>,
    account: &mut Account<T>,
    allocate_missing_margin: bool,
    deallocate_free_collateral: bool,
    allow_empty_session: bool,
): (ClearingHouse<T>, SessionSummary) {
    abort 404
}

// =========================================================================
//  Private Functions
// =========================================================================

fun execute_limit_order<T>(
    hot_potato: &mut SessionHotPotato<T>,
    side: bool,
    mut size: u64,
    price: u64,
    order_type: u64,
    client_order_id: Option<u64>,
    reduce_only: bool,
    expiration_timestamp_ms: Option<u64>,
): (u64, Option<u128>) {
    abort 404
}

fun execute_market_order<T>(
    hot_potato: &mut SessionHotPotato<T>,
    side: bool,
    mut size: u64,
) {
    abort 404
}

fun process_fill_maker(
    session_summary: &mut SessionSummary,
    clearing_house_id: &mut UID,
    maker_order_id: u128,
    order: &mut Order,
    timestamp_ms: u64,
    collateral_price: u256,
    mark_price: u256,
    maker_fee: u256,
    liquidation_fee: u256,
    collateral_haircut: u256,
    mkt_funding_rate_long: u256,
    mkt_funding_rate_short: u256,
    current_open_interest: u256,
    max_open_interest_threshold: u256,
    max_open_interest_position_percent: u256,
    taker_account_id: u64,
    taker_size_to_match: u64,
    taker_pending_cancelled: &mut bool,
): (u64, bool, events::FilledMakerOrder, u256) {
    abort 404
}

fun process_post(
    position: &mut Position,
    max_pending_orders: u64,
    session_summary: &SessionSummary,
) {
    abort 404
}

public(package) fun withdraw_free_collateral_to_account_balance<T>(
    clearing_house: &mut ClearingHouse<T>,
    account_balance: &mut Balance<T>,
    timestamp_ms: u64,
    collateral_price: u256,
    index_twap_price: u256,
    book_price: u256,
    account_id: u64,
    amount: Option<u64>,
): u64 {
    abort 404
}

fun withdraw_vault_collateral<T>(
    vault: &mut Vault<T>,
    account_balance: &mut Balance<T>,
    amount: u64,
) {
    abort 404
}

fun execute_liquidation<T>(
    hot_potato: &mut SessionHotPotato<T>,
    liqee_account_id: u64,
    liqee_base_ask_cancel: u128,
    liqee_base_bid_cancel: u128,
    liqee_pending_orders_cancel: u64,
) {
    abort 404
}

fun settle_liquidated_position<T>(
    hot_potato: &mut SessionHotPotato<T>,
    liqee_account_id: u64,
    liqee_base_ask_cancel: u128,
    liqee_base_bid_cancel: u128,
    liqee_pending_orders_cancel: u64,
    ch_id: &ID,
) {
    abort 404
}

public(package) fun reduce_liquidated_position(
    position: &mut Position,
    size_to_liquidate: u128,
    mark_price: u256,
    collateral_price: u256,
    insurance_fund_fee: u256,
    liquidation_fee: u256,
    margin_ratio_required: u256,
    collateral_haircut: u256
): (u256, u256, bool, u256, u256, u256, u256, u256, u256, u256) {
    abort 404
}

use fun force_cancel_orders as Orderbook.force_cancel_orders;
public(package) fun force_cancel_orders(
    orderbook: &mut Orderbook,
    account_id: u64,
    order_ids: &vector<u128>,
    ch_id: ID,
    cancelation_reason: u8,
): (u128, u128, u64) {
    abort 404
}

fun transfer_from_vault_to_insurance_fund<T>(
    vault: &mut Vault<T>,
    amount: u256,
    scaling_factor: u256
) {
    abort 404
}

fun transfer_from_insurance_fund_to_vault<T>(
    vault: &mut Vault<T>,
    amount: u256,
    scaling_factor: u256
) {
    abort 404
}

fun handle_bad_debt<T>(
    clearing_house: &mut ClearingHouse<T>,
    bad_debt: u256,
    mark_price: u256,
    collateral_price: u256,
    is_liqee_long: bool,
    ch_id: &ID,
    socialization_open_interest: Option<u256>,
) {
    abort 404
}

fun try_socialize_bad_debt(
    market_state: &mut MarketState,
    mark_price: u256,
    is_liqee_long: bool,
    amount_to_socialize: u256,
    max_bad_debt: u256,
    max_socialize_losses_mr_decrease: u256,
    ch_id: &ID,
    socialization_open_interest: Option<u256>,
) {
    abort 404
}

public fun compute_liquidation_size_and_mode(
    liqee_position: &Position,
    collateral_price: u256,
    mark_price: u256,
    market_imr: u256,
    liquidation_fee: u256,
    insurance_fund_fee: u256,
    collateral_haircut: u256
): (u256, bool) {
    abort 404
}

fun compute_liquidation_size_no_haircut(
    b: u256,
    q: u256,
    c: u256,
    abs_b: u256,
    collateral_price: u256,
    mark_price: u256,
    liquidation_fee: u256,
    insurance_fund_fee: u256,
    mi_pm_abs_b: u256,
    margin_before: u256,
    min_margin_before: u256,
): (u256, bool) {
    abort 404
}

fun waived_fee_liquidation_alpha(
    num: u256,
    mi_pm_abs_b: u256,
    collateral_usd: u256,
    upnl: u256,
    liq_fee_notional: u256,
): (bool, u256) {
    abort 404
}

fun compute_liquidation_size_with_haircut(
    b: u256,
    q: u256,
    c: u256,
    abs_b: u256,
    collateral_price: u256,
    mark_price: u256,
    liquidation_fee: u256,
    insurance_fund_fee: u256,
    collateral_haircut: u256,
    mi_pm_abs_b: u256,
    margin_before: u256,
    min_margin_before: u256,
): (u256, bool) {
    abort 404
}

fun liquidation_collateral_rounding_cushion(collateral_price: u256): u256 {
    abort 404
}

fun valid_liquidation_alpha(alpha: u256): bool {
    abort 404
}

fun collateral_for_margin_increase(
    collateral: u256,
    collateral_price: u256,
    collateral_haircut: u256,
    margin_increase: u256,
): u256 {
    abort 404
}

public fun clip_size_to_liquidate(
    size_to_liquidate: u256,
    position_base_amount: u256,
    lot_size: u64
): u128 {
    abort 404
}

fun collateral_symbol<T>(): String {
    abort 404
}

public fun fill_base_and_quote_deltas(
    price: u64,
    size: u64,
): (u256, u256) {
    abort 404
}

fun deallocate_collateral_<T, ADMIN_OR_ASSISTANT>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<ACCOUNT, ADMIN_OR_ASSISTANT>,
    account: &mut Account<T>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    amount: Option<u64>,
    clock: &Clock,
): u64 {
    abort 404
}

public(package) fun deallocate_collateral_internal<T>(
    clearing_house: &mut ClearingHouse<T>,
    account: &mut Account<T>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    amount: Option<u64>,
    clock: &Clock,
): u64 {
    abort 404
}

public(package) fun start_session_<T>(
    mut clearing_house: ClearingHouse<T>,
    account_id: u64,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    uses_priority_gas_price: bool,
    integrator_info: Option<IntegratorInfo>,
    clock: &Clock,
): SessionHotPotato<T> {
    abort 404
}

fun cancel_orders_<T>(
    clearing_house: &mut ClearingHouse<T>,
    account_id: u64,
    order_ids: &vector<u128>,
    cancelation_reason: u8,
) {
    abort 404
}

fun try_cancel_orders_<T>(
    clearing_house: &mut ClearingHouse<T>,
    account_id: u64,
    order_ids: &vector<u128>,
    cancel_stale_at: Option<u64>,
    account_base: u256,
): vector<bool> {
    abort 404
}

//************************************************************************************************//
// Internal Functions                                                                             //
//************************************************************************************************//

fun create_clearing_house_<T, VendorKey, ADMIN_OR_ASSISTANT>(
    orderbook: Orderbook,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    registry: &mut Registry,
    clock: &Clock,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    base_source_id: u16,
    collateral_source_id: u16,
    decimals: u64,
    margin_ratio_initial: u256,
    margin_ratio_maintenance: u256,
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
    ctx: &mut TxContext,
): ClearingHouse<T> {
    abort 404
}

//************************************************************************************************//
// Validity Checks                                                                                //
//************************************************************************************************//

public(package) fun assert_package_version<T>(clearing_house: &ClearingHouse<T>) {
    abort 404
}

fun assert_market_is_paused<T>(ch: &ClearingHouse<T>) {
    abort 404
}

public(package) fun assert_market_is_not_paused<T>(ch: &ClearingHouse<T>) {
    abort 404
}

fun assert_market_allows_order_cancellation<T>(ch: &ClearingHouse<T>) {
    abort 404
}

fun assert_valid_pause_mode(pause_mode: u8) {
    abort 404
}

fun assert_market_is_closed<T>(ch: &ClearingHouse<T>) {
    abort 404
}

public(package) fun assert_market_is_not_closed<T>(ch: &ClearingHouse<T>) {
    abort 404
}

fun assert_order_value(
    size_posted: u64,
    index_price: u256,
    min_order_usd_value: u256
) {
    abort 404
}

fun assert_settlement_prices(
    base_settlement_price: u256,
    collateral_settlement_price: u256,
) {
    abort 404
}

fun assert_reduce_only<T>(hot_potato: &SessionHotPotato<T>, side: bool, size: u64, reduce_only: bool): u64 {
    abort 404
}
