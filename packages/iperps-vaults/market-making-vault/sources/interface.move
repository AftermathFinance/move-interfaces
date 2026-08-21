// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module market_making_vault::interface;

use market_making_vault::vault::{Self, Vault, DepositSession, WithdrawSession, UserLpCoin};
use market_making_vault::authority::{PACKAGE, VAULT, PAUSE_GUARDIAN, MAINTENANCE, TREASURY, FREEZE_GUARDIAN};
use market_making_vault::metadata::VaultMetadata;
use market_making_vault::perpetuals_api;
use market_making_vault::config::Config;

use perpetuals::clearing_house::{ClearingHouse, SessionHotPotato, SessionSummary};
use perpetuals::account::{Account, IntegratorInfo};
use perpetuals::twap_orders::TWAPOrderDetails;
use perpetuals::registry::Registry;

use oracle_aggregator::price_feed_storage::PriceFeedStorage;

use authority_cap::authority::{AuthorityCap, ADMIN, ASSISTANT};

use std::option::Option;

use sui::coin::{CoinMetadata, TreasuryCap};
use sui::coin_registry::{CoinRegistry, Currency};
use sui::clock::Clock;
use sui::coin::Coin;
use sui::sui::SUI;

use std::ascii::String;

//************************************************************************************************//
// UserLpCoin                                                                                     //
//************************************************************************************************//

//******************************************* Mutators *******************************************//

public fun join<L>(
    user_lp_coin: &mut UserLpCoin<L>,
    config: &mut Config,
    other_user_lp_coin: UserLpCoin<L>,
) {
    abort 404
}

public fun split<L>(
    user_lp_coin: &mut UserLpCoin<L>,
    config: &mut Config,
    amount: u64,
    ctx: &mut TxContext
): UserLpCoin<L> {
    abort 404
}

//************************************************************************************************//
// Vault                                                                                          //
//************************************************************************************************//

//****************************************** Constructors ****************************************//

public fun create_vault<L, C>(
    perps_registry: &mut Registry,
    config: &mut Config,
    lp_treasury_cap: TreasuryCap<L>,
    coin_registry: &mut CoinRegistry,
    lp_coin_metadata: &CoinMetadata<L>,
    collateral_metadata: &CoinMetadata<C>,
    collateral_oracle: &PriceFeedStorage,
    lock_period: u64,
    owner_fee_rate: u256,
    force_withdraw_delay: u64,
    owner_locked_liquidity: Coin<C>,
    name: String,
    description: String,
    curator_name: Option<String>,
    curator_url: Option<String>,
    curator_logo_url: Option<String>,
    extra_field_keys: Option<vector<String>>,
    extra_field_values: Option<vector<String>>,
    clock: &Clock,
    ctx: &mut TxContext
) {
    abort 404
}

public fun create_vault_with_currency<L, C>(
    perps_registry: &mut Registry,
    config: &mut Config,
    lp_treasury_cap: TreasuryCap<L>,
    lp_currency: &Currency<L>,
    collateral_currency: &Currency<C>,
    collateral_oracle: &PriceFeedStorage,
    lock_period: u64,
    owner_fee_rate: u256,
    force_withdraw_delay: u64,
    owner_locked_liquidity: Coin<C>,
    name: String,
    description: String,
    curator_name: Option<String>,
    curator_url: Option<String>,
    curator_logo_url: Option<String>,
    extra_field_keys: Option<vector<String>>,
    extra_field_values: Option<vector<String>>,
    clock: &Clock,
    ctx: &mut TxContext
) {
    abort 404
}

public fun create_vault_with_collateral_currency<L, C>(
    perps_registry: &mut Registry,
    config: &mut Config,
    lp_treasury_cap: TreasuryCap<L>,
    coin_registry: &mut CoinRegistry,
    lp_coin_metadata: &CoinMetadata<L>,
    collateral_currency: &Currency<C>,
    collateral_oracle: &PriceFeedStorage,
    lock_period: u64,
    owner_fee_rate: u256,
    force_withdraw_delay: u64,
    owner_locked_liquidity: Coin<C>,
    name: String,
    description: String,
    curator_name: Option<String>,
    curator_url: Option<String>,
    curator_logo_url: Option<String>,
    extra_field_keys: Option<vector<String>>,
    extra_field_values: Option<vector<String>>,
    clock: &Clock,
    ctx: &mut TxContext
) {
    abort 404
}

