// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: BUSL-1.1

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module perpetuals::events;

use std::option::Option;
use std::string::String;
use std::type_name::TypeName;
use sui::event::emit;

// =========================================================================
//  Events Structs
// =========================================================================

public struct UpgradedVersion has copy, drop {
    id: ID,
    version: u64
}

public struct CreatedAccount<phantom T> has copy, drop {
    account_obj_id: ID,
    user: address,
    account_id: u64
}

public struct DepositedCollateral<phantom T> has copy, drop {
    account_id: u64,
    collateral: u64,
}

public struct AllocatedCollateral has copy, drop {
    ch_id: ID,
    account_id: u64,
    collateral: u64,
}

public struct WithdrewCollateral<phantom T> has copy, drop {
    account_id: u64,
    collateral: u64,
}

public struct RegisteredCollateralInfo<phantom T> has copy, drop {
    storage_id: u32,
    source_id: u16,
    scaling_factor: u256,
}

public struct DeallocatedCollateral has copy, drop {
    ch_id: ID,
    account_id: u64,
    collateral: u64,
}

public struct CreatedClearingHouse has copy, drop {
    ch_id: ID,
    collateral: String,
    coin_decimals: u64,
    margin_ratio_initial: u256,
    margin_ratio_maintenance: u256,
    base_storage_id: u32,
    base_source_id: u16,
    collateral_storage_id: u32,
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
}

public struct ClosedMarket has copy, drop {
    ch_id: ID,
}

public struct UpdatedSettlementPrices has copy, drop {
    ch_id: ID,
    base_settlement_price: u256,
    collateral_settlement_price: u256,
    settlement_enabled: bool,
}

public struct UpdatedIntegratorAddress has copy, drop {
    integrator_id: u32,
    previous_integrator_address: address,
    new_integrator_address: address,
}

public struct UpdatedPremiumTwap has copy, drop {
    ch_id: ID,
    actual_book_price: u256,
    clipped_book_price: u256,
    index_price: u256,
    premium_twap: u256,
    premium_twap_last_upd_ms: u64,
}

public struct UpdatedSpreadTwap has copy, drop {
    ch_id: ID,
    actual_book_price: u256,
    clipped_book_price: u256,
    index_price: u256,
    spread_twap: u256,
    spread_twap_last_upd_ms: u64,
}

public struct UpdatedFunding has copy, drop {
    ch_id: ID,
    cum_funding_rate_long: u256,
    cum_funding_rate_short: u256,
    funding_last_upd_ms: u64,
}

public struct SettledFunding has copy, drop {
    ch_id: ID,
    account_id: u64,
    collateral_change_usd: u256,
    collateral_after: u256,
    mkt_funding_rate_long: u256,
    mkt_funding_rate_short: u256
}

public struct SetPositionInitialMarginRatio has copy, drop {
    ch_id: ID,
    account_id: u64,
    initial_margin_ratio: u256,
}

public struct FilledMakerOrders has copy, drop {
    events: vector<FilledMakerOrder>,
    book_price: Option<u64>,
}

public struct FilledMakerOrder has copy, drop {
    ch_id: ID,
    maker_account_id: u64,
    taker_account_id: u64,
    order_id: u128,
    client_order_id: Option<u64>,
    filled_size: u64,
    remaining_size: u64,
    canceled_size: u64,
    cancelation_reason: Option<u8>,
    pnl: u256,
    maker_fees: u256,
    mark_price: u256,
    integrator_id: Option<u32>,
    integrator_fee_paid_usd: u256,
}

public struct FilledTakerOrder has copy, drop {
    ch_id: ID,
    taker_account_id: u64,
    taker_pnl: u256,
    taker_fees: u256,
    integrator_id: Option<u32>,
    integrator_fee_paid_usd: u256,
    base_asset_delta_ask: u256,
    quote_asset_delta_ask: u256,
    base_asset_delta_bid: u256,
    quote_asset_delta_bid: u256,
    mark_price: u256,
}

public struct ClosedPositionAtSettlementPrices has copy, drop {
    ch_id: ID,
    account_id: u64,
    pnl: u256,
    base_asset_amount: u256,
    quote_asset_amount: u256,
    deallocated_collateral: u64,
    bad_debt: u256
}

