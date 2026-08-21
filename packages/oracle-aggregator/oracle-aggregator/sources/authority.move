// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module oracle_aggregator::authority;

use authority_cap::authority::{AuthorityCap, ADMIN, ASSISTANT};

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error(code = 0)]
const EInvalidAuthorityRole: vector<u8> = b"This function does not accept the provided authority role.";

#[error(code = 1)]
const EPackageAuthorityCapAlreadyCreated: vector<u8> =
    b"The package authority cap has already been created.";

#[error(code = 2)]
const EVendorAuthorityCapAlreadyCreated: vector<u8> =
    b"The vendor authority cap has already been created.";

#[error(code = 3)]
const EInvalidVendorAuthorization: vector<u8> =
    b"The price feed storage is not authorized for the provided vendor.";

//************************************************************************************************//
// AuthorityCap                                                                                   //
//************************************************************************************************//

//******************************************** Contexts ******************************************//

public struct PACKAGE() has drop;

public struct VENDOR<phantom VendorKey>() has drop;

//********************************************* Roles ********************************************//
// The `VENDOR<VendorKey>` roles are intentionally split between provisioning and operations,     //
// with `ADMIN` spanning both:                                                                    //
//  - `ADMIN` (singleton): can do everything below, and is the only vendor role that can mint or  //
//    revoke the other vendor roles' caps and remove `PriceFeed`s via `remove_price_feed`.        //
//  - `ASSISTANT` (provisioning): can create `PriceFeedStorage`s and `PriceFeed`s but cannot      //
//    mutate them afterwards.                                                                     //
//  - `MAINTENANCE` (operations): can tune existing `PriceFeed`s (e.g., `set_twap_period_ms`,     //
//    `set_symbol`) but cannot create or remove them.                                             //
//                                                                                                //
// `ASSISTANT` and `MAINTENANCE` are disjoint so that long-lived operational keys carry the       //
// smallest possible blast radius.                                                                //
//                                                                                                //
// NOTE: the `PACKAGE` context can also destroy `PriceFeed`s: once a source has been              //
// deauthorized, the package admin or any active package assistant can remove its `PriceFeed`s    //
// via `remove_deauthorized_price_feed`.                                                          //
//************************************************************************************************//

public struct MAINTENANCE() has drop;

public struct REVOKE_VENDOR_GUARDIAN() has drop;

public struct FREEZE_GUARDIAN() has drop;

//****************************************** Constructors ****************************************//

#[allow(lint(self_transfer))]
public(package) fun create_package_admin_cap_and_keep<T: drop>(
    witness: &T,
    config_id: &mut UID,
    ctx: &TxContext
) {
    abort 404
}

public(package) fun create_multiton_package_assistant_cap(
    config_id: &mut UID,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, ASSISTANT> {
    abort 404
}

public(package) fun create_vendor_admin_cap<VendorKey>(
    config_id: &mut UID,
): AuthorityCap<VENDOR<VendorKey>, ADMIN> {
    abort 404
}

public(package) fun create_vendor_assistant_cap<VendorKey>(
    config_id: &mut UID,
    ctx: &mut TxContext,
): AuthorityCap<VENDOR<VendorKey>, ASSISTANT> {
    abort 404
}

public(package) fun create_vendor_maintenance_cap<VendorKey>(
    config_id: &mut UID,
    ctx: &mut TxContext,
): AuthorityCap<VENDOR<VendorKey>, MAINTENANCE> {
    abort 404
}

public(package) fun create_package_revoke_vendor_guardian_cap(
    config_id: &mut UID,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, REVOKE_VENDOR_GUARDIAN> {
    abort 404
}

public(package) fun create_package_freeze_guardian_cap(
    config_id: &mut UID,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, FREEZE_GUARDIAN> {
    abort 404
}

//************************************************************************************************//
// VendorAuthKey                                                                                  //
//************************************************************************************************//

public struct VendorAuthKey() has copy, drop, store;

//************************************************************************************************//
// VendorSourceCap                                                                                  //
//************************************************************************************************//

public struct VendorSourceCap<phantom VendorKey>() has store;

//************************************************************************************************//
// SourceCap                                                                                        //
//************************************************************************************************//

public struct SourceCap has store {
    source_id: u16,
    authorized: bool,
}

public fun source_id(cap: &SourceCap): u16 { abort 404 }

public fun is_authorized(cap: &SourceCap): bool { abort 404 }

public(package) fun new_source_cap(source_id: u16): SourceCap {
    abort 404
}

public(package) fun set_source_cap_authorized(cap: &mut SourceCap, authorized: bool) {
    abort 404
}

//************************************************************************************************//
// Public Functions                                                                               //
//************************************************************************************************//

//******************************************** Getters *******************************************//

use fun has_vendor_authorization as UID.has_vendor_authorization;
public fun has_vendor_authorization<VendorKey>(id: &UID): bool {
    abort 404
}

//******************************************* Mutators *******************************************//

public(package) fun add_vendor_authorization<VendorKey>(id: &mut UID) {
    abort 404
}

public fun assert_is_admin_or_assistant<Role>() {
    abort 404
}

public fun assert_is_admin_or_maintenance<Role>() {
    abort 404
}

public(package) fun assert_is_not_admin<Role>() {
    abort 404
}

public(package) fun assert_has_active_vendor_authority<VendorKey>(id: &UID) {
    abort 404
}
