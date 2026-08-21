// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module oracle_aggregator::events;

use sui::event::emit;

use std::string::String;
use std::type_name::TypeName;

//************************************************************************************************//
// CreatedPriceFeedStorage                                                                        //
//************************************************************************************************//

public struct CreatedPriceFeedStorage has copy, drop {
    price_feed_storage_obj_id: ID,
    storage_id: u32,
    symbol: String,
}

public(package) fun emit_created_price_feed_storage(
    price_feed_storage_obj_id: ID,
    storage_id: u32,
    symbol: String,
) {
    abort 404
}

//************************************************************************************************//
// CreatedSource                                                                                  //
//************************************************************************************************//

public struct CreatedSource has copy, drop {
    source_id: u16,
    source_object_id: ID,
}

public(package) fun emit_created_source(
    source_id: u16,
    source_object_id: ID,
) {
    abort 404
}

//************************************************************************************************//
// UpgradedSourceVersion                                                                          //
//************************************************************************************************//

public struct UpgradedSourceVersion has copy, drop {
    source_id: u16,
    version: u64,
}

public(package) fun emit_upgraded_source_version(
    source_id: u16,
    version: u64,
) {
    abort 404
}

//************************************************************************************************//
// AddedAuthorization                                                                             //
//************************************************************************************************//

public struct AddedAuthorization has copy, drop {
    source_id: u16,
}

public(package) fun emit_added_authorization(source_id: u16) {
    abort 404
}

//************************************************************************************************//
// RemovedAuthorization                                                                           //
//************************************************************************************************//

public struct RemovedAuthorization has copy, drop {
    source_id: u16,
}

public(package) fun emit_removed_authorization(source_id: u16) {
    abort 404
}

//************************************************************************************************//
// CreatedPriceFeed                                                                               //
//************************************************************************************************//

public struct CreatedPriceFeed has copy, drop {
    storage_id: u32,
    source_id: u16,
    price: u128,
    timestamp_ms: u64,
}

public(package) fun emit_created_price_feed(
    storage_id: u32,
    source_id: u16,
    price: u128,
    timestamp_ms: u64,
) {
    abort 404
}

//************************************************************************************************//
// RemovedPriceFeed                                                                               //
//************************************************************************************************//

public struct RemovedPriceFeed has copy, drop {
    storage_id: u32,
    source_id: u16,
}

public(package) fun emit_removed_price_feed(
    storage_id: u32,
    source_id: u16,
) {
    abort 404
}

//************************************************************************************************//
// UpdatedPriceFeed                                                                               //
//************************************************************************************************//

public struct UpdatedPriceFeed has copy, drop {
    storage_id: u32,
    source_id: u16,
    old_price: u128,
    old_timestamp_ms: u64,
    old_twap_price: u128,
    new_price: u128,
    new_timestamp_ms: u64,
    new_twap_price: u128,
}

public(package) fun emit_updated_price_feed(
    storage_id: u32,
    source_id: u16,
    old_price: u128,
    old_timestamp_ms: u64,
    old_twap_price: u128,
    new_price: u128,
    new_timestamp_ms: u64,
    new_twap_price: u128,
) {
    abort 404
}

//************************************************************************************************//
// UpdatedTwapPeriodMs                                                                            //
//************************************************************************************************//

public struct UpdatedTwapPeriodMs has copy, drop {
    storage_id: u32,
    source_id: u16,
    old_twap_period_ms: u64,
    new_twap_period_ms: u64,
}

public(package) fun emit_updated_twap_period_ms(
    storage_id: u32,
    source_id: u16,
    old_twap_period_ms: u64,
    new_twap_period_ms: u64,
) {
    abort 404
}

//************************************************************************************************//
// SetVendorRegistration                                                                          //
//************************************************************************************************//

public struct SetVendorRegistration has copy, drop {
    open: bool,
}

public(package) fun emit_set_vendor_registration(open: bool) {
    abort 404
}

//************************************************************************************************//
// RegisteredVendor                                                                               //
//************************************************************************************************//

public struct RegisteredVendor has copy, drop {
    vendor_key: TypeName,
    vendor_admin_cap_id: ID,
}

public(package) fun emit_registered_vendor(vendor_key: TypeName, vendor_admin_cap_id: ID) {
    abort 404
}

//************************************************************************************************//
// CreatedPackageRevokeVendorGuardianCap                                                          //
//************************************************************************************************//

public struct CreatedPackageRevokeVendorGuardianCap has copy, drop {
    cap_id: ID,
}

public(package) fun emit_created_package_revoke_vendor_guardian_cap(cap_id: ID) {
    abort 404
}

//************************************************************************************************//
// GuardianRevokedVendorAuthorityCap                                                              //
//************************************************************************************************//

public struct GuardianRevokedVendorAuthorityCap has copy, drop {
    vendor_key: TypeName,
    role: TypeName,
    cap_id: ID,
}

public(package) fun emit_guardian_revoked_vendor_authority_cap(
    vendor_key: TypeName,
    role: TypeName,
    cap_id: ID,
) {
    abort 404
}

//************************************************************************************************//
// ReauthorizedVendorAdminCap                                                                     //
//************************************************************************************************//

public struct ReauthorizedVendorAdminCap has copy, drop {
    vendor_key: TypeName,
    cap_id: ID,
}

public(package) fun emit_reauthorized_vendor_admin_cap(vendor_key: TypeName, cap_id: ID) {
    abort 404
}

//************************************************************************************************//
// CreatedPackageFreezeGuardianCap                                                                //
//************************************************************************************************//

public struct CreatedPackageFreezeGuardianCap has copy, drop {
    cap_id: ID,
}

public(package) fun emit_created_package_freeze_guardian_cap(cap_id: ID) {
    abort 404
}

//************************************************************************************************//
// Froze                                                                                          //
//************************************************************************************************//

public struct Froze has copy, drop {
    id: ID,
    resume_version: u64,
    guardian_cap_id: ID,
}

public(package) fun emit_froze(id: ID, resume_version: u64, guardian_cap_id: ID) {
    abort 404
}

//************************************************************************************************//
// Unfroze                                                                                        //
//************************************************************************************************//

public struct Unfroze has copy, drop {
    id: ID,
    version: u64,
}

public(package) fun emit_unfroze(id: ID, version: u64) {
    abort 404
}