//******************************************* Mutators *******************************************//

public fun add_yield<L, C>(
    vault: &Vault<L, C>,
    account: &mut Account<C>,
    perps_registry: &Registry,
    coin_in: Coin<C>,
) {
    abort 404
}

public fun start_deposit_session<L, C>(
    vault: Vault<L, C>,
    config: &Config,
    account: Account<C>,
    collateral_oracle: &PriceFeedStorage,
    coin: Coin<C>,
    clock: &Clock,
    ctx: &TxContext
): DepositSession<L, C> {
    abort 404
}

public fun process_clearing_house_for_deposit<L, C>(
    deposit_session: &mut DepositSession<L, C>,
    clearing_house: ClearingHouse<C>,
    base_oracle: &PriceFeedStorage,
    clock: &Clock,
) {
    abort 404
}

public fun end_deposit_session<L, C>(
    deposit_session: DepositSession<L, C>,
    config: &mut Config,
    min_expected_lp_coin_out: u64,
    perps_registry: &Registry,
    ctx: &mut TxContext
): UserLpCoin<L> {
    abort 404
}

public fun create_withdraw_request<L, C>(
    vault: &mut Vault<L, C>,
    config: &mut Config,
    user_lp_coin: UserLpCoin<L>,
    lp_coin_amount: u64,
    min_expected_balance_out: u64,
    clock: &Clock,
    ctx: &mut TxContext
) {
    abort 404
}

public fun remove_withdraw_request<L, C>(
    vault: &mut Vault<L, C>,
    ctx: &mut TxContext
): UserLpCoin<L> {
    abort 404
}

public fun set_new_withdraw_request_slippage<L, C>(
    vault: &mut Vault<L, C>,
    min_expected_balance_out: u64,
    ctx: &mut TxContext
) {
    abort 404
}

public fun pause_vault_for_force_withdraw<L, C>(
    vault: &mut Vault<L, C>,
    config: &Config,
    clock: &Clock,
    ctx: &TxContext,
) {
    abort 404
}

public fun resume_vault_for_force_withdraw<L, C>(
    vault: &mut Vault<L, C>,
    clock: &Clock,
) {
    abort 404
}

public fun start_force_withdraw_session<L, C>(
    vault: Vault<L, C>,
    account: Account<C>,
    collateral_oracle: &PriceFeedStorage,
    clock: &Clock,
    ctx: &TxContext,
): WithdrawSession<L, C> {
    abort 404
}

public fun process_clearing_house_for_force_withdraw<L, C>(
    withdraw_session: &mut WithdrawSession<L, C>,
    clearing_house: ClearingHouse<C>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    size_to_close: u64,
    order_ids: &vector<u128>,
    integrator_info: Option<IntegratorInfo>,
    clock: &Clock,
    ctx: &TxContext
) {
    abort 404
}

public fun end_withdraw_session_and_transfer_to_recipient<L, C>(
    withdraw_session: WithdrawSession<L, C>,
    config: &mut Config,
    perps_registry: &Registry,
    ctx: &mut TxContext
) {
    abort 404
}

public fun end_withdraw_session<L, C>(
    withdraw_session: WithdrawSession<L, C>,
    config: &mut Config,
    perps_registry: &Registry,
    ctx: &mut TxContext
): Coin<C> {
    abort 404
}

//************** Mutators [Permissioned] [AuthorityCap<PACKAGE, ADMIN | ASSISTANT>] **************//

entry fun upgrade_config_version<ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
) {
    abort 404
}

entry fun upgrade_vault_version<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    config: &Config,
) {
    abort 404
}

public fun set_deposit_session_sender<L, C, ADMIN_OR_ASSISTANT>(
    deposit_session: &mut DepositSession<L, C>,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    config: &Config,
    sender: address,
) {
    abort 404
}

entry fun set_min_pause_vault_for_force_withdraw_frequency_ms<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    config: &Config,
    min_pause_vault_for_force_withdraw_frequency_ms: u64,
) {
    abort 404
}

entry fun set_min_force_withdraw_position_usd<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    config: &Config,
    min_force_withdraw_position_usd: u256,
) {
    abort 404
}

entry fun set_max_force_withdraw_mr_tolerance<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    config: &Config,
    max_force_withdraw_mr_tolerance: u256,
) {
    abort 404
}

public fun admin_set_max_markets_in_vault<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    config: &Config,
    max_markets_in_vault: u64
) {
    abort 404
}

