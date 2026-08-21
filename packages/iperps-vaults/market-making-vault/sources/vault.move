// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module market_making_vault::vault;

use market_making_vault::metadata::VaultMetadata;
use market_making_vault::authority::{PACKAGE, VAULT, TREASURY, FREEZE_GUARDIAN};
use market_making_vault::config::Config;
use market_making_vault::errors;
use market_making_vault::events;
use market_making_vault::keys;

use perpetuals::clearing_house::{Self as ch, ClearingHouse, Executor, SessionSummary};
use perpetuals::market::{MarketParams, MarketState};
use perpetuals::account::{Account, IntegratorInfo};
use perpetuals::authority::ACCOUNT;
use perpetuals::registry::Registry;

use position::position::Position;

use authority_cap::authority::{AuthorityCap, ADMIN, ASSISTANT};

use oracle_aggregator::price_feed_storage::{Self as price_feed_storage, PriceFeedStorage};
use oracle_aggregator::price_feed;

use ifixed::ifixed;

use std::option::{Self as option, Option};

use sui::coin::{Self, Coin, CoinMetadata, TreasuryCap};
use sui::balance::{Self, Balance, Supply};
use sui::coin_registry::{CoinRegistry, Currency};
use sui::dynamic_object_field as dof;
use sui::dynamic_field as df;
use sui::clock::Clock;

use std::ascii::String;
use std::u64::min;

use fun perpetuals::account::create_account as Registry.create_account;

public use fun market_making_vault::interface::join as UserLpCoin.join;
public use fun market_making_vault::interface::split as UserLpCoin.split;
public use fun market_making_vault::interface::allocate_collateral_to_position as Vault.allocate_collateral_to_position;
public use fun market_making_vault::interface::deallocate_collateral_from_position as Vault.deallocate_collateral_from_position;
public use fun market_making_vault::interface::place_market_order as Vault.place_market_order;
public use fun market_making_vault::interface::place_limit_order as Vault.place_limit_order;
public use fun market_making_vault::interface::cancel_orders as Vault.cancel_orders;
public use fun market_making_vault::interface::try_cancel_orders as Vault.try_cancel_orders;
public use fun market_making_vault::interface::liquidate as Vault.liquidate;
public use fun market_making_vault::interface::start_perpetuals_session as Vault.start_perpetuals_session;
public use fun market_making_vault::interface::end_perpetuals_session as Vault.end_perpetuals_session;
public use fun market_making_vault::interface::set_position_initial_margin_ratio as Vault.set_position_initial_margin_ratio;
public use fun market_making_vault::interface::create_market_position as Vault.create_market_position;
public use fun market_making_vault::interface::create_stop_order_ticket as Vault.create_stop_order_ticket;
public use fun market_making_vault::interface::edit_stop_order_ticket_details as Vault.edit_stop_order_ticket_details;
public use fun market_making_vault::interface::edit_stop_order_ticket_executors as Vault.edit_stop_order_ticket_executors;
public use fun market_making_vault::interface::admin_delete_stop_order_ticket as Vault.admin_delete_stop_order_ticket;
public use fun market_making_vault::interface::delete_stop_order_ticket as Vault.delete_stop_order_ticket;
public use fun market_making_vault::interface::create_twap_order_ticket as Vault.create_twap_order_ticket;
public use fun market_making_vault::interface::edit_twap_order_ticket_details as Vault.edit_twap_order_ticket_details;
public use fun market_making_vault::interface::edit_twap_order_ticket_executors as Vault.edit_twap_order_ticket_executors;
public use fun market_making_vault::interface::execute_twap_order as Vault.execute_twap_order;
public use fun market_making_vault::interface::finalize_twap_order as Vault.finalize_twap_order;
public use fun market_making_vault::interface::cancel_twap_order as Vault.cancel_twap_order;
public use fun market_making_vault::interface::admin_cancel_twap_order as Vault.admin_cancel_twap_order;
public use fun market_making_vault::interface::place_stop_order_sltp as Vault.place_stop_order_sltp;
public use fun market_making_vault::interface::place_stop_order_standalone as Vault.place_stop_order_standalone;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error(code = 0)]
const EInvalidVaultAuthorityCap: vector<u8> = b"The provided AuthorityCap does not have permission to manage this Vault.";

