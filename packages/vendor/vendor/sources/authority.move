// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: BUSL-1.1

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module vendor::authority;

use authority_cap::authority::{AuthorityCap, ADMIN, ASSISTANT};

use std::type_name::{Self, TypeName};

use fun std::ascii::into_bytes as std::ascii::String.to_bytes;
use fun sui::address::from_ascii_bytes as vector.to_address;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

const EAuthorityCapAlreadyCreated: u64 = 0;

//************************************************************************************************//
// AuthorityCap                                                                                   //
//************************************************************************************************//

//******************************************** Contexts ******************************************//

public struct PACKAGE() has drop;

public struct VENDOR<phantom VendorKey>() has drop;

//********************************************* Roles ********************************************//

public struct REVOKE_VENDOR_GUARDIAN() has drop;

//****************************************** Constructors ****************************************//

#[allow(lint(self_transfer))]
public(package) fun create_package_admin_cap_and_keep<T: drop>(
    witness: &T,
    config_id: &mut UID,
    ctx: &TxContext
) {
    abort 404
}

public(package) fun create_package_assistant_cap(
    config_id: &mut UID,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, ASSISTANT> {
    abort 404
}

public(package) fun create_vendor_admin_cap<VendorKey>(
    config_id: &mut UID,
    // TODO: Renable once vendor registration is permissionless.
    //
    // _: &VendorKey,
): AuthorityCap<VENDOR<VendorKey>, ADMIN> {
    abort 404
}

public(package) fun create_vendor_assistant_cap<VendorKey>(
    config_id: &mut UID,
    ctx: &mut TxContext,
): AuthorityCap<VENDOR<VendorKey>, ASSISTANT> {
    abort 404
}

public(package) fun create_package_revoke_vendor_guardian_cap(
    config_id: &mut UID,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, REVOKE_VENDOR_GUARDIAN> {
    abort 404
}
