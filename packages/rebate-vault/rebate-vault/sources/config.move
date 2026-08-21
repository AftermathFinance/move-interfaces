// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module rebate_vault::config;

use rebate_vault::authority::{Self, PACKAGE};

use authority_cap::authority::{AuthorityCap, ADMIN, ASSISTANT};

use sui::types::is_one_time_witness;

use fun sui::object::new as TxContext.new_uid;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error(code = 0)]
const EInvalidVersion: vector<u8> = b"You are interacting with an outdated contract.";

#[error(code = 1)]
const EConfigAlreadyCreated: vector<u8> = b"The singleton `Config` has already been created.";

#[error(code = 2)]
const EInvalidAuthorityCap: vector<u8> =
    b"The provided `AuthorityCap` does not have the authority to call the requested action.";

#[error(code = 3)]
const EInactiveAuthorityCap: vector<u8> =
    b"The provided `AuthorityCap<PACKAGE, ASSISTANT>` is not currently active.";

//************************************************************************************************//
// Constants                                                                                      //
//************************************************************************************************//

const CURRENT_VERSION: u64 = 1;

//************************************************************************************************//
// Config                                                                                         //
//************************************************************************************************//

public struct Config has key, store {
    id: UID,
    version: u64,
}

//****************************************** Constructor *****************************************//

public(package) fun new<T: drop>(
    witness: &T,
    ctx: &mut TxContext
): Config {
    abort 404
}

//******************************************** Getters *******************************************//

public fun current_version(): u64 { abort 404 }

public fun is_authority_cap_active<Context, Role>(
    config: &Config,
    cap_id: ID,
): bool {
    abort 404
}

public(package) fun borrow_mut_id(config: &mut Config): &mut UID {
    abort 404
}

public fun authority_cap_is_valid<Role>(
    config: &Config,
    authority_cap: &AuthorityCap<PACKAGE, Role>
): bool {
    abort 404
}

//******************* Mutators [Permissioned] [AuthorityCap<PACKAGE, ADMIN>] *********************//

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

//************** Mutators [Permissioned] [AuthorityCap<PACKAGE, ADMIN | ASSISTANT>] **************//

public fun upgrade_version<ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    authority_cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
) {
    abort 404
}

//************************************************************************************************//
// Validity Checks                                                                                //
//************************************************************************************************//

public(package) fun assert_correct_version(config: &Config) {
    abort 404
}

public(package) fun assert_authority_cap_is_valid<Role>(
    config: &Config,
    authority_cap: &AuthorityCap<PACKAGE, Role>
) {
    abort 404
}
