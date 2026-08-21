// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module oracle_aggregator::config;

use oracle_aggregator::authority::{FREEZE_GUARDIAN, PACKAGE, VENDOR, MAINTENANCE, REVOKE_VENDOR_GUARDIAN, SourceCap};
use oracle_aggregator::events;

use authority_cap::authority::{AuthorityCap, ADMIN, ASSISTANT};

use vendor::metadata::VendorMetadata;

use sui::dynamic_field as df;
use sui::types::is_one_time_witness;

use std::type_name::{Self, TypeName};

use fun sui::object::new as TxContext.new_uid;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error(code = 0)]
const EConfigAlreadyCreated: vector<u8> = b"The package config has already been created.";

#[error(code = 1)]
const EInvalidVersion: vector<u8> =
    b"This package version cannot be used for the requested action.";

#[error(code = 2)]
const EInactiveAuthorityCap: vector<u8> =
    b"The authority cap is inactive and cannot be used for the requested action.";

#[error(code = 3)]
const ESourceAlreadyRegistered: vector<u8> = b"The source has already been registered.";

#[error(code = 4)]
const EVendorRegistrationNotApproved: vector<u8> =
    b"Vendor registration is gated and this vendor has not been approved to register.";

#[error(code = 5)]
const EVendorAdminCapDoesNotExist: vector<u8> =
    b"The vendor admin cap has not been created for this vendor.";

#[error(code = 6)]
const EAuthorityCapAlreadyAuthorized: vector<u8> =
    b"The authority cap already holds active authority.";

#[error(code = 7)]
const ENotFrozen: vector<u8> = b"The package is not frozen.";

#[error(code = 8)]
const EInvalidResumeVersion: vector<u8> =
    b"The stored resume version does not match this package's version.";

//************************************************************************************************//
// Constants                                                                                      //
//************************************************************************************************//

macro fun current_version(): u64 { 1 }

//************************************************************************************************//
// RegisteredSource                                                                               //
//************************************************************************************************//

public struct RegisteredSource<phantom SourceKey>() has copy, drop, store;

//************************************************************************************************//
// VendorRegistrationOpen                                                                         //
//************************************************************************************************//

public struct VendorRegistrationOpen() has copy, drop, store;

//************************************************************************************************//
// FrozenVersion                                                                                  //
//************************************************************************************************//

public struct FrozenVersion() has copy, drop, store;

//************************************************************************************************//
// Config                                                                                         //
//************************************************************************************************//

public struct Config has key {
    id: UID,

    version: u64,

    next_storage_id: u32,

    next_source_id: u16,

    // REVIEW(kevin, matteo): Add registry of whitelisted sources.
    //
}

//****************************************** Constructors ****************************************//

#[allow(lint(self_transfer))]
public(package) fun create_config<T: drop>(
    witness: &T,
    ctx: &mut TxContext
): Config {
    abort 404
}

public fun share (config: Config) {
    abort 404
}

//******************************************** Getters *******************************************//

public(package) fun borrow_mut_id(config: &mut Config): &mut UID {
    abort 404
}

public(package) fun id(config: &Config): ID {
    abort 404
}

public fun is_vendor_registration_open(config: &Config): bool {
    abort 404
}

public fun is_authority_cap_active<Context, Role>(
    config: &Config,
    cap_id: ID,
): bool {
    abort 404
}

public fun is_frozen(config: &Config): bool {
    abort 404
}

//******************* Mutators [Permissioned] [AuthorityCap<PACKAGE, ADMIN>] *********************//

public fun unfreeze_package(
    config: &mut Config,
    _: &AuthorityCap<PACKAGE, ADMIN>,
) {
    abort 404
}

