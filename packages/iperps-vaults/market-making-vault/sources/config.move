// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module market_making_vault::config;

use market_making_vault::authority::{Self, PACKAGE, PAUSE_GUARDIAN, MAINTENANCE, FREEZE_GUARDIAN};
use market_making_vault::events;
use market_making_vault::keys;

use authority_cap::authority::{AuthorityCap, ADMIN, ASSISTANT};

use sui::types::is_one_time_witness;
use sui::dynamic_field as df;
use sui::bag::Bag;

public use fun market_making_vault::interface::create_package_pause_guardian_cap
    as Config.create_package_pause_guardian_cap;
public use fun market_making_vault::interface::create_package_maintenance_cap
    as Config.create_package_maintenance_cap;
public use fun market_making_vault::interface::create_package_assistant_cap
    as Config.create_package_assistant_cap;
public use fun market_making_vault::interface::deauthorize_package_authority_cap
    as Config.deauthorize_package_authority_cap;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error(code = 0)]
const EConfigAlreadyCreated: vector<u8> = b"The package config has already been created.";

#[error(code = 1)]
const EInvalidVersion: vector<u8> =
    b"This package version cannot be used for the requested action.";

#[error(code = 2)]
const EInvalidAuthorityCap: vector<u8> =
    b"The provided AuthorityCap does not have permission to manage this package.";

#[error(code = 3)]
const EInvalidConfigValue: vector<u8> =
    b"The provided config value would violate package configuration invariants.";

#[error(code = 4)]
const EVaultRecordAlreadyRegistered: vector<u8> =
    b"A VaultRecord is already registered under Config for the provided vault ID.";

#[error(code = 5)]
const EUserLpCoinRecordAlreadyRegistered: vector<u8> =
    b"A UserLpCoinRecord is already registered under Config for the provided user LP coin ID.";

#[error(code = 6)]
const EUserLpCoinRecordDoesNotExist: vector<u8> =
    b"No UserLpCoinRecord is registered under Config for the provided user LP coin ID.";

#[error(code = 7)]
const ENotFrozen: vector<u8> = b"The Config is not frozen.";

#[error(code = 8)]
const EInvalidResumeVersion: vector<u8> =
    b"This package version cannot restore the frozen Config's resume version.";

#[error(code = 9)]
const EBadNewConfigVersion: vector<u8> =
    b"The new Config version must be greater than the current one.";

//************************************************************************************************//
// VaultRecord                                                                                    //
//************************************************************************************************//

public struct VaultRecord has copy, drop, store {
    vault_id: ID,
    owner_cap_id: ID,
    vault_metadata_id: ID,
    created_at_ms: u64,
}

//************************************************************************************************//
// UserLpCoinRecord                                                                               //
//************************************************************************************************//

public struct UserLpCoinRecord has copy, drop, store {
    user_lp_coin_id: ID,
    vault_id: ID,
}

//************************************************************************************************//
// Config                                                                                         //
//************************************************************************************************//

public struct Config has key {
    id: UID,

    version: u64,

    collateral_pfs_tolerance: u64,

    max_lock_period: u64,

    max_force_withdraw_delay: u64,

    max_owner_fee_rate: u256,

    min_owner_lock_usd: u256,

    max_owner_lock_usd: u256,

    min_deposit_usd: u256,

    max_markets_in_vault: u64,

    max_pending_orders_per_position: u64,

    force_withdraw_pause_ms: u64,

    max_assistants_per_vault: u64,

    extra_fields: Bag,
}

//****************************************** Constructors ****************************************//

#[allow(lint(self_transfer))]
public(package) fun create_config_and_share<T: drop>(
    witness: &T,
    ctx: &mut TxContext
) {
    abort 404
}

public fun share(config: Config) {
    abort 404
}

//******************************************** Getters *******************************************//

public fun is_authority_cap_authorized<Role>(
    config: &Config,
    cap_id: ID,
): bool {
    abort 404
}

public fun is_frozen(config: &Config): bool {
    abort 404
}

public(package) fun collateral_pfs_tolerance(config: &Config): u64 { abort 404 }

public(package) fun max_lock_period(config: &Config): u64 { abort 404 }

public(package) fun max_force_withdraw_delay(config: &Config): u64 { abort 404 }

public(package) fun max_owner_fee_rate(config: &Config): u256 { abort 404 }

public(package) fun min_owner_lock_usd(config: &Config): u256 { abort 404 }

public(package) fun max_owner_lock_usd(config: &Config): u256 { abort 404 }

public(package) fun min_deposit_usd(config: &Config): u256 { abort 404 }

public(package) fun max_markets_in_vault(config: &Config): u64 { abort 404 }

public(package) fun max_pending_orders_per_position(config: &Config): u64 {
    abort 404
}

public(package) fun force_withdraw_pause_ms(config: &Config): u64 { abort 404 }

public(package) fun max_assistants_per_vault(config: &Config): u64 { abort 404 }

public use fun user_lp_coin_record_vault_id as UserLpCoinRecord.vault_id;
public(package) fun user_lp_coin_record_vault_id(record: &UserLpCoinRecord): ID {
    abort 404
}

public(package) fun has_vault_record(config: &Config, vault_id: ID): bool {
    abort 404
}

public(package) fun user_lp_coin_record(
    config: &Config,
    user_lp_coin_id: ID,
): &UserLpCoinRecord {
    abort 404
}

public(package) fun has_user_lp_coin_record(
    config: &Config,
    user_lp_coin_id: ID,
): bool {
    abort 404
}

