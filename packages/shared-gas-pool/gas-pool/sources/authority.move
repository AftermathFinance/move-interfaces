// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: BUSL-1.1

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module shared_gas_pool::authority;

use authority_cap::authority::{AuthorityCap, ADMIN, ASSISTANT};

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error(code = 0)]
const EPackageAuthorityCapAlreadyCreated: vector<u8> = b"The package authority cap for this role has already been created.";

#[error(code = 1)]
const EInvalidAuthorityRole: vector<u8> = b"This function does not accept the ADMIN authority role.";

//************************************************************************************************//
// AuthorityCap                                                                                   //
//************************************************************************************************//

//******************************************** Contexts ******************************************//

public struct PACKAGE() has drop;
public struct POOL() has drop;

//********************************************* Roles ********************************************//

public struct MAINTENANCE() has drop;

//****************************************** Constructors ****************************************//

#[allow(lint(self_transfer))]
public(package) fun create_package_admin_cap_and_keep<T: drop>(
    witness: &T,
    config_id: &mut UID,
    ctx: &TxContext,
) {
    abort 404
}

public(package) fun create_multiton_package_assistant_cap(
    config_id: &mut UID,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, ASSISTANT> {
    abort 404
}

public(package) fun create_multiton_package_maintenance_cap(
    config_id: &mut UID,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, MAINTENANCE> {
    abort 404
}

//************************************************************************************************//
// Validity Checks                                                                                //
//************************************************************************************************//

public(package) fun assert_is_not_admin<Role>() {
    abort 404
}
