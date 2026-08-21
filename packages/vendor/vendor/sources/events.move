// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: BUSL-1.1

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module vendor::events;

use std::type_name::TypeName;
use std::ascii;

//************************************************************************************************//
// Event                                                                                          //
//************************************************************************************************//

public struct Event<VersionedEvent: copy + drop>(VersionedEvent) has copy, drop;

fun emit<VersionedEvent: copy + drop>(
    event: VersionedEvent
) {
    abort 404
}

//************************************************************************************************//
// ApproveDomainRegistrationEventV1                                                               //
//************************************************************************************************//

public struct ApproveDomainRegistrationEventV1 has copy, drop {
    vendor_key: ascii::String,
    domain: ascii::String,
}

public(package) fun emit_approve_domain_registration_event(
    vendor_key: TypeName,
    domain: TypeName,
) {
    abort 404
}

//************************************************************************************************//
// RevokeDomainRegistrationApprovalEventV1                                                        //
//************************************************************************************************//

public struct RevokeDomainRegistrationApprovalEventV1 has copy, drop {
    vendor_key: ascii::String,
    domain: ascii::String,
}

public(package) fun emit_revoke_domain_registration_approval_event(
    vendor_key: TypeName,
    domain: TypeName,
) {
    abort 404
}

//************************************************************************************************//
// CreatePackageRevokeVendorGuardianCapEventV1                                                    //
//************************************************************************************************//

public struct CreatePackageRevokeVendorGuardianCapEventV1 has copy, drop {
    cap_id: ID,
}

public(package) fun emit_create_package_revoke_vendor_guardian_cap_event(cap_id: ID) {
    abort 404
}

//************************************************************************************************//
// DeauthorizePackageRevokeVendorGuardianCapEventV1                                               //
//************************************************************************************************//

public struct DeauthorizePackageRevokeVendorGuardianCapEventV1 has copy, drop {
    cap_id: ID,
}

public(package) fun emit_deauthorize_package_revoke_vendor_guardian_cap_event(cap_id: ID) {
    abort 404
}

//************************************************************************************************//
// GuardianRevokeVendorAuthorityCapEventV1                                                        //
//************************************************************************************************//

public struct GuardianRevokeVendorAuthorityCapEventV1 has copy, drop {
    vendor_key: ascii::String,
    role: ascii::String,
    cap_id: ID,
}

public(package) fun emit_guardian_revoke_vendor_authority_cap_event(
    vendor_key: TypeName,
    role: TypeName,
    cap_id: ID,
) {
    abort 404
}

//************************************************************************************************//
// ReauthorizeVendorAdminCapEventV1                                                               //
//************************************************************************************************//

public struct ReauthorizeVendorAdminCapEventV1 has copy, drop {
    vendor_key: ascii::String,
    cap_id: ID,
}

public(package) fun emit_reauthorize_vendor_admin_cap_event(
    vendor_key: TypeName,
    cap_id: ID,
) {
    abort 404
}
