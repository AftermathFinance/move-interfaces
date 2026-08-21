// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: BUSL-1.1

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module authority_cap::authority;

use sui::transfer::Receiving;
use sui::derived_object;

use std::type_name::{Self, TypeName};
use std::internal::Permit;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

const EAuthorityCapAlreadyCreated: u64 = 0;

const EInvalidAuthorityRole: u64 = 1;

const EAuthorityCapRegisteredAsSingleton: u64 = 2;

const EAuthorityCapRegisteredAsMultiton: u64 = 3;

//************************************************************************************************//
// Roles                                                                                          //
//************************************************************************************************//

public struct ADMIN()

public struct ASSISTANT()

//************************************************************************************************//
// SingletonKey                                                                                   //
//************************************************************************************************//

public struct SingletonKey<phantom Context, phantom Role>() has copy, drop, store;

//************************************************************************************************//
// MultitonKey                                                                                    //
//************************************************************************************************//

public struct MultitonKey<phantom Context, phantom Role>() has copy, drop, store;

//************************************************************************************************//
// AuthorityCapKey                                                                                //
//************************************************************************************************//

public struct AuthorityCapKey<phantom Context, phantom Role>() has copy, drop, store;

//************************************************************************************************//
// AuthorizedAuthorityCapKey                                                                      //
//************************************************************************************************//

public struct AuthorizedAuthorityCapKey<phantom Context, phantom Role> has copy, drop, store {
    cap_id: ID,
}

//****************************************** Constructor *****************************************//

public fun authorized_authority_cap_key<Context, Role>(
    cap_id: ID,
): AuthorizedAuthorityCapKey<Context, Role> {
    abort 404
}

//************************************************************************************************//
// AuthorityCap                                                                                   //
//************************************************************************************************//

public struct AuthorityCap<phantom Context, phantom Role> has key, store {
    id: UID,
    `for`: ID,
}

//****************************************** Constructor *****************************************//

public fun new<Context: drop, Role: drop>(
    id: &mut UID,
    _: &Context,
    _: &Role,
    `for`: ID,
): AuthorityCap<Context, Role> {
    abort 404
}

public fun new_multiton<Context: drop, Role: drop>(
    id: &mut UID,
    _: &Context,
    _: &Role,
    `for`: ID,
    ctx: &mut TxContext,
): AuthorityCap<Context, Role> {
    abort 404
}

public fun new_admin_cap<Context: drop>(
    id: &mut UID,
    _: &Context,
    `for`: ID,
): AuthorityCap<Context, ADMIN> {
    abort 404
}

public fun new_multiton_admin_cap<Context: drop>(
    id: &mut UID,
    _: &Context,
    `for`: ID,
    ctx: &mut TxContext,
): AuthorityCap<Context, ADMIN> {
    abort 404
}

public fun new_assistant_cap<Context: drop>(
    id: &mut UID,
    _: &Context,
    `for`: ID,
): AuthorityCap<Context, ASSISTANT> {
    abort 404
}

public fun new_multiton_assistant_cap<Context: drop>(
    id: &mut UID,
    _: &Context,
    `for`: ID,
    ctx: &mut TxContext,
): AuthorityCap<Context, ASSISTANT> {
    abort 404
}

//***************************************** Deconstructor ****************************************//

public fun destroy<Context, Role>(
    cap: AuthorityCap<Context, Role>,
    _: Permit<Context>,
) {
    abort 404
}

//******************************************** Getters *******************************************//

public fun `for`<Context, Role>(cap: &AuthorityCap<Context, Role>): ID {
    abort 404
}

//******************************************* Mutators *******************************************//

public fun borrow_mut_id<Context, Role>(
    cap: &mut AuthorityCap<Context, Role>,
    _: Permit<Context>,
): &mut UID {
    abort 404
}

public fun receive<Context, Role, T: key + store>(
    cap: &mut AuthorityCap<Context, Role>,
    to_receive: Receiving<T>,
): T {
    abort 404
}

//************************************************************************************************//
// Public Functions                                                                               //
//************************************************************************************************//

public fun exists<Context, Role>(
    id: &UID,
): bool {
    abort 404
}

public fun derived_cap_id<Context, Role>(id: &UID): ID {
    abort 404
}

public fun authorize_cap<Context, Role>(
    id: &mut UID,
    cap: &AuthorityCap<Context, Role>,
) {
    abort 404
}

public fun deauthorize_cap<Context, Role>(
    id: &mut UID,
    cap_id: ID,
) {
    abort 404
}

public fun is_cap_authorized<Context, Role>(
    id: &UID,
    cap_id: ID,
): bool {
    abort 404
}

public fun is_singleton<Context, Role>(
    id: &UID,
): bool {
    abort 404
}

public fun is_multiton<Context, Role>(
    id: &UID,
): bool {
    abort 404
}

//************************************************************************************************//
// Validity Checks                                                                                //
//************************************************************************************************//

public fun assert_is_admin_or_assistant<Role>() {
    abort 404
}

public fun assert_is_admin<Role>() {
    abort 404
}