public fun set_max_pending_orders_per_position<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    config: &Config,
    max_pending_orders_per_position: u64
) {
    abort 404
}

public fun clip_lock_period<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    config: &Config,
) {
    abort 404
}

public fun clip_force_withdraw_delay<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    config: &Config,
) {
    abort 404
}

public fun clip_owner_fee_rate<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    config: &Config,
) {
    abort 404
}

public fun clip_min_owner_lock_usd<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    config: &Config,
) {
    abort 404
}

public fun clip_max_markets_in_vault<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    config: &Config,
) {
    abort 404
}

public fun clip_max_pending_orders_per_position<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    config: &Config,
) {
    abort 404
}

entry fun set_collateral_pfs_info<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    config: &Config,
    perps_registry: &Registry
) {
    abort 404
}

entry fun set_collateral_pfs_tolerance<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    config: &Config,
    collateral_pfs_tolerance: u64
) {
    abort 404
}

//***************** Mutators [Permissioned] [AuthorityCap<PACKAGE, PAUSE_GUARDIAN>] *****************//

public fun admin_pause_vault<L, C>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<PACKAGE, PAUSE_GUARDIAN>,
    config: &Config,
) {
    abort 404
}

public fun admin_unpause_vault<L, C>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<PACKAGE, PAUSE_GUARDIAN>,
    config: &Config,
) {
    abort 404
}

//**************** Mutators [Permissioned] [AuthorityCap<PACKAGE, FREEZE_GUARDIAN>] **************//

public fun freeze_vault<L, C>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<PACKAGE, FREEZE_GUARDIAN>,
    config: &Config,
) {
    abort 404
}

public fun unfreeze_vault<L, C>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<PACKAGE, ADMIN>,
) {
    abort 404
}

//***************** Mutators [Permissioned] [AuthorityCap<PACKAGE, MAINTENANCE>] *****************//

public fun admin_pause_vault_for_force_withdraw<L, C>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<PACKAGE, MAINTENANCE>,
    config: &Config,
    clock: &Clock,
    withdraw_request_address: address,
) {
    abort 404
}

public fun admin_start_force_withdraw_session_for_address<L, C>(
    vault: Vault<L, C>,
    cap: &AuthorityCap<PACKAGE, MAINTENANCE>,
    config: &Config,
    account: Account<C>,
    collateral_oracle: &PriceFeedStorage,
    address: address,
    clock: &Clock,
    _ctx: &TxContext, // Kept for future use if needed.
): WithdrawSession<L, C> {
    abort 404
}

//**************** Mutators [Permissioned] [AuthorityCap<VAULT<LpCoin>, TREASURY>] ***************//

public fun withdraw_fees<L, C>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, TREASURY>,
    amount_to_withdraw: u64,
    ctx: &mut TxContext
): Coin<C> {
    abort 404
}

//******************** Mutators [Permissioned] [AuthorityCap<VAULT<L>, ADMIN>] *******************//

public fun new_vault_assistant_cap<L, C>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN>,
    config: &Config,
    ctx: &mut TxContext,
): AuthorityCap<VAULT<L>, ASSISTANT> {
    abort 404
}

public fun new_vault_treasury_cap<L, C>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<VAULT<L>, TREASURY> {
    abort 404
}

public fun deauthorize_vault_authority_cap<L, C, Role>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN>,
    cap_id: ID,
) {
    abort 404
}

public fun start_owner_locked_withdraw_session<L, C>(
    vault: Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN>,
    account: Account<C>,
    collateral_oracle: &PriceFeedStorage,
    amount: u64,
    min_expected_balance_out: u64,
    clock: &Clock,
    ctx: &mut TxContext
): WithdrawSession<L, C> {
    abort 404
}

//************** Mutators [Permissioned] [AuthorityCap<VAULT<L>, ADMIN | ASSISTANT>] *************//

public fun start_owner_withdraw_session<L, C, ADMIN_OR_ASSISTANT>(
    vault: Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    config: &mut Config,
    account: Account<C>,
    collateral_oracle: &PriceFeedStorage,
    user_lp_coin: UserLpCoin<L>,
    amount: u64,
    min_expected_balance_out: u64,
    clock: &Clock,
    ctx: &mut TxContext
): WithdrawSession<L, C> {
    abort 404
}

