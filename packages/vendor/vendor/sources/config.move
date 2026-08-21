// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: BUSL-1.1

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module vendor::config;

use vendor::authority::{PACKAGE, REVOKE_VENDOR_GUARDIAN, VENDOR};

use authority_cap::authority::{AuthorityCap, ADMIN, ASSISTANT};

use sui::dynamic_field as df;
use sui::types::is_one_time_witness;
use sui::vec_set::{Self, VecSet};
use sui::bag::Bag;

use std::ascii::String;
use std::type_name::{Self, TypeName};

use fun sui::object::new as TxContext.new_uid;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

const EInvalidVersion: u64 = 0;

const EConfigAlreadyCreated: u64 = 1;

const EInvalidAuthorityCap: u64 = 2;

const EVendorAdminCapDoesNotExist: u64 = 3;

const EAuthorityCapAlreadyAuthorized: u64 = 4;

const EKeyAlreadyRestricted: u64 = 5;

const EKeyNotRestricted: u64 = 6;

//************************************************************************************************//
// Constants                                                                                      //
//************************************************************************************************//

const CURRENT_VERSION: u64 = 1;

//************************************************************************************************//
// Config                                                                                         //
//************************************************************************************************//

public struct Config has key, store /*, singleton */ {
    id: UID,
    version: u64,
    restricted_keys: VecSet<String>,
    extra_fields: Bag,
}

//****************************************** Constructor *****************************************//

public(package) fun new<T: drop>(
    witness: &T,
    ctx: &mut TxContext
): Config {
    abort 404
}

//******************************************** Getters *******************************************//

public(package) fun borrow_mut_id(
    config: &mut Config,
): &mut UID {
    abort 404
}

public fun version(
    config: &Config,
): u64 {
    abort 404
}

public fun is_restricted_key(
    config: &Config,
    key: &String,
): bool {
    abort 404
}

public fun is_authority_cap_active<Context, Role>(
    config: &Config,
    cap_id: ID,
): bool {
    abort 404
}

//******************** Mutators [Permissioned] [AuthorityCap<PACKAGE, ADMIN>] ********************//

public fun create_package_assistant_cap(
    config: &mut Config,
    _: &AuthorityCap<PACKAGE, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, ASSISTANT> {
    abort 404
}

public fun deauthorize_package_assistant_cap(
    config: &mut Config,
    _: &AuthorityCap<PACKAGE, ADMIN>,
    cap_id: ID,
) {
    abort 404
}

//************** Mutators [Permissioned] [AuthorityCap<PACKAGE, ADMIN | ASSISTANT>] **************//

public fun upgrade_version<ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
) {
    abort 404
}

entry fun register_vendor<VendorKey, ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    recipient: address,
) {
    abort 404
}

public fun create_package_revoke_vendor_guardian_cap(
    config: &mut Config,
    _: &AuthorityCap<PACKAGE, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, REVOKE_VENDOR_GUARDIAN> {
    abort 404
}

public fun deauthorize_package_revoke_vendor_guardian_cap(
    config: &mut Config,
    _: &AuthorityCap<PACKAGE, ADMIN>,
    cap_id: ID,
) {
    abort 404
}

public fun reauthorize_vendor_admin_cap<VendorKey>(
    config: &mut Config,
    _: &AuthorityCap<PACKAGE, ADMIN>,
) {
    abort 404
}

public fun add_restricted_key<ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    key: String,
) {
    abort 404
}

public fun remove_restricted_key<ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    key: String,
) {
    abort 404
}

//*********** Mutators [Permissioned] [AuthorityCap<PACKAGE, REVOKE_VENDOR_GUARDIAN>] ************//

public fun guardian_deauthorize_vendor_authority_cap<VendorKey, Role>(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, REVOKE_VENDOR_GUARDIAN>,
    cap_id: ID,
) {
    abort 404
}

//*************** Mutators [Permissioned] [AuthorityCap<VENDOR<VendorKey>, ADMIN>] ***************//

public fun create_vendor_assistant_cap<VendorKey>(
    config: &mut Config,
    admin_cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<VENDOR<VendorKey>, ASSISTANT> {
    abort 404
}

public fun deauthorize_vendor_assistant_cap<VendorKey>(
    config: &mut Config,
    admin_cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN>,
    cap_id: ID,
) {
    abort 404
}

//************************************************************************************************//
// Validity Checks                                                                                //
//************************************************************************************************//

public fun assert_package_version(config: &Config) {
    abort 404
}

public fun assert_has_active_package_authority<Role>(
    config: &Config,
    cap: &AuthorityCap<PACKAGE, Role>,
) {
    abort 404
}

public fun assert_has_active_vendor_authority<VendorKey, Role>(
    config: &Config,
    cap: &AuthorityCap<VENDOR<VendorKey>, Role>,
) {
    abort 404
}

//************************************************************************************************//
// Internal Functions                                                                              //
//************************************************************************************************//

public(package) fun has_package_authority<Role>(
    config: &Config,
    cap: &AuthorityCap<PACKAGE, Role>,
): bool {
    abort 404
}

public(package) fun has_vendor_authority<VendorKey, Role>(
    config: &Config,
    cap: &AuthorityCap<VENDOR<VendorKey>, Role>,
): bool {
    abort 404
}

public(package) fun is_vendor_authority_cap_authorized<VendorKey, Role>(
    config: &Config,
    cap_id: ID,
): bool {
    abort 404
}

fun is_authority_cap_authorized<Role>(
    config: &Config,
    cap_id: ID,
): bool {
    abort 404
}

fun authorize_authority_cap<Context, Role>(
    config: &mut Config,
    cap: &AuthorityCap<Context, Role>,
) {
    abort 404
}

fun deauthorize_authority_cap<Role>(
    config: &mut Config,
    cap_id: ID,
) {
    abort 404
}

fun deauthorize_vendor_authority_cap<VendorKey, Role>(
    config: &mut Config,
    cap_id: ID,
) {
    abort 404
}
