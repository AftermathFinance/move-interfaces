// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: BUSL-1.1

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module perpetuals::authority;

use authority_cap::authority::{AuthorityCap, ADMIN, ASSISTANT};

use std::type_name::{Self, TypeName};

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//
// Error code range: 6100-6199.

macro fun invalid_authority_role(): u64 { 6100 }

//************************************************************************************************//
// AuthorityCap                                                                                   //
//************************************************************************************************//

//******************************************** Contexts ******************************************//

public struct PACKAGE() has drop;

public struct VENDOR<phantom VendorKey>() has drop;

public struct ACCOUNT() has drop;

//********************************************* Roles ********************************************//

public struct ADL() has drop;

public struct PAUSE_GUARDIAN() has drop;

public struct TREASURY() has drop;

public struct MAINTENANCE() has drop;

public struct REVOKE_VENDOR_GUARDIAN() has drop;

public struct FREEZE_GUARDIAN() has drop;

//****************************************** Constructors ****************************************//

#[allow(lint(self_transfer))]
public(package) fun create_package_admin_cap_and_keep<T: drop>(
    witness: &T,
    registry_id: &mut UID,
    ctx: &TxContext
) {
    abort 404
}

public(package) fun create_package_assistant_cap(
    registry_id: &mut UID,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, ASSISTANT> {
    abort 404
}

public(package) fun create_package_adl_cap(
    registry_id: &mut UID,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, ADL> {
    abort 404
}

public(package) fun create_package_pause_guardian_cap(
    registry_id: &mut UID,
    ctx: &mut TxContext
): AuthorityCap<PACKAGE, PAUSE_GUARDIAN> {
    abort 404
}

public(package) fun create_package_revoke_vendor_guardian_cap(
    registry_id: &mut UID,
    ctx: &mut TxContext
): AuthorityCap<PACKAGE, REVOKE_VENDOR_GUARDIAN> {
    abort 404
}

public(package) fun create_package_freeze_guardian_cap(
    registry_id: &mut UID,
    ctx: &mut TxContext
): AuthorityCap<PACKAGE, FREEZE_GUARDIAN> {
    abort 404
}

public(package) fun create_vendor_admin_cap<VendorKey>(
    registry_id: &mut UID,
): AuthorityCap<VENDOR<VendorKey>, ADMIN> {
    abort 404
}

public(package) fun create_vendor_assistant_cap<VendorKey>(
    registry_id: &mut UID,
    ctx: &mut TxContext,
): AuthorityCap<VENDOR<VendorKey>, ASSISTANT> {
    abort 404
}

public(package) fun create_vendor_pause_guardian_cap<VendorKey>(
    registry_id: &mut UID,
    ctx: &mut TxContext
): AuthorityCap<VENDOR<VendorKey>, PAUSE_GUARDIAN> {
    abort 404
}

public(package) fun create_vendor_maintenance_cap<VendorKey>(
    registry_id: &mut UID,
    ctx: &mut TxContext
): AuthorityCap<VENDOR<VendorKey>, MAINTENANCE> {
    abort 404
}

public(package) fun create_vendor_treasury_cap<VendorKey>(
    registry_id: &mut UID,
    ctx: &mut TxContext
): AuthorityCap<VENDOR<VendorKey>, TREASURY> {
    abort 404
}

public(package) fun create_account_admin_cap(
    account_uid: &mut UID,
    account_obj_id: ID,
): AuthorityCap<ACCOUNT, ADMIN> {
    abort 404
}

public(package) fun create_account_assistant_cap(
    cap: &AuthorityCap<ACCOUNT, ADMIN>,
    registry_id: &mut UID,
    ctx: &mut TxContext,
): AuthorityCap<ACCOUNT, ASSISTANT> {
    abort 404
}

//***************************************** Deconstructors ***************************************//

public(package) fun destroy_account_assistant_cap(
    cap: AuthorityCap<ACCOUNT, ASSISTANT>,
) {
    abort 404
}

public(package) fun assert_is_admin_or_assistant<Role>() {
    abort 404
}

public(package) fun assert_is_admin_or_assistant_or_maintenance<Role>() {
    abort 404
}

public(package) fun assert_is_not_admin<Role>() {
    abort 404
}

//************************************************************************************************//
// Internal Functions                                                                             //
//************************************************************************************************//

fun this_package(): ID {
    abort 404
}
