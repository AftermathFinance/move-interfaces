// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: BUSL-1.1

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module perpetuals::registry;

use perpetuals::authority::{ACCOUNT, ADL, FREEZE_GUARDIAN, MAINTENANCE, PACKAGE, PAUSE_GUARDIAN, REVOKE_VENDOR_GUARDIAN, TREASURY, VENDOR};
use perpetuals::constants;
use perpetuals::events;
use perpetuals::keys;

use oracle_aggregator::price_feed_storage::PriceFeedStorage;

use authority_cap::authority::{AuthorityCap, ADMIN, ASSISTANT};

use vendor::metadata::VendorMetadata;

use ifixed::ifixed;

use sui::dynamic_field as df;
use sui::bag::{Self, Bag};

use std::type_name::{Self, TypeName};
use std::option::{Self, Option};

public use fun perpetuals::account::create_account as Registry.create_account;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//
// Error code range: 5000-5999.

macro fun invalid_version(): u64 { 5000 }

macro fun market_already_registered(): u64 { 5001 }

macro fun market_is_not_registered(): u64 { 5002 }

macro fun invalid_integrator_id(): u64 { 5003 }

macro fun integrator_registration_does_not_exist(): u64 { 5004 }

macro fun invalid_version_upgrade_value(): u64 { 5005 }

macro fun invalid_vendor(): u64 { 5006 }

macro fun authority_cap_not_authorized(): u64 { 5007 }

macro fun invalid_funding_parameter_bounds(): u64 { 5008 }

macro fun invalid_premium_twap_bounds(): u64 { 5009 }

macro fun invalid_spread_twap_bounds(): u64 { 5010 }

macro fun invalid_proposal_delay_bounds(): u64 { 5011 }

macro fun invalid_min_order_usd_value_bounds(): u64 { 5012 }

macro fun invalid_insurance_open_interest_fraction(): u64 { 5013 }

macro fun invalid_min_oracle_tolerance(): u64 { 5014 }

macro fun invalid_max_book_index_spread(): u64 { 5015 }

macro fun invalid_max_index_twap_divergence(): u64 { 5016 }

macro fun invalid_up_max_pending_orders(): u64 { 5017 }

macro fun invalid_max_assistants_per_account(): u64 { 5018 }

macro fun invalid_max_abs_maker_fee(): u64 { 5019 }

macro fun invalid_max_abs_taker_fee(): u64 { 5020 }

macro fun invalid_max_liquidation_fee(): u64 { 5021 }

macro fun invalid_max_insurance_fund_fee(): u64 { 5022 }

macro fun vendor_registration_not_approved(): u64 { 5023 }

macro fun authority_cap_already_authorized(): u64 { 5024 }

macro fun vendor_admin_cap_does_not_exist(): u64 { 5025 }

macro fun not_frozen(): u64 { 5026 }

macro fun invalid_resume_version(): u64 { 5027 }

//************************************************************************************************//
// MarketInfo                                                                                     //
//************************************************************************************************//

public struct MarketInfo<phantom T> has store {
    base_storage_id: u32,
    base_source_id: u16,
    collateral_storage_id: u32,
    collateral_source_id: u16,
    scaling_factor: u256
}

//************************************************************************************************//
// CollateralInfo                                                                                 //
//************************************************************************************************//

public struct CollateralInfo<phantom T> has store {
    collateral_storage_id: u32,
    collateral_source_id: u16,
    scaling_factor: u256
}

//************************************************************************************************//
// IntegratorRegistration                                                                         //
//************************************************************************************************//

public struct IntegratorRegistration has store {
    integrator_address: address,
}

//************************************************************************************************//
// Config                                                                                         //
//************************************************************************************************//

public struct Config has store {
    stop_order_mist_cost: u64,
    max_abs_maker_fee: u256,
    max_abs_taker_fee: u256,
    max_liquidation_fee: u256,
    max_insurance_fund_fee: u256,
    min_funding_frequency_ms: u64,
    min_funding_period_ms: u64,
    max_funding_period_ms: u64,
    min_premium_twap_frequency_ms: u64,
    min_premium_twap_period_ms: u64,
    min_spread_twap_frequency_ms: u64,
    min_spread_twap_period_ms: u64,
    min_proposal_delay_ms: u64,
    max_proposal_delay_ms: u64,
    low_min_order_usd_value: u256,
    up_min_order_usd_value: u256,
    insurance_open_interest_fraction: u256,
    min_oracle_tolerance: u64,
    max_book_index_spread: u256,
    max_index_twap_divergence: u256,
    up_max_pending_orders: u64,
    max_assistants_per_account: u64,