#[error(code = 1)]
const EInvalidAccountAuthorityCap: vector<u8> = b"The provided Account is not authorized for this Vault.";

//************************************************************************************************//
// Constants                                                                                      //
//************************************************************************************************//

const B9_SCALING: u256 = 0_000_000_001_000_000_000;

//************************************************************************************************//
// VaultParams                                                                                    //
//************************************************************************************************//

public struct VaultParams has store {
    lock_period: u64,

    owner_fee_rate: u256,

    force_withdraw_delay: u64,

    min_pause_vault_for_force_withdraw_frequency_ms: u64,

    collateral_storage_id: u32,

    collateral_source_id: u16,

    collateral_pfs_tolerance: u64,

    // Accepted margin ratio error when force withdrawing
    max_force_withdraw_mr_tolerance: u256,

    min_force_withdraw_position_usd: u256,

    min_owner_lock_usd: u256,

    scaling_factor: u256,

    max_markets_in_vault: u64,

    max_pending_orders_per_position: u64,

    max_total_deposited_collateral: u64
}

//************************************************************************************************//
// Vaults                                                                                         //
//************************************************************************************************//

public struct Vault<phantom L, phantom C> has key, store {
    id: UID,

    version: u64,

    lp_supply: Supply<L>,

    ch_ids: vector<ID>,

    paused: Option<u64>,

    last_paused_timestamp_ms: u64,

    vault_params: VaultParams
}

//****************************************** Constructors ****************************************//