public fun start_owner_process_withdraw_request<L, C, ADMIN_OR_ASSISTANT>(
    vault: Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    account: Account<C>,
    collateral_oracle: &PriceFeedStorage,
    target_request_address: address,
    clock: &Clock,
): WithdrawSession<L, C> {
    abort 404
}

public fun process_clearing_house_for_withdraw<L, C, ADMIN_OR_ASSISTANT>(
    withdraw_session: &mut WithdrawSession<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    clearing_house: ClearingHouse<C>,
    base_oracle: &PriceFeedStorage,
    clock: &Clock,
) {
    abort 404
}

public fun set_owner_fee_rate<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    config: &Config,
    owner_fee_rate: u256,
) {
    abort 404
}

public fun set_lock_period<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    config: &Config,
    lock_period: u64,
) {
    abort 404
}

public fun set_max_total_deposited_collateral<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    max_total_deposited_collateral: u64,
) {
    abort 404
}

public fun set_force_withdraw_delay<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    config: &Config,
    force_withdraw_delay: u64,
) {
    abort 404
}

public fun allocate_collateral_to_position<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    account: &mut Account<C>,
    clearing_house: &mut ClearingHouse<C>,
    amount: u64,
    clock: &Clock,
) {
    abort 404
}

public fun deallocate_collateral_from_position<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    account: &mut Account<C>,
    clearing_house: &mut ClearingHouse<C>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    amount_to_withdraw: Option<u64>,
    clock: &Clock,
) {
    abort 404
}

public fun close_position_at_settlement_prices<L, C>(
    vault: &mut Vault<L, C>,
    account: &mut Account<C>,
    clearing_house: &mut ClearingHouse<C>,
    order_ids: &vector<u128>,
) {
    abort 404
}

public fun reconcile_clearing_house<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    account: &Account<C>,
    clearing_house: &ClearingHouse<C>,
) {
    abort 404
}

public fun remove_empty_clearing_house<L, C>(
    vault: &mut Vault<L, C>,
    account: &Account<C>,
    clearing_house: &ClearingHouse<C>,
) {
    abort 404
}

public fun place_market_order<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    account: &mut Account<C>,
    clearing_house: ClearingHouse<C>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    side: bool,
    size: u64,
    reduce_only: bool,
    integrator_info: Option<IntegratorInfo>,
    clock: &Clock,
    ctx: &TxContext
): ClearingHouse<C> {
    abort 404
}

public fun place_limit_order<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
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

public fun cancel_orders<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    account: &Account<C>,
    clearing_house: &mut ClearingHouse<C>,
    order_ids: &vector<u128>,
    clock: &Clock,
) {
    abort 404
}

public fun try_cancel_orders<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    account: &Account<C>,
    clearing_house: &mut ClearingHouse<C>,
    order_ids: &vector<u128>,
    clock: &Clock,
): vector<bool> {
    abort 404
}

public fun liquidate<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
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

public fun start_perpetuals_session<L, C, ADMIN_OR_ASSISTANT>(
    vault: &Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
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

public fun end_perpetuals_session<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    account: &mut Account<C>,
    hot_potato: SessionHotPotato<C>,
    allocate_missing_margin: bool,
    deallocate_free_collateral: bool,
): ClearingHouse<C> {
    abort 404
}

public fun set_position_initial_margin_ratio<L, C, ADMIN_OR_ASSISTANT>(
    vault: &Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    account: &Account<C>,
    clearing_house: &mut ClearingHouse<C>,
    initial_margin_ratio: u256
) {
    abort 404
}

public fun create_market_position<L, C, ADMIN_OR_ASSISTANT>(
    vault: &Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    account: &Account<C>,
    clearing_house: &mut ClearingHouse<C>,
) {
    abort 404
}

public fun create_stop_order_ticket<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
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

public fun edit_stop_order_ticket_details<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    account: &mut Account<C>,
    registry: &Registry,
    stop_order_ticket_id: ID,
    encrypted_details: vector<u8>,
) {
    abort 404
}

public fun edit_stop_order_ticket_executors<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    account: &mut Account<C>,
    registry: &Registry,
    stop_order_ticket_id: ID,
    executors: vector<address>,
) {
    abort 404
}

public fun admin_delete_stop_order_ticket<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    account: &mut Account<C>,
    registry: &Registry,
    stop_order_ticket_id: ID,
    ctx: &mut TxContext
): Coin<SUI> {
    abort 404
}