    extra_fields: Bag,
}

//******************************************** Getters *******************************************//

public fun max_abs_maker_fee(config: &Config): u256 {
    abort 404
}

public fun max_abs_taker_fee(config: &Config): u256 {
    abort 404
}

public fun max_liquidation_fee(config: &Config): u256 {
    abort 404
}

public fun max_insurance_fund_fee(config: &Config): u256 {
    abort 404
}

public fun min_funding_frequency_ms(config: &Config): u64 {
    abort 404
}

public fun min_funding_period_ms(config: &Config): u64 {
    abort 404
}

public fun max_funding_period_ms(config: &Config): u64 {
    abort 404
}

public fun min_premium_twap_frequency_ms(config: &Config): u64 {
    abort 404
}

public fun min_premium_twap_period_ms(config: &Config): u64 {
    abort 404
}

public fun min_spread_twap_frequency_ms(config: &Config): u64 {
    abort 404
}

public fun min_spread_twap_period_ms(config: &Config): u64 {
    abort 404
}

public fun min_proposal_delay_ms(config: &Config): u64 {
    abort 404
}

public fun max_proposal_delay_ms(config: &Config): u64 {
    abort 404
}

public fun low_min_order_usd_value(config: &Config): u256 {
    abort 404
}

public fun up_min_order_usd_value(config: &Config): u256 {
    abort 404
}

public fun insurance_open_interest_fraction(config: &Config): u256 {
    abort 404
}

public fun min_oracle_tolerance(config: &Config): u64 {
    abort 404
}

public fun max_book_index_spread(config: &Config): u256 {
    abort 404
}

public fun max_index_twap_divergence(config: &Config): u256 {
    abort 404
}

public fun up_max_pending_orders(config: &Config): u64 {
    abort 404
}

public fun max_assistants_per_account(config: &Config): u64 {
    abort 404
}

//************************************************************************************************//
// Registry                                                                                       //
//************************************************************************************************//

public struct Registry has key {
    id: UID,
    version: u64,
    next_account_id: u64,
    next_integrator_id: u32
}

//****************************************** Constructors ****************************************//

public(package) fun create_registry<T: drop>(
    witness: &T,
    ctx: &mut TxContext
): Registry {
    abort 404
}

public fun share(registry: Registry) {
    abort 404
}

//******************************************** Getters *******************************************//

public(package) fun borrow_mut_id(
    registry: &mut Registry,
): &mut UID {
    abort 404
}

public fun version(registry: &Registry): u64 {
    abort 404
}

public(package) fun config(registry: &Registry): &Config {
    abort 404
}

fun config_mut(registry: &mut Registry): &mut Config {
    abort 404
}

public fun is_market_registered(
    registry: &Registry,
    ch_id: ID
): bool {
    abort 404
}

public fun is_collateral_registered<T>(
    registry: &Registry,
): bool {
    abort 404
}

public fun is_integrator_id_registered(
    registry: &Registry,
    integrator_id: u32
): bool {
    abort 404
}

public fun is_frozen(registry: &Registry): bool {
    abort 404
}

public fun is_vendor_registration_open(registry: &Registry): bool {
    abort 404
}

public fun is_authority_cap_authorized<Context, Role>(
    registry: &Registry,
    cap_id: ID,
): bool {
    abort 404
}

public fun is_account_assistant_cap_registered(
    registry: &Registry,
    account_cap_id: ID,
): bool {
    abort 404
}

public fun market_info<T>(registry: &Registry, ch_id: ID): (u32, u16, u32, u16, u256) {
    abort 404
}

public fun collateral_info<T>(registry: &Registry): (u32, u16, u256) {
    abort 404
}

public fun stop_order_mist_cost(registry: &Registry): u64 {
    abort 404
}

fun option_u64_or(value: &Option<u64>, fallback: u64): u64 {
    abort 404
}

fun option_u256_or(value: &Option<u256>, fallback: u256): u256 {
    abort 404
}

public fun integrator_address(registry: &Registry, integrator_id: u32): address {
    abort 404
}

//******************************************* Mutators *******************************************//

public fun register_integrator(
    registry: &mut Registry,
    ctx: &mut TxContext,
): u32 {
    abort 404
}

public(package) fun register_market<T>(
    registry: &mut Registry,
    base_storage_id: u32,
    base_source_id: u16,
    collateral_storage_id: u32,
    collateral_source_id: u16,
    scaling_factor: u256,
    ch_id: ID
) {
    abort 404
}

public(package) fun remove_registered_market<T>(
    registry: &mut Registry,
    ch_id: ID,
) {
    abort 404
}