public struct PostedOrder has copy, drop {
    ch_id: ID,
    account_id: u64,
    order_id: u128,
    client_order_id: Option<u64>,
    order_size: u64,
    reduce_only: bool,
    expiration_timestamp_ms: Option<u64>,
    integrator_id: Option<u32>,
    integrator_fee_rate: u32,
    mark_price: u256,
    book_price: Option<u64>,
}

public struct CanceledOrder has copy, drop {
    ch_id: ID,
    account_id: u64,
    size: u64,
    order_id: u128,
    client_order_id: Option<u64>,
    cancelation_reason: u8,
    book_price: Option<u64>,
}

public struct LiquidatedPosition has copy, drop {
    ch_id: ID,
    liqee_account_id: u64,
    liqor_account_id: u64,
    is_liqee_long: bool,
    base_liquidated: u256,
    quote_liquidated: u256,
    liqee_pnl: u256,
    liquidation_fees: u256,
    insurance_fund_fees: u256,
    bad_debt: u256,
    mark_price: u256
}

public struct PerformedLiquidation has copy, drop {
    ch_id: ID,
    liqee_account_id: u64,
    liqor_account_id: u64,
    is_liqee_long: bool,
    base_liquidated: u256,
    quote_liquidated: u256,
    liqor_pnl: u256,
    liqor_fees: u256,
    mark_price: u256,
}

public struct PerformedADL has copy, drop {
    ch_id: ID,
    bad_debt_account_id: u64,
    size_reduced: u64,
    collateral_transferred: u256,
    adl_price: u64,
    counterparty_account_id: u64,
    bad_debt_is_long: bool,
}

public struct SocializedBadDebt has copy, drop {
    ch_id: ID,
    bad_debt_usd: u256,
    socialized_fundings: u256,
    added_to_long: bool,
    cum_funding_rate_long: u256,
    cum_funding_rate_short: u256,
}

public struct CreatedPosition has copy, drop {
    ch_id: ID,
    account_id: u64,
    mkt_funding_rate_long: u256,
    mkt_funding_rate_short: u256,
}

public struct CreatedStopOrderTicket<phantom T> has copy, drop {
    ticket_id: ID,
    account_id: u64,
    executors: vector<address>,
    execution_domain: Option<address>,
    gas: u64,
    stop_order_type: u64,
    encrypted_details: vector<u8>
}

public struct ExecutedStopOrderTicket<phantom T> has copy, drop {
    ticket_id: ID,
    account_id: u64,
    executor: address
}

public struct DeletedStopOrderTicket<phantom T> has copy, drop {
    ticket_id: ID,
    account_id: u64,
    executor: address
}

public struct EditedStopOrderTicketDetails<phantom T> has copy, drop {
    ticket_id: ID,
    account_id: u64,
    encrypted_details: vector<u8>
}

public struct EditedStopOrderTicketExecutors<phantom T> has copy, drop {
    ticket_id: ID,
    account_id: u64,
    executors: vector<address>
}

public struct CreatedTWAPOrderTicket<phantom T> has copy, drop {
    ticket_id: ID,
    ch_id: ID,
    account_id: u64,
    executors: vector<address>,
    execution_domain: Option<address>,
    gas: u64,
    encrypted_details: vector<u8>
}

public struct ProcessedTWAPOrderTicket<phantom T> has copy, drop {
    ticket_id: ID,
    account_id: u64,
    execution_amount: u64,
    filled_amount: u64,
    remainder: u64,
    processed_amount: u64,
    scheduled_amount: u64,
    last_attempt_timestamp_ms: u64,
    retry_anchor_timestamp_ms: u64,
    last_execution_timestamp_ms: u64,
}

public struct FinalizedTWAPOrderTicket<phantom T> has copy, drop {
    ticket_id: ID,
    account_id: u64,
    executor: address,
    deallocated_collateral: u64,
}

public struct CanceledTWAPOrderTicket<phantom T> has copy, drop {
    ticket_id: ID,
    account_id: u64,
    sender: address,
    deallocated_collateral: u64,
    partial_fill: bool,
}

public struct DeletedTWAPOrderTicket<phantom T> has copy, drop {
    ticket_id: ID,
    account_id: u64,
    executor: address,
}

public struct EditedTWAPOrderTicketDetails<phantom T> has copy, drop {
    ticket_id: ID,
    account_id: u64,
    encrypted_details: vector<u8>
}

public struct EditedTWAPOrderTicketExecutors<phantom T> has copy, drop {
    ticket_id: ID,
    account_id: u64,
    executors: vector<address>
}