public fun create_twap_order_ticket<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    account: &mut Account<C>,
    clearing_house: &ClearingHouse<C>,
    executors: vector<address>,
    gas: Coin<SUI>,
    encrypted_details: vector<u8>,
    ctx: &mut TxContext
): ID {
    abort 404
}

public fun edit_twap_order_ticket_details<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    account: &mut Account<C>,
    registry: &Registry,
    twap_order_ticket_id: ID,
    encrypted_details: vector<u8>,
) {
    abort 404
}

public fun edit_twap_order_ticket_executors<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    account: &mut Account<C>,
    registry: &Registry,
    twap_order_ticket_id: ID,
    executors: vector<address>,
) {
    abort 404
}

public fun admin_cancel_twap_order<L, C, ADMIN_OR_ASSISTANT>(
    vault: &mut Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
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

//******************************* Mutators [Permissioned] [sender] *******************************//

public fun place_stop_order_sltp<L, C>(
    vault: &mut Vault<L, C>,
    clearing_house: ClearingHouse<C>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
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
    clock: &Clock,
    ctx: &mut TxContext
): (SessionSummary, Coin<SUI>, ClearingHouse<C>) {
    abort 404
}

public fun place_stop_order_standalone<L, C>(
    vault: &mut Vault<L, C>,
    clearing_house: ClearingHouse<C>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
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
    clock: &Clock,
    ctx: &mut TxContext
): (SessionSummary, Coin<SUI>, ClearingHouse<C>) {
    abort 404
}

public fun delete_stop_order_ticket<L, C>(
    vault: &mut Vault<L, C>,
    account: &mut Account<C>,
    registry: &Registry,
    stop_order_ticket_id: ID,
    ctx: &mut TxContext
): Coin<SUI> {
    abort 404
}

public fun execute_twap_order<L, C>(
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

public fun finalize_twap_order<L, C>(
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

public fun cancel_twap_order<L, C>(
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

//************************************************************************************************//
// Config                                                                                         //
//************************************************************************************************//

//******************** Mutators [Permissioned] [AuthorityCap<PACKAGE, ADMIN>] ********************//

public fun create_package_assistant_cap(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, ASSISTANT> {
    abort 404
}

public fun create_package_pause_guardian_cap(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, PAUSE_GUARDIAN> {
    abort 404
}

public fun create_package_maintenance_cap(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, MAINTENANCE> {
    abort 404
}

public fun create_package_freeze_guardian_cap(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, FREEZE_GUARDIAN> {
    abort 404
}

public fun deauthorize_package_authority_cap<Role>(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, ADMIN>,
    cap_id: ID,
) {
    abort 404
}

//************************************************************************************************//
// VaultMetadata                                                                                  //
//************************************************************************************************//

//************** Mutators [Permissioned] [AuthorityCap<VAULT<L>, ADMIN | ASSISTANT>] *************//

public fun set_name<L, C, ADMIN_OR_ASSISTANT>(
    metadata: &mut VaultMetadata<L>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    config: &Config,
    vault: &Vault<L, C>,
    name: String,
) {
    abort 404
}

public fun set_description<L, C, ADMIN_OR_ASSISTANT>(
    metadata: &mut VaultMetadata<L>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    config: &Config,
    vault: &Vault<L, C>,
    description: String,
) {
    abort 404
}

public fun set_curator_name<L, C, ADMIN_OR_ASSISTANT>(
    metadata: &mut VaultMetadata<L>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    config: &Config,
    vault: &Vault<L, C>,
    curator_name: String,
) {
    abort 404
}

public fun set_curator_url<L, C, ADMIN_OR_ASSISTANT>(
    metadata: &mut VaultMetadata<L>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    config: &Config,
    vault: &Vault<L, C>,
    curator_url: String,
) {
    abort 404
}

public fun set_curator_logo_url<L, C, ADMIN_OR_ASSISTANT>(
    metadata: &mut VaultMetadata<L>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    config: &Config,
    vault: &Vault<L, C>,
    curator_logo_url: String,
) {
    abort 404
}

public fun set_extra_field<L, C, ADMIN_OR_ASSISTANT>(
    metadata: &mut VaultMetadata<L>,
    cap: &AuthorityCap<VAULT<L>, ADMIN_OR_ASSISTANT>,
    config: &Config,
    vault: &Vault<L, C>,
    key: String,
    value: String,
) {
    abort 404
}
