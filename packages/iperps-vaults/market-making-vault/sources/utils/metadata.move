// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module market_making_vault::metadata;

use market_making_vault::events;
use market_making_vault::keys;
use market_making_vault::authority::VAULT;

use authority_cap::authority::{AuthorityCap, ADMIN};

use std::option::{Self as option, Option};

use sui::vec_map::{Self, VecMap};
use sui::derived_object;

use std::ascii::String;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error(code = 0)]
const EVaultMetadataCapAlreadyCreated: vector<u8> = b"The `VaultMetadata` has already been created for the given `Vault`.";

//************************************************************************************************//
// VaultMetadata                                                                                  //
//************************************************************************************************//

public struct VaultMetadata<phantom LpCoin> has key, store {
    id: UID,

    vault_id: ID,

    name: String,
    description: String,

    curator_name: Option<String>,
    curator_url: Option<String>,
    curator_logo_url: Option<String>,

    extra_fields: VecMap<String, String>
}

//****************************************** Constructor *****************************************//

public(package) fun new<LpCoin>(
    vault_id: &mut UID,
    name: String,
    description: String,
    curator_name: Option<String>,
    curator_url: Option<String>,
    curator_logo_url: Option<String>,
    mut extra_field_keys: Option<vector<String>>,
    mut extra_field_values: Option<vector<String>>,
): VaultMetadata<LpCoin> {
    abort 404
}

//******************************************* Mutators *******************************************//

public(package) fun set_name<LpCoin>(
    metadata: &mut VaultMetadata<LpCoin>,
    name: String,
) {
    abort 404
}

public(package) fun set_description<LpCoin>(
    metadata: &mut VaultMetadata<LpCoin>,
    description: String,
) {
    abort 404
}

public(package) fun set_curator_name<LpCoin>(
    metadata: &mut VaultMetadata<LpCoin>,
    curator_name: String,
) {
    abort 404
}

public(package) fun set_curator_url<LpCoin>(
    metadata: &mut VaultMetadata<LpCoin>,
    curator_url: String,
) {
    abort 404
}

public(package) fun set_curator_logo_url<LpCoin>(
    metadata: &mut VaultMetadata<LpCoin>,
    curator_logo_url: String,
) {
    abort 404
}

public(package) fun set_extra_field<LpCoin>(
    metadata: &mut VaultMetadata<LpCoin>,
    key: String,
    value: String,
) {
    abort 404
}

//******************************************** Getters *******************************************//

public(package) fun vault_id<LpCoin>(
    metadata: &VaultMetadata<LpCoin>,
): ID {
    abort 404
}