public(package) fun new<L, C>(
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

public(package) fun new_with_currency<L, C>(
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

public(package) fun new_with_collateral_currency<L, C>(
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

#[allow(lint(self_transfer))]
fun new_impl<L, C>(
    perps_registry: &mut Registry,
    config: &mut Config,
    lp_treasury_cap: TreasuryCap<L>,
    lp_decimals: u8,
    collateral_decimals: u8,
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

#[lint_allow(share_owned)]
fun share_clearing_house<C>(clearing_house: ClearingHouse<C>) {
    abort 404
}

//******************************************** Getters *******************************************//

public(package) fun account_cap<L, C>(
    vault: &Vault<L, C>
): &AuthorityCap<ACCOUNT, ADMIN> {
    abort 404
}

public fun is_authority_cap_authorized<L, C, Role>(
    vault: &Vault<L, C>,
    cap_id: ID,
): bool {
    abort 404
}

public fun active_assistant_count<L, C>(
    vault: &Vault<L, C>
): u64 {
    abort 404
}

public(package) fun id<L, C>(
    vault: &Vault<L, C>,
): ID {
    abort 404
}

public(package) fun execution_domain<L, C>(
    vault: &Vault<L, C>,
): address {
    abort 404
}

public(package) fun executor<L, C>(
    vault: &Vault<L, C>,
    ctx: &TxContext,
): Executor {
    abort 404
}

public(package) fun version<L, C>(
    vault: &Vault<L, C>,
): u64 {
    abort 404
}

public fun is_frozen<L, C>(
    vault: &Vault<L, C>,
): bool {
    abort 404
}

public fun lp_supply_value<L, C>(
    vault: &Vault<L, C>,
): u64 {
    abort 404
}

public(package) fun lock_period<L, C>(
    vault: &Vault<L, C>
): u64 {
    abort 404
}

public(package) fun force_withdraw_delay<L, C>(
    vault: &Vault<L, C>
): u64 {
    abort 404
}

public(package) fun ch_ids<L, C>(
    vault: &Vault<L, C>
): vector<ID> {
    abort 404
}

public(package) fun ch_ids_mut<L, C>(
    vault: &mut Vault<L, C>
): &mut vector<ID> {
    abort 404
}

public(package) fun remove_ch_id<L, C>(
    vault: &mut Vault<L, C>,
    clearing_house_id: ID,
) {
    abort 404
}

public(package) fun max_markets_in_vault<L, C>(
    vault: &Vault<L, C>
): u64 {
    abort 404
}

public(package) fun max_pending_orders_per_position<L, C>(
    vault: &Vault<L, C>
): u64 {
    abort 404
}

fun has_authority<L, C, Role>(
    vault: &Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, Role>,
): bool {
    abort 404
}

fun has_treasury_authority<L, C>(
    vault: &Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, TREASURY>,
): bool {
    abort 404
}

public(package) fun position_has_no_value<C>(
    clearing_house: &ClearingHouse<C>,
    account_id: u64,
): bool {
    abort 404
}

public(package) fun get_vault_margin_in_market<L, C>(
    _vault: &Vault<L, C>,
    clearing_house: &ClearingHouse<C>,
    account_id: u64,
    mark_price: u256,
    collateral_price: u256,
    margin_ratio: u256,
    collateral_haircut: u256,
    abort_if_negative: bool,
): (u256, u256) {
    abort 404
}

public(package) fun owner_fees_mut<L, C>(
    vault: &mut Vault<L, C>
): &mut Balance<C> {
    abort 404
}

public(package) fun owner_locked_lp_balance<L, C>(
    vault: &Vault<L, C>
): &Balance<L> {
    abort 404
}

public(package) fun owner_locked_lp_balance_mut<L, C>(
    vault: &mut Vault<L, C>
): &mut Balance<L> {
    abort 404
}

public(package) fun withdraw_request_mut<L, C>(
    vault: &mut Vault<L, C>,
    sender: address
): &mut WithdrawRequest<L> {
    abort 404
}

//******************************************* Mutators *******************************************//

public(package) fun add_yield<L, C>(
    vault: &Vault<L, C>,
    account: &mut Account<C>,
    perps_registry: &Registry,
    coin_in: Coin<C>,
) {
    abort 404
}

public(package) fun admin_pause_vault<L, C>(
    vault: &mut Vault<L, C>,
) {
    abort 404
}

public(package) fun admin_unpause_vault<L, C>(
    vault: &mut Vault<L, C>,
) {
    abort 404
}

public(package) fun freeze_vault<L, C>(
    vault: &mut Vault<L, C>,
    config: &Config,
    cap: &AuthorityCap<PACKAGE, FREEZE_GUARDIAN>,
) {
    abort 404
}

public(package) fun unfreeze_vault<L, C>(
    vault: &mut Vault<L, C>,
    _: &AuthorityCap<PACKAGE, ADMIN>,
) {
    abort 404
}

public(package) fun admin_pause_vault_for_force_withdraw<L, C>(
    vault: &mut Vault<L, C>,
    config: &Config,
    clock: &Clock,
    withdraw_request_address: address,
) {
    abort 404
}

public(package) fun pause_vault_for_force_withdraw<L, C>(
    vault: &mut Vault<L, C>,
    config: &Config,
    clock: &Clock,
    withdraw_request_address: address,
) {
    abort 404
}

public(package) fun resume_vault_for_force_withdraw<L, C>(
    vault: &mut Vault<L, C>,
    clock: &Clock,
) {
    abort 404
}

public(package) fun withdraw_fees<L, C>(
    vault: &mut Vault<L, C>,
    amount_to_withdraw: u64,
    ctx: &mut TxContext
): Coin<C> {
    abort 404
}

public(package) fun upgrade_vault_version<L, C>(
    vault: &mut Vault<L, C>
) {
    abort 404
}

public(package) fun set_collateral_pfs_info<L, C>(
    vault: &mut Vault<L, C>,
    perps_registry: &Registry,
) {
    abort 404
}

public(package) fun set_collateral_pfs_tolerance<L, C>(
    vault: &mut Vault<L, C>,
    collateral_pfs_tolerance: u64
) {
    abort 404
}

public(package) fun set_min_pause_vault_for_force_withdraw_frequency_ms<L, C>(
    vault: &mut Vault<L, C>,
    min_pause_vault_for_force_withdraw_frequency_ms: u64
) {
    abort 404
}

public(package) fun set_min_force_withdraw_position_usd<L, C>(
    vault: &mut Vault<L, C>,
    min_force_withdraw_position_usd: u256
) {
    abort 404
}

public(package) fun set_max_force_withdraw_mr_tolerance<L, C>(
    vault: &mut Vault<L, C>,
    config: &Config,
    max_force_withdraw_mr_tolerance: u256
) {
    abort 404
}

public(package) fun set_max_markets_in_vault<L, C>(
    vault: &mut Vault<L, C>,
    config: &Config,
    max_markets_in_vault: u64
) {
    abort 404
}

public(package) fun admin_set_max_markets_in_vault<L, C>(
    vault: &mut Vault<L, C>,
    max_markets_in_vault: u64
) {
    abort 404
}

public(package) fun set_max_pending_orders_per_position<L, C>(
    vault: &mut Vault<L, C>,
    config: &Config,
    max_pending_orders_per_position: u64
) {
    abort 404
}

public(package) fun set_owner_fee_rate<L, C>(
    vault: &mut Vault<L, C>,
    config: &Config,
    owner_fee_rate: u256,
) {
    abort 404
}

public(package) fun set_lock_period<L, C>(
    vault: &mut Vault<L, C>,
    config: &Config,
    lock_period: u64,
) {
    abort 404
}

public(package) fun set_force_withdraw_delay<L, C>(
    vault: &mut Vault<L, C>,
    config: &Config,
    force_withdraw_delay: u64,
) {
    abort 404
}

public(package) fun set_max_total_deposited_collateral<L, C>(
    vault: &mut Vault<L, C>,
    max_total_deposited_collateral: u64,
) {
    abort 404
}

public(package) fun clip_lock_period<L, C>(
    vault: &mut Vault<L, C>,
    config: &Config,
) {
    abort 404
}

public(package) fun clip_force_withdraw_delay<L, C>(
    vault: &mut Vault<L, C>,
    config: &Config,
) {
    abort 404
}

public(package) fun clip_owner_fee_rate<L, C>(
    vault: &mut Vault<L, C>,
    config: &Config,
) {
    abort 404
}

public(package) fun clip_min_owner_lock_usd<L, C>(
    vault: &mut Vault<L, C>,
    config: &Config,
) {
    abort 404
}

public(package) fun clip_max_markets_in_vault<L, C>(
    vault: &mut Vault<L, C>,
    config: &Config,
) {
    abort 404
}

public(package) fun clip_max_pending_orders_per_position<L, C>(
    vault: &mut Vault<L, C>,
    config: &Config,
) {
    abort 404
}

//******************** Mutators [Permissioned] [AuthorityCap<VAULT<L>, ADMIN>] *******************//

public(package) fun new_vault_assistant_cap<L, C>(
    vault: &mut Vault<L, C>,
    authority_cap: &AuthorityCap<VAULT<L>, ADMIN>,
    config: &Config,
    ctx: &mut TxContext,
): AuthorityCap<VAULT<L>, ASSISTANT> {
    abort 404
}

public(package) fun deauthorize_vault_authority_cap<L, C, Role>(
    vault: &mut Vault<L, C>,
    authority_cap: &AuthorityCap<VAULT<L>, ADMIN>,
    cap_id: ID,
) {
    abort 404
}

public(package) fun new_vault_treasury_cap<L, C>(
    vault: &mut Vault<L, C>,
    authority_cap: &AuthorityCap<VAULT<L>, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<VAULT<L>, TREASURY> {
    abort 404
}

//************************************************************************************************//
// UserLpCoin                                                                                     //
//************************************************************************************************//

public struct UserLpCoin<phantom L> has key, store {
    id: UID,

    lp_balance: Balance<L>,

    start_timestamp_ms: u64,

    provided_value_usd: u256
}

//****************************************** Constructors ****************************************//
//***************************************** Deconstructors ***************************************//

//******************************************** Getters *******************************************//

public fun user_lp_coin_info<L>(
    user_lp_coin: &UserLpCoin<L>
): (u64, u64) {
    abort 404
}

//******************************************* Mutators *******************************************//

public(package) fun join_user_lp_coin<L>(
    user_lp_coin: &mut UserLpCoin<L>,
    config: &mut Config,
    other_user_lp_coin: UserLpCoin<L>,
) {
    abort 404
}

fun join_user_lp_coin_<L>(
    user_lp_coin: &mut UserLpCoin<L>,
    other_user_lp_coin: UserLpCoin<L>,
) {
    abort 404
}

public(package) fun split_user_lp_coin<L>(
    user_lp_coin: &mut UserLpCoin<L>,
    config: &mut Config,
    amount: u64,
    ctx: &mut TxContext
): UserLpCoin<L> {
    abort 404
}

fun split_user_lp_coin_<L>(
    user_lp_coin: &mut UserLpCoin<L>,
    amount: u64,
    ctx: &mut TxContext
): UserLpCoin<L> {
    abort 404
}

//************************************************************************************************//
// DepositSession                                                                                 //
//************************************************************************************************//

public struct DepositSession<phantom L, phantom C> {
    vault: Vault<L, C>,

    account: Account<C>,

    sender: address,

    timestamp_ms: u64,

    collateral_price: u256,

    ch_ids: vector<ID>,

    vault_balance_value: u256,

    provided_balance: Balance<C>,
}

//****************************************** Constructors ****************************************//

fun create_deposit_session<L, C>(
    vault: Vault<L, C>,
    account: Account<C>,
    sender: address,
    balance: Balance<C>,
    timestamp_ms: u64,
    collateral_price: u256,
): DepositSession<L, C>  {
    abort 404
}

public(package) fun start_deposit_session<L, C>(
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

//***************************************** Deconstructors ***************************************//

#[lint_allow(share_owned)]
public(package) fun end_deposit_session<L, C>(
    deposit_session: DepositSession<L, C>,
    config: &mut Config,
    min_expected_lp_coin_out: u64,
    perps_registry: &Registry,
    ctx: &mut TxContext
): UserLpCoin<L> {
    abort 404
}

//******************************************* Mutators *******************************************//

public(package) fun set_deposit_session_sender<L, C>(
    deposit_session: &mut DepositSession<L, C>,
    sender: address,
) {
    abort 404
}

public(package) fun process_clearing_house_for_deposit<L, C>(
    deposit_session: &mut DepositSession<L, C>,
    mut clearing_house: ClearingHouse<C>,
    base_oracle: &PriceFeedStorage,
    clock: &Clock,
) {
    abort 404
}

//************************************************************************************************//
// WithdrawRequest                                                                                //
//************************************************************************************************//

public struct WithdrawRequest<phantom L> has store {
    user_lp_coin: UserLpCoin<L>,

    request_timestamp_ms: u64,

    min_expected_balance_out: u64
}

//****************************************** Constructors ****************************************//

fun create_withdraw_session<L, C>(
    vault: Vault<L, C>,
    account: Account<C>,
    sender: address,
    user_lp_coin: UserLpCoin<L>,
    collateral_price: u256,
    can_force_process: bool,
    min_expected_balance_out: u64
): WithdrawSession<L, C> {
    abort 404
}

#[allow(lint(self_transfer))]
public(package) fun create_withdraw_request<L, C>(
    vault: &mut Vault<L, C>,
    config: &mut Config,
    mut user_lp_coin: UserLpCoin<L>,
    lp_coin_amount: u64,
    min_expected_balance_out: u64,
    clock: &Clock,
    ctx: &mut TxContext
) {
    abort 404
}

//***************************************** Deconstructors ***************************************//

#[allow(lint(self_transfer))]
public(package) fun remove_withdraw_request<L, C>(
    vault: &mut Vault<L, C>,
    ctx: &TxContext
): UserLpCoin<L> {
    abort 404
}

//************************************************************************************************//
// WithdrawSession                                                                                //
//************************************************************************************************//

public struct WithdrawSession<phantom L, phantom C> {
    vault: Vault<L, C>,

    account: Account<C>,

    sender: address,

    collateral_price: u256,

    ch_ids: vector<ID>,

    user_lp_coin: UserLpCoin<L>,

    vault_balance_value: u256,

    accumulated_slippage: u256,

    accumulated_withdraw_dust: u256,

    can_force_process: bool,

    min_expected_balance_out: u64
}

//****************************************** Constructors ****************************************//

public(package) fun start_force_withdraw_session<L, C>(
    mut vault: Vault<L, C>,
    account: Account<C>,
    collateral_oracle: &PriceFeedStorage,
    address: address,
    clock: &Clock,
): WithdrawSession<L, C> {
    abort 404
}

public(package) fun start_owner_process_withdraw_request<L, C>(
    mut vault: Vault<L, C>,
    account: Account<C>,
    collateral_oracle: &PriceFeedStorage,
    target_request_address: address,
    clock: &Clock,
): WithdrawSession<L, C> {
    abort 404
}

#[allow(lint(self_transfer))]
public(package) fun start_owner_withdraw_session<L, C>(
    vault: Vault<L, C>,
    config: &mut Config,
    account: Account<C>,
    collateral_oracle: &PriceFeedStorage,
    mut user_lp_coin: UserLpCoin<L>,
    amount: u64,
    min_expected_balance_out: u64,
    clock: &Clock,
    ctx: &mut TxContext
): WithdrawSession<L, C> {
    abort 404
}

#[allow(lint(self_transfer))]
public(package) fun start_owner_locked_withdraw_session<L, C>(
    mut vault: Vault<L, C>,
    account: Account<C>,
    collateral_oracle: &PriceFeedStorage,
    amount: u64,
    min_expected_balance_out: u64,
    clock: &Clock,
    ctx: &mut TxContext
): WithdrawSession<L, C> {
    abort 404
}

//***************************************** Deconstructors ***************************************//

#[lint_allow(share_owned)]
public(package) fun end_withdraw_session_and_transfer_to_recipient<L, C>(
    withdraw_session: WithdrawSession<L, C>,
    config: &mut Config,
    perps_registry: &Registry,
    ctx: &mut TxContext
) {
    abort 404
}

#[lint_allow(share_owned)]
public(package) fun end_withdraw_session<L, C>(
    withdraw_session: WithdrawSession<L, C>,
    config: &mut Config,
    perps_registry: &Registry,
    ctx: &mut TxContext
): Coin<C> {
    abort 404
}

//******************************************* Mutators *******************************************//

#[allow(lint(self_transfer))]
public(package) fun set_new_withdraw_request_slippage<L, C>(
    vault: &mut Vault<L, C>,
    min_expected_balance_out: u64,
    ctx: &TxContext
) {
    abort 404
}

public(package) fun process_clearing_house_for_withdraw<L, C>(
    withdraw_session: &mut WithdrawSession<L, C>,
    mut clearing_house: ClearingHouse<C>,
    base_oracle: &PriceFeedStorage,
    clock: &Clock,
) {
    abort 404
}

public(package) fun process_clearing_house_for_force_withdraw<L, C>(
    withdraw_session: &mut WithdrawSession<L, C>,
    mut clearing_house: ClearingHouse<C>,
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

//************************************************************************************************//
// Internal Functions                                                                             //
//************************************************************************************************//

fun get_price(
    oracle: &PriceFeedStorage,
    clock: &Clock,
    source_id: u16,
    oracle_tolerance: u64,
): u256 {
    abort 404
}

fun take_owner_locked_user_lp_coin<L, C>(
    vault: &mut Vault<L, C>,
    amount: u64,
    ctx: &mut TxContext
): UserLpCoin<L> {
    abort 404
}

fun multiply_by_rational_ifixed(a: u256, b: u256, c: u256): u256 {
    abort 404
}

//************************************************************************************************//
// Validity Checks                                                                                //
//************************************************************************************************//

public(package) fun assert_account_has_vault_authority<L, C>(
    vault: &Vault<L, C>,
    account: &Account<C>,
) {
    abort 404
}

public(package) fun assert_package_version<L, C>(vault: &Vault<L, C>) {
    abort 404
}

public use fun assert_deposit_session_package_version as DepositSession.assert_package_version;
public(package) fun assert_deposit_session_package_version<L, C>(
    deposit_session: &DepositSession<L, C>,
) {
    abort 404
}

public use fun assert_withdraw_session_package_version as WithdrawSession.assert_package_version;
public(package) fun assert_withdraw_session_package_version<L, C>(
    withdraw_session: &WithdrawSession<L, C>,
) {
    abort 404
}

public(package) fun assert_vault_is_not_paused<L, C>(
    vault: &Vault<L, C>,
    clock: &Clock
) {
    abort 404
}

public(package) fun assert_vault_is_not_admin_paused<L, C>(
    vault: &Vault<L, C>,
) {
    abort 404
}

public(package) fun assert_vault_authority_cap_is_valid<L, C, Role>(
    vault: &Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, Role>,
) {
    abort 404
}

public(package) fun assert_vault_treasury_cap_is_valid<L, C>(
    vault: &Vault<L, C>,
    cap: &AuthorityCap<VAULT<L>, TREASURY>,
) {
    abort 404
}

public(package) fun assert_withdraw_session_cap_has_authority<L, C, Role>(
    withdraw_session: &WithdrawSession<L, C>,
    authority_cap: &AuthorityCap<VAULT<L>, Role>,
) {
    abort 404
}

fun assert_vault_creation_parameters_are_valid(
    config: &Config,
    lock_period: u64,
    owner_fee_rate: u256,
    force_withdraw_delay: u64,
) {
    abort 404
}

fun assert_minimum_owner_locked_liquidity_with_oracle(
    config: &Config,
    collateral_oracle: &PriceFeedStorage,
    collateral_source_id: u16,
    collateral_pfs_tolerance: u64,
    clock: &Clock,
    amount: u64,
    scaling_factor: u256,
) {
    abort 404
}

fun assert_minimum_user_deposit<L, C>(
    config: &Config,
    vault: &Vault<L, C>,
    collateral_price: u256,
    amount: u64
) {
    abort 404
}

fun assert_deposit_cap_not_exceeded<L, C>(
    vault: &Vault<L, C>,
    total_vault_balance_value: u256,
    collateral_price: u256,
) {
    abort 404
}

fun assert_collateral_price_feed_storage_is_correct(
    collateral_oracle: &PriceFeedStorage,
    collateral_storage_id: u32
) {
    abort 404
}

fun assert_base_price_feed_storage_is_correct(
    base_oracle: &PriceFeedStorage,
    base_storage_id: u32
) {
    abort 404
}

fun assert_withdraw_request_exists<L, C>(
    vault: &Vault<L, C>,
    sender: address
) {
    abort 404
}

fun assert_withdraw_request_does_not_already_exist<L, C>(
    vault: &Vault<L, C>,
    sender: address
) {
    abort 404
}