public(package) fun set_base_oracle_params_<T>(
    registry: &mut Registry,
    ch_id: ID,
    storage_id: u32,
    source_id: u16,
) {
    abort 404
}

public(package) fun set_collateral_oracle_params_<T>(
    registry: &mut Registry,
    ch_id: ID,
    storage_id: u32,
    source_id: u16,
) {
    abort 404
}

//******************************* Mutators [Permissioned] [sender] *******************************//

public fun set_integrator_address(
    registry: &mut Registry,
    integrator_id: u32,
    new_integrator_address: address,
    ctx: &TxContext,
) {
    abort 404
}

//********************* Mutators [Permissioned] [AuthorityCap<Context, Role>] ********************//

public fun deauthorize_authority_cap<Context, Role>(
    registry: &mut Registry,
    cap: &AuthorityCap<Context, ADMIN>,
    cap_id: ID,
) {
    abort 404
}

//******************** Mutators [Permissioned] [AuthorityCap<PACKAGE, ADMIN>] ********************//

public fun create_package_assistant_cap(
    registry: &mut Registry,
    _cap: &AuthorityCap<PACKAGE, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, ASSISTANT> {
    abort 404
}

public fun create_package_adl_cap(
    registry: &mut Registry,
    _: &AuthorityCap<PACKAGE, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, ADL> {
    abort 404
}

public fun create_package_pause_guardian_cap(
    registry: &mut Registry,
    _cap: &AuthorityCap<PACKAGE, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, PAUSE_GUARDIAN> {
    abort 404
}

entry fun set_vendor_registration(
    registry: &mut Registry,
    _: &AuthorityCap<PACKAGE, ADMIN>,
    open: bool,
) {
    abort 404
}

public fun create_package_revoke_vendor_guardian_cap(
    registry: &mut Registry,
    _cap: &AuthorityCap<PACKAGE, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, REVOKE_VENDOR_GUARDIAN> {
    abort 404
}

public fun reauthorize_vendor_admin_cap<VendorKey>(
    registry: &mut Registry,
    _cap: &AuthorityCap<PACKAGE, ADMIN>,
) {
    abort 404
}

public fun create_package_freeze_guardian_cap(
    registry: &mut Registry,
    _cap: &AuthorityCap<PACKAGE, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, FREEZE_GUARDIAN> {
    abort 404
}

public fun unfreeze_package(
    registry: &mut Registry,
    _cap: &AuthorityCap<PACKAGE, ADMIN>,
) {
    abort 404
}

//**************** Mutators [Permissioned] [AuthorityCap<PACKAGE, FREEZE_GUARDIAN>] **************//

public fun freeze_package(
    registry: &mut Registry,
    cap: &AuthorityCap<PACKAGE, FREEZE_GUARDIAN>,
) {
    abort 404
}

//*********** Mutators [Permissioned] [AuthorityCap<PACKAGE, REVOKE_VENDOR_GUARDIAN>] ************//

public fun guardian_deauthorize_authority_cap<VendorKey, Role>(
    registry: &mut Registry,
    cap: &AuthorityCap<PACKAGE, REVOKE_VENDOR_GUARDIAN>,
    cap_id: ID,
) {
    abort 404
}

//************** Mutators [Permissioned] [AuthorityCap<PACKAGE, ADMIN | ASSISTANT>] **************//

entry fun upgrade_version<ADMIN_OR_ASSISTANT>(
    registry: &mut Registry,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
) {
    abort 404
}

public fun set_integrator_address_with_cap<ADMIN_OR_ASSISTANT>(
    registry: &mut Registry,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    integrator_id: u32,
    new_integrator_address: address,
) {
    abort 404
}

public fun set_collateral_info<T, ADMIN_OR_ASSISTANT>(
    registry: &mut Registry,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    pfs: &PriceFeedStorage,
    source_id: u16,
) {
    abort 404
}

public fun set_config<ADMIN_OR_ASSISTANT>(
    registry: &mut Registry,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    stop_order_mist_cost: Option<u64>,
    max_abs_maker_fee: Option<u256>,
    max_abs_taker_fee: Option<u256>,
    max_liquidation_fee: Option<u256>,
    max_insurance_fund_fee: Option<u256>,
    min_funding_frequency_ms: Option<u64>,
    min_funding_period_ms: Option<u64>,
    max_funding_period_ms: Option<u64>,
    min_premium_twap_frequency_ms: Option<u64>,
    min_premium_twap_period_ms: Option<u64>,
    min_spread_twap_frequency_ms: Option<u64>,
    min_spread_twap_period_ms: Option<u64>,
    min_proposal_delay_ms: Option<u64>,
    max_proposal_delay_ms: Option<u64>,
    low_min_order_usd_value: Option<u256>,
    up_min_order_usd_value: Option<u256>,
    insurance_open_interest_fraction: Option<u256>,
    min_oracle_tolerance: Option<u64>,
    max_book_index_spread: Option<u256>,
    max_index_twap_divergence: Option<u256>,
    up_max_pending_orders: Option<u64>,
    max_assistants_per_account: Option<u64>,
) {
    abort 404
}

//********* Mutators [Permissioned] [AuthorityCap<VENDOR<VendorKey>, ADMIN | ASSISTANT>] *********//

public fun register_vendor<VendorKey, ADMIN_OR_ASSISTANT>(
    registry: &mut Registry,
    cap: &AuthorityCap<vendor::authority::VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    vendor_config: &vendor::config::Config,
    metadata: &mut VendorMetadata<VendorKey>,
): AuthorityCap<VENDOR<VendorKey>, ADMIN> {
    abort 404
}

//*************** Mutators [Permissioned] [AuthorityCap<VENDOR<VendorKey>, ADMIN>] ***************//

public fun create_vendor_assistant_cap<VendorKey>(
    registry: &mut Registry,
    admin_cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<VENDOR<VendorKey>, ASSISTANT> {
    abort 404
}

public fun create_vendor_pause_guardian_cap<VendorKey>(
    registry: &mut Registry,
    admin_cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<VENDOR<VendorKey>, PAUSE_GUARDIAN> {
    abort 404
}

public fun create_vendor_maintenance_cap<VendorKey>(
    registry: &mut Registry,
    admin_cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<VENDOR<VendorKey>, MAINTENANCE> {
    abort 404
}

public fun create_vendor_treasury_cap<VendorKey>(
    registry: &mut Registry,
    admin_cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN>,
    ctx: &mut TxContext
): AuthorityCap<VENDOR<VendorKey>, TREASURY> {
    abort 404
}

//************************************************************************************************//
// Internal Functions                                                                             //
//************************************************************************************************//

public(package) fun authorize_authority_cap<Context, Role>(
    registry: &mut Registry,
    cap: &AuthorityCap<Context, Role>,
) {
    abort 404
}

public(package) fun register_account_assistant_cap(
    registry: &mut Registry,
    cap: &AuthorityCap<ACCOUNT, ASSISTANT>,
) {
    abort 404
}

public(package) fun unregister_account_assistant_cap_if_registered(
    registry: &mut Registry,
    account_cap_id: ID,
) {
    abort 404
}

public(package) fun deauthorize_authority_cap_<Context, Role>(
    registry: &mut Registry,
    cap_id: ID,
) {
    abort 404
}

public(package) fun inc_account_id(registry: &mut Registry): u64 {
    abort 404
}

fun inc_integrator_id(registry: &mut Registry): u32 {
    abort 404
}

fun set_integrator_address_(
    registry: &mut Registry,
    integrator_id: u32,
    new_integrator_address: address,
) {
    abort 404
}

//************************************************************************************************//
// Validity Checks                                                                                //
//************************************************************************************************//

public(package) fun assert_package_version(registry: &Registry) {
    abort 404
}

public(package) fun assert_authority_cap_is_authorized<Context, Role>(
    registry: &Registry,
    cap: &AuthorityCap<Context, Role>,
) {
    abort 404
}

public(package) fun assert_admin_authority_cap_is_active<Context, Role>(
    registry: &Registry,
    cap: &AuthorityCap<Context, Role>,
) {
    abort 404
}

public(package) fun assert_admin_or_authorized_assistant_authority_cap<Context, Role>(
    registry: &Registry,
    cap: &AuthorityCap<Context, Role>,
) {
    abort 404
}

public(package) fun assert_admin_or_authorized_assistant_or_maintenance_authority_cap<Context, Role>(
    registry: &Registry,
    cap: &AuthorityCap<Context, Role>,
) {
    abort 404
}

fun assert_authority_cap_id_is_authorized<Context, Role>(
    registry: &Registry,
    cap_id: ID,
) {
    abort 404
}

public(package) fun assert_vendor_has_ownership_over_clearing_house<VendorKey, Role>(
    registry: &Registry,
    _: &AuthorityCap<VENDOR<VendorKey>, Role>,
    clearing_house_id: &ID,
) {
    abort 404
}

public(package) fun assert_integrator_id_is_valid(
    registry: &Registry,
    integrator_id: u32,
) {
    abort 404
}
