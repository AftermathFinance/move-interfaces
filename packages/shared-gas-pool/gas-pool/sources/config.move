// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: BUSL-1.1

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module shared_gas_pool::config;

use shared_gas_pool::authority::{PACKAGE, MAINTENANCE};
use shared_gas_pool::events;

use authority_cap::authority::{AuthorityCap, ADMIN, ASSISTANT};

use sui::derived_object;
use sui::types;

use std::type_name::{Self, TypeName};

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error(code = 0)]
const EInvalidVersion: vector<u8> = b"This package version is outdated. Please use the newest package version.";

#[error(code = 1)]
const EConfigAlreadyCreated: vector<u8> = b"The Config singleton has already been created.";

#[error(code = 2)]
const EInactiveAuthorityCap: vector<u8> = b"The provided authority cap is inactive or invalid for this action.";

#[error(code = 3)]
const ESponsorAlreadyApproved: vector<u8> = b"The provided address is already an approved sponsor.";

#[error(code = 4)]
const ESponsorNotApproved: vector<u8> = b"The provided address is not an approved sponsor.";

//************************************************************************************************//
// Constants                                                                                      //
//************************************************************************************************//

const CURRENT_VERSION: u64 = 1;

const DEFAULT_MIN_POOL_BALANCE: u64 = 50_000_000;

//************************************************************************************************//
// Config                                                                                         //
//************************************************************************************************//

public struct Config has key {
    id: UID,

    // Package-versioning field.
    version: u64,

    min_pool_balance: u64,

    approved_sponsors: vector<address>,
}

//****************************************** Constructor *****************************************//

public(package) fun new<T: drop>(witness: &T, ctx: &mut TxContext): Config {
    abort 404
}

public(package) fun share(config: Config) {
    abort 404
}

//******************************************** Getters *******************************************//

public(package) fun borrow_mut_id(config: &mut Config): &mut UID {
    abort 404
}

public fun derive_gas_pool_address_for_owner(config: &Config, address: address): address {
    abort 404
}

public fun version(config: &Config): u64 {
    abort 404
}

public fun min_pool_balance(config: &Config): u64 {
    abort 404
}

public fun is_approved_sponsor(config: &Config, sponsor: address): bool {
    abort 404
}

public fun is_authority_cap_active<Context, Role>(config: &Config, cap_id: ID): bool {
    abort 404
}

//******************************************* Mutators *******************************************//

//******************** Mutators [Permissioned] [AuthorityCap<PACKAGE, ADMIN>] ********************//

public fun new_package_assistant_cap(
    config: &mut Config,
    _: &AuthorityCap<PACKAGE, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, ASSISTANT> {
    abort 404
}

public fun new_package_maintenance_cap(
    config: &mut Config,
    _: &AuthorityCap<PACKAGE, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, MAINTENANCE> {
    abort 404
}

public fun revoke_package_authority_cap<Role>(
    config: &mut Config,
    _: &AuthorityCap<PACKAGE, ADMIN>,
    cap_id: ID,
) {
    abort 404
}

//*************** Mutators [Permissioned] [AuthorityCap<PACKAGE, ADMIN | ASSISTANT> **************//

public fun upgrade_version<ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    authority_cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
) {
    abort 404
}

public fun set_min_pool_balance<ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    authority_cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    min_pool_balance: u64,
) {
    abort 404
}

public fun approve_sponsor<ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    authority_cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    sponsor: address,
) {
    abort 404
}

public fun unapprove_sponsor<ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    authority_cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    sponsor: address,
) {
    abort 404
}

//************************************************************************************************//
// Internal Functions                                                                             //
//************************************************************************************************//

public(package) fun has_active_package_authority<Role>(
    config: &Config,
    authority_cap: &AuthorityCap<PACKAGE, Role>,
): bool {
    abort 404
}

public(package) fun has_active_package_maintenance_authority(
    config: &Config,
    maintenance_cap: &AuthorityCap<PACKAGE, MAINTENANCE>,
): bool {
    abort 404
}

//************************************************************************************************//
// Validity Checks                                                                                //
//************************************************************************************************//

public fun assert_package_version(config: &Config) {
    abort 404
}

public fun assert_package_authority_cap_is_valid<Role>(
    config: &Config,
    authority_cap: &AuthorityCap<PACKAGE, Role>,
) {
    abort 404
}

public fun assert_package_maintenance_cap_is_valid(
    config: &Config,
    maintenance_cap: &AuthorityCap<PACKAGE, MAINTENANCE>,
) {
    abort 404
}
