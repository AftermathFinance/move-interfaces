// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: BUSL-1.1

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module vendor::metadata;

use vendor::authority::VENDOR;
use vendor::config::Config;

use authority_cap::authority::{AuthorityCap, ADMIN};

use sui::vec_map::{Self, VecMap};
use sui::dynamic_field as df;
use sui::derived_object;

use std::ascii::String;
use std::type_name;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

const EVendorMetadataAlreadyCreated: u64 = 0;

const ERestrictedKey: u64 = 1;

//************************************************************************************************//
// VendorMetadataKey                                                                              //
//************************************************************************************************//

public struct VendorMetadataKey<phantom VendorKey>() has copy, drop, store;

//************************************************************************************************//
// ApprovedDomainRegistrationKey                                                                  //
//************************************************************************************************//

public struct ApprovedDomainRegistrationKey<phantom Domain>() has copy, drop, store;

//************************************************************************************************//
// VendorMetadata                                                                                 //
//************************************************************************************************//

public struct VendorMetadata<phantom VendorKey> has key, store {
    id: UID,

    name: String,
    description: String,

    extra_fields: VecMap<String, String>
}

//****************************************** Constructors ****************************************//

public fun new<VendorKey, ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    name: String,
    description: String,
): VendorMetadata<VendorKey> {
    abort 404
}

//********* Mutators [Permissioned] [AuthorityCap<VENDOR<VendorKey>, ADMIN | ASSISTANT>] *********//

public fun set_name<VendorKey, ADMIN_OR_ASSISTANT>(
    metadata: &mut VendorMetadata<VendorKey>,
    config: &Config,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    name: String,
) {
    abort 404
}

public fun set_description<VendorKey, ADMIN_OR_ASSISTANT>(
    metadata: &mut VendorMetadata<VendorKey>,
    config: &Config,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    description: String,
) {
    abort 404
}

public fun set_extra_field<VendorKey, ADMIN_OR_ASSISTANT>(
    metadata: &mut VendorMetadata<VendorKey>,
    config: &Config,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    key: String,
    value: String,
) {
    abort 404
}

//*************** Mutators [Permissioned] [AuthorityCap<Domain, ADMIN>] **************************//

public fun approve_domain_registration<VendorKey, Domain>(
    metadata: &mut VendorMetadata<VendorKey>,
    config: &Config,
    _: &AuthorityCap<Domain, ADMIN>,
) {
    abort 404
}

public fun revoke_domain_registration_approval<VendorKey, Domain>(
    metadata: &mut VendorMetadata<VendorKey>,
    config: &Config,
    _: &AuthorityCap<Domain, ADMIN>,
) {
    abort 404
}

//******************************************** Getters *******************************************//

public fun is_domain_registration_approved<VendorKey, Domain>(
    metadata: &VendorMetadata<VendorKey>,
): bool {
    abort 404
}