public fun new_package_assistant_cap(
    config: &mut Config,
    _: &AuthorityCap<PACKAGE, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, ASSISTANT> {
    abort 404
}

public fun revoke_package_assistant_cap(
    config: &mut Config,
    _: &AuthorityCap<PACKAGE, ADMIN>,
    assistant_cap: ID,
) {
    abort 404
}

public fun new_package_revoke_vendor_guardian_cap(
    config: &mut Config,
    _: &AuthorityCap<PACKAGE, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, REVOKE_VENDOR_GUARDIAN> {
    abort 404
}

public fun revoke_package_revoke_vendor_guardian_cap(
    config: &mut Config,
    _: &AuthorityCap<PACKAGE, ADMIN>,
    guardian_cap: ID,
) {
    abort 404
}

public fun reauthorize_vendor_admin_cap<VendorKey>(
    config: &mut Config,
    _: &AuthorityCap<PACKAGE, ADMIN>,
) {
    abort 404
}

public fun new_package_freeze_guardian_cap(
    config: &mut Config,
    _: &AuthorityCap<PACKAGE, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, FREEZE_GUARDIAN> {
    abort 404
}

public fun revoke_package_freeze_guardian_cap(
    config: &mut Config,
    _: &AuthorityCap<PACKAGE, ADMIN>,
    guardian_cap: ID,
) {
    abort 404
}

//**************** Mutators [Permissioned] [AuthorityCap<PACKAGE, FREEZE_GUARDIAN>] **************//

public fun freeze_package(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, FREEZE_GUARDIAN>,
) {
    abort 404
}

//*********** Mutators [Permissioned] [AuthorityCap<PACKAGE, REVOKE_VENDOR_GUARDIAN>] ************//

public fun guardian_revoke_vendor_authority_cap<VendorKey, Role>(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, REVOKE_VENDOR_GUARDIAN>,
    cap_id: ID,
) {
    abort 404
}

entry fun set_vendor_registration(
    config: &mut Config,
    _: &AuthorityCap<PACKAGE, ADMIN>,
    open: bool,
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

public(package) fun new_source_id<SourceKey, ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
): SourceCap {
    abort 404
}

public fun set_authorized<ADMIN_OR_ASSISTANT>(
    config: &Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    source_cap: &mut SourceCap,
    authorized: bool,
) {
    abort 404
}

//********* Mutators [Permissioned] [AuthorityCap<VENDOR<VendorKey>, ADMIN | ASSISTANT>] *********//

public fun register_vendor<VendorKey, ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    cap: &AuthorityCap<vendor::authority::VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    vendor_config: &vendor::config::Config,
    metadata: &VendorMetadata<VendorKey>,
): AuthorityCap<VENDOR<VendorKey>, ADMIN> {
    abort 404
}

//*************** Mutators [Permissioned] [AuthorityCap<VENDOR<VendorKey>, ADMIN>] ***************//

public fun new_vendor_assistant_cap<VendorKey>(
    config: &mut Config,
    admin_cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<VENDOR<VendorKey>, ASSISTANT> {
    abort 404
}

public fun revoke_vendor_assistant_cap<VendorKey>(
    config: &mut Config,
    admin_cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN>,
    assistant_cap: ID,
) {
    abort 404
}

public fun new_vendor_maintenance_cap<VendorKey>(
    config: &mut Config,
    admin_cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN>,
    ctx: &mut TxContext,
): AuthorityCap<VENDOR<VendorKey>, MAINTENANCE> {
    abort 404
}

public fun revoke_vendor_maintenance_cap<VendorKey>(
    config: &mut Config,
    admin_cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN>,
    maintenance_cap: ID,
) {
    abort 404
}

public(package) fun has_active_package_authority<Role>(
    config: &Config,
    authority_cap: &AuthorityCap<PACKAGE, Role>,
): bool {
    abort 404
}

public(package) fun has_vendor_authority<VendorKey, Role>(
    config: &Config,
    authority_cap: &AuthorityCap<VENDOR<VendorKey>, Role>,
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

public fun assert_vendor_authority_cap_is_valid<VendorKey, Role>(
    config: &Config,
    authority_cap: &AuthorityCap<VENDOR<VendorKey>, Role>,
) {
    abort 404
}

//************************************************************************************************//
// Internal Functions                                                                             //
//************************************************************************************************//

fun authorize_vendor_authority_cap<VendorKey, Role>(
    config: &mut Config,
    cap: &AuthorityCap<VENDOR<VendorKey>, Role>,
) {
    abort 404
}

fun revoke_vendor_authority_cap<VendorKey, Role>(
    config: &mut Config,
    admin_cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN>,
    cap: ID,
) {
    abort 404
}

fun has_active_vendor_authority_cap<VendorKey, Role>(
    config: &Config,
    cap: ID,
): bool {
    abort 404
}

public(package) fun inc_storage_id(config: &mut Config): u32 {
    abort 404
}