public(package) fun assert_user_lp_coin_record_exists(
    config: &Config,
    user_lp_coin_id: ID,
) {
    abort 404
}

//******************************************* Mutators *******************************************//

public(package) fun register_vault(
    config: &mut Config,
    vault_id: ID,
    owner_cap_id: ID,
    vault_metadata_id: ID,
    created_at_ms: u64,
) {
    abort 404
}

public(package) fun register_user_lp_coin(
    config: &mut Config,
    user_lp_coin_id: ID,
    vault_id: ID,
) {
    abort 404
}

public(package) fun unregister_user_lp_coin(
    config: &mut Config,
    user_lp_coin_id: ID,
) {
    abort 404
}

//******************** Mutators [Permissioned] [AuthorityCap<PACKAGE, ADMIN>] ********************//

public(package) fun create_package_assistant_cap_(
    config: &mut Config,
    _: &AuthorityCap<PACKAGE, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, ASSISTANT> {
    abort 404
}

public(package) fun create_package_pause_guardian_cap_(
    config: &mut Config,
    _: &AuthorityCap<PACKAGE, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, PAUSE_GUARDIAN> {
    abort 404
}

public(package) fun create_package_maintenance_cap_(
    config: &mut Config,
    _: &AuthorityCap<PACKAGE, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, MAINTENANCE> {
    abort 404
}

public(package) fun create_package_freeze_guardian_cap_(
    config: &mut Config,
    _: &AuthorityCap<PACKAGE, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, FREEZE_GUARDIAN> {
    abort 404
}

public fun unfreeze_package(
    config: &mut Config,
    _: &AuthorityCap<PACKAGE, ADMIN>,
) {
    abort 404
}

//************* Mutators [Permissioned] [AuthorityCap<PACKAGE, FREEZE_GUARDIAN>] *****************//

public fun freeze_package(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, FREEZE_GUARDIAN>,
) {
    abort 404
}

public(package) fun deauthorize_package_authority_cap_<Role>(
    config: &mut Config,
    _: &AuthorityCap<PACKAGE, ADMIN>,
    cap_id: ID,
) {
    abort 404
}

//************** Mutators [Permissioned] [AuthorityCap<PACKAGE, ADMIN | ASSISTANT>] **************//

public fun set_max_lock_period<ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    max_lock_period: u64,
) {
    abort 404
}

public fun set_max_force_withdraw_delay<ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    max_force_withdraw_delay: u64,
) {
    abort 404
}

public fun set_max_owner_fee_rate<ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    max_owner_fee_rate: u256,
) {
    abort 404
}

public fun set_min_owner_lock_usd<ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    min_owner_lock_usd: u256,
) {
    abort 404
}

public fun set_max_owner_lock_usd<ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    max_owner_lock_usd: u256,
) {
    abort 404
}

public fun set_min_deposit_usd<ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    min_deposit_usd: u256,
) {
    abort 404
}

public fun set_max_markets_in_vault<ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    max_markets_in_vault: u64,
) {
    abort 404
}

public fun set_max_pending_orders_per_position<ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    max_pending_orders_per_position: u64,
) {
    abort 404
}

public fun set_force_withdraw_pause_ms<ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    force_withdraw_pause_ms: u64,
) {
    abort 404
}

public fun set_max_assistants_per_vault<ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    max_assistants_per_vault: u64,
) {
    abort 404
}

//************************************************************************************************//
// Internal Functions                                                                             //
//************************************************************************************************//

public(package) fun authorize_authority_cap<Role>(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, Role>,
) {
    abort 404
}

public(package) fun deauthorize_authority_cap_<Role>(
    config: &mut Config,
    cap_id: ID,
) {
    abort 404
}

fun has_authority<Role>(
    config: &Config,
    cap: &AuthorityCap<PACKAGE, Role>,
): bool {
    abort 404
}

fun has_maintenance_authority(
    config: &Config,
    cap: &AuthorityCap<PACKAGE, MAINTENANCE>,
): bool {
    abort 404
}

fun has_pause_guardian_authority(
    config: &Config,
    cap: &AuthorityCap<PACKAGE, PAUSE_GUARDIAN>,
): bool {
    abort 404
}

fun has_freeze_guardian_authority(
    config: &Config,
    cap: &AuthorityCap<PACKAGE, FREEZE_GUARDIAN>,
): bool {
    abort 404
}

public(package) fun upgrade_version(config: &mut Config) {
    abort 404
}

//************************************************************************************************//
// Validity Checks                                                                                //
//************************************************************************************************//

public fun assert_package_version(config: &Config) {
    abort 404
}

public(package) fun assert_authority_cap_is_valid<ADMIN_OR_ASSISTANT>(
    config: &Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
) {
    abort 404
}

public(package) fun assert_is_active_package_pause_guardian_cap(
    config: &Config,
    cap: &AuthorityCap<PACKAGE, PAUSE_GUARDIAN>,
) {
    abort 404
}

public(package) fun assert_is_active_package_maintenance_cap(
    config: &Config,
    cap: &AuthorityCap<PACKAGE, MAINTENANCE>,
) {
    abort 404
}

public(package) fun assert_is_active_package_freeze_guardian_cap(
    config: &Config,
    cap: &AuthorityCap<PACKAGE, FREEZE_GUARDIAN>,
) {
    abort 404
}

public(package) fun assert_authority_cap_id_is_authorized<Role>(
    config: &Config,
    cap_id: ID,
) {
    abort 404
}