public struct UpdatedMarginRatios has copy, drop {
    ch_id: ID,
    margin_ratio_initial: u256,
    margin_ratio_maintenance: u256,
}

public struct SetFeeParams has copy, drop {
    ch_id: ID,
    maker_fee: u256,
    taker_fee: u256,
    liquidation_fee: u256,
    insurance_fund_fee: u256,
    priority_taker_fee: Option<u256>,
}

public struct SetTwapParams has copy, drop {
    ch_id: ID,
    funding_frequency_ms: u64,
    funding_period_ms: u64,
    premium_twap_frequency_ms: u64,
    premium_twap_period_ms: u64,
    spread_twap_frequency_ms: u64,
    spread_twap_period_ms: u64
}

public struct SetCoreParams has copy, drop {
    ch_id: ID,
    lot_size: u64,
    tick_size: u64,
    collateral_haircut: u256,
}

public struct SetBaseOracleParams has copy, drop {
    ch_id: ID,
    storage_id: u32,
    source_id: u16,
    pfs_tolerance: u64,
}

public struct SetCollateralOracleParams has copy, drop {
    ch_id: ID,
    storage_id: u32,
    source_id: u16,
    pfs_tolerance: u64,
}

public struct SetRiskLimitParams has copy, drop {
    ch_id: ID,
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

public struct DonatedToInsuranceFund has copy, drop {
    sender: address,
    ch_id: ID,
    amount: u64,
    new_balance: u64,
}

public struct WithdrewFees has copy, drop {
    sender: address,
    ch_id: ID,
    amount: u64,
    vault_balance_after: u64,
}

public struct WithdrewInsuranceFund has copy, drop {
    sender: address,
    ch_id: ID,
    amount: u64,
    insurance_fund_balance_after: u64,
}

public struct UpdatedOpenInterestAndFeesAccrued has copy, drop {
    ch_id: ID,
    open_interest: u256,
    fees_accrued: u256
}

public struct RegisteredVendor has copy, drop {
    vendor_key: TypeName,
    vendor_admin_cap_id: ID,
}

public struct Froze has copy, drop {
    id: ID,
    resume_version: u64,
    guardian_cap_id: ID,
}

public struct Unfroze has copy, drop {
    id: ID,
    version: u64,
}

public(package) fun e01<T>(
    account_obj_id: ID,
    user: address,
    account_id: u64
) {
    abort 404
}

public(package) fun e02<T>(
    account_id: u64,
    collateral: u64,
) {
    abort 404
}

public(package) fun e03(
    ch_id: ID,
    account_id: u64,
    collateral: u64,
) {
    abort 404
}

public(package) fun e04(
    ch_id: ID,
    collateral: String,
    coin_decimals: u64,
    margin_ratio_initial: u256,
    margin_ratio_maintenance: u256,
    base_storage_id: u32,
    base_source_id: u16,
    collateral_storage_id: u32,
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
    tick_size: u64
) {
    abort 404
}

public(package) fun e05(
    id: ID,
    version: u64
) {
    abort 404
}

public(package) fun e06(vendor_key: TypeName, vendor_admin_cap_id: ID) {
    abort 404
}

public(package) fun e07(id: ID, resume_version: u64, guardian_cap_id: ID) {
    abort 404
}

public(package) fun e08(id: ID, version: u64) {
    abort 404
}

public(package) fun e09(ch_id: ID) {
    abort 404
}

public(package) fun e10(
    ch_id: ID,
    base_settlement_price: u256,
    collateral_settlement_price: u256,
    settlement_enabled: bool,
) {
    abort 404
}

public(package) fun e11(
    integrator_id: u32,
    previous_integrator_address: address,
    new_integrator_address: address,
) {
    abort 404
}

public(package) fun e12(
    ch_id: ID,
    actual_book_price: u256,
    clipped_book_price: u256,
    index_price: u256,
    premium_twap: u256,
    premium_twap_last_upd_ms: u64,
) {
    abort 404
}

public(package) fun e13(
    ch_id: ID,
    actual_book_price: u256,
    clipped_book_price: u256,
    index_price: u256,
    spread_twap: u256,
    spread_twap_last_upd_ms: u64,
) {
    abort 404
}

public(package) fun e14(
    ch_id: ID,
    cum_funding_rate_long: u256,
    cum_funding_rate_short: u256,
    funding_last_upd_ms: u64
) {
    abort 404
}

public(package) fun e15(
    ch_id: ID,
    account_id: u64,
    collateral_change_usd: u256,
    collateral_after: u256,
    mkt_funding_rate_long: u256,
    mkt_funding_rate_short: u256
) {
    abort 404
}

public(package) fun e16(
    ch_id: ID,
    account_id: u64,
    initial_margin_ratio: u256,
) {
    abort 404
}

public(package) fun e17(
    ch_id: ID,
    account_id: u64,
    order_id: u128,
    client_order_id: Option<u64>,
    order_size: u64,
    reduce_only: bool,
    expiration_timestamp_ms: Option<u64>,
    integrator_id: Option<u32>,
    integrator_fee_rate: u32,
    mark_price: u256,
    book_price: Option<u64>,
) {
    abort 404
}

public(package) fun e18(
    events: vector<FilledMakerOrder>,
    book_price: Option<u64>,
) {
    abort 404
}

public(package) fun e19(
    ch_id: ID,
    maker_account_id: u64,
    taker_account_id: u64,
    order_id: u128,
    client_order_id: Option<u64>,
    filled_size: u64,
    remaining_size: u64,
    canceled_size: u64,
    cancelation_reason: Option<u8>,
    pnl: u256,
    maker_fees: u256,
    mark_price: u256,
    integrator_id: Option<u32>,
    integrator_fee_paid_usd: u256,
): FilledMakerOrder {
    abort 404
}

public(package) fun e20(
    ch_id: ID,
    taker_account_id: u64,
    taker_pnl: u256,
    taker_fees: u256,
    integrator_id: Option<u32>,
    integrator_fee_paid_usd: u256,
    base_asset_delta_ask: u256,
    quote_asset_delta_ask: u256,
    base_asset_delta_bid: u256,
    quote_asset_delta_bid: u256,
    mark_price: u256,
) {
    abort 404
}

public(package) fun e21(
    ch_id: ID,
    account_id: u64,
    pnl: u256,
    base_asset_amount: u256,
    quote_asset_amount: u256,
    deallocated_collateral: u64,
    bad_debt: u256
) {
    abort 404
}

public(package) fun e22(
    ch_id: ID,
    account_id: u64,
    order_id: u128,
    client_order_id: Option<u64>,
    size: u64,
    cancelation_reason: u8,
    book_price: Option<u64>,
) {
    abort 404
}

public(package) fun e23(
    ch_id: ID,
    liqee_account_id: u64,
    liqor_account_id: u64,
    is_liqee_long: bool,
    base_liquidated: u256,
    quote_liquidated: u256,
    liqee_pnl: u256,
    liquidation_fees: u256,
    insurance_fund_fees: u256,
    bad_debt: u256,
    mark_price: u256
) {
    abort 404
}

public(package) fun e24(
    ch_id: ID,
    liqee_account_id: u64,
    liqor_account_id: u64,
    is_liqee_long: bool,
    base_liquidated: u256,
    quote_liquidated: u256,
    liqor_pnl: u256,
    liqor_fees: u256,
    mark_price: u256,
) {
    abort 404
}

public(package) fun e25(
    ch_id: ID,
    bad_debt_account_id: u64,
    size_reduced: u64,
    collateral_transferred: u256,
    adl_price: u64,
    counterparty_account_id: u64,
    bad_debt_is_long: bool,
) {
    abort 404
}

public(package) fun e26(
    ch_id: ID,
    bad_debt_usd: u256,
    socialized_fundings: u256,
    added_to_long: bool,
    cum_funding_rate_long: u256,
    cum_funding_rate_short: u256,
) {
    abort 404
}

public(package) fun e27<T>(
    account_id: u64,
    collateral: u64,
) {
    abort 404
}

public(package) fun e28<T>(
    storage_id: u32,
    source_id: u16,
    scaling_factor: u256,
) {
    abort 404
}

public(package) fun e29(
    ch_id: ID,
    account_id: u64,
    collateral: u64,
) {
    abort 404
}

public(package) fun e30(
    ch_id: ID,
    account_id: u64,
    mkt_funding_rate_long: u256,
    mkt_funding_rate_short: u256,
) {
    abort 404
}

public(package) fun e31<T>(
    ticket_id: ID,
    account_id: u64,
    executors: vector<address>,
    execution_domain: Option<address>,
    gas: u64,
    stop_order_type: u64,
    encrypted_details: vector<u8>
) {
    abort 404
}

public(package) fun e32<T>(
    ticket_id: ID,
    account_id: u64,
    executor: address,
) {
    abort 404
}

public(package) fun e33<T>(
    ticket_id: ID,
    account_id: u64,
    executor: address
) {
    abort 404
}

public(package) fun e34<T>(
    ticket_id: ID,
    account_id: u64,
    encrypted_details: vector<u8>
) {
    abort 404
}

public(package) fun e35<T>(
    ticket_id: ID,
    account_id: u64,
    executors: vector<address>
) {
    abort 404
}

public(package) fun e36<T>(
    ticket_id: ID,
    ch_id: ID,
    account_id: u64,
    executors: vector<address>,
    execution_domain: Option<address>,
    gas: u64,
    encrypted_details: vector<u8>
) {
    abort 404
}

public(package) fun e37<T>(
    ticket_id: ID,
    account_id: u64,
    execution_amount: u64,
    filled_amount: u64,
    remainder: u64,
    processed_amount: u64,
    scheduled_amount: u64,
    last_attempt_timestamp_ms: u64,
    retry_anchor_timestamp_ms: u64,
    last_execution_timestamp_ms: u64,
) {
    abort 404
}

public(package) fun e38<T>(
    ticket_id: ID,
    account_id: u64,
    executor: address,
    deallocated_collateral: u64,
) {
    abort 404
}

public(package) fun e39<T>(
    ticket_id: ID,
    account_id: u64,
    sender: address,
    deallocated_collateral: u64,
    partial_fill: bool,
) {
    abort 404
}

public(package) fun e40<T>(
    ticket_id: ID,
    account_id: u64,
    executor: address,
) {
    abort 404
}

public(package) fun e41<T>(
    ticket_id: ID,
    account_id: u64,
    encrypted_details: vector<u8>
) {
    abort 404
}

public(package) fun e42<T>(
    ticket_id: ID,
    account_id: u64,
    executors: vector<address>
) {
    abort 404
}

public(package) fun e43(
    ch_id: ID,
    margin_ratio_initial: u256,
    margin_ratio_maintenance: u256,
) {
    abort 404
}

public(package) fun e44(
    ch_id: ID,
    maker_fee: u256,
    taker_fee: u256,
    liquidation_fee: u256,
    insurance_fund_fee: u256,
    priority_taker_fee: Option<u256>,
) {
    abort 404
}

public(package) fun e45(
    ch_id: ID,
    funding_frequency_ms: u64,
    funding_period_ms: u64,
    premium_twap_frequency_ms: u64,
    premium_twap_period_ms: u64,
    spread_twap_frequency_ms: u64,
    spread_twap_period_ms: u64,
) {
    abort 404
}

public(package) fun e46(
    ch_id: ID,
    lot_size: u64,
    tick_size: u64,
    collateral_haircut: u256,
) {
    abort 404
}

public(package) fun e47(
    ch_id: ID,
    storage_id: u32,
    source_id: u16,
    pfs_tolerance: u64,
) {
    abort 404
}

public(package) fun e48(
    ch_id: ID,
    storage_id: u32,
    source_id: u16,
    pfs_tolerance: u64,
) {
    abort 404
}

public(package) fun e49(
    ch_id: ID,
    min_order_usd_value: u256,
    max_pending_orders: u64,
    max_open_interest: u256,
    max_open_interest_threshold: u256,
    max_open_interest_position_percent: u256,
    max_book_index_spread: u256,
    max_index_twap_divergence: u256,
    max_bad_debt: u256,
    max_socialize_losses_mr_decrease: u256,
) {
    abort 404
}

public(package) fun e50(
    sender: address,
    ch_id: ID,
    amount: u64,
    new_balance: u64,
) {
    abort 404
}

public(package) fun e51(
    sender: address,
    ch_id: ID,
    amount: u64,
    vault_balance_after: u64,
) {
    abort 404
}

public(package) fun e52(
    sender: address,
    ch_id: ID,
    amount: u64,
    insurance_fund_balance_after: u64,
) {
    abort 404
}

public(package) fun e53(
    ch_id: ID,
    open_interest: u256,
    fees_accrued: u256,
) {
    abort 404
}

public(package) fun e54(event: &FilledMakerOrder): (u256, u256) {
    abort 404
}
