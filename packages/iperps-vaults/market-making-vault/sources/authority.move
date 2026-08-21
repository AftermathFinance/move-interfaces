// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module market_making_vault::authority;

use authority_cap::authority::{AuthorityCap, ADMIN, ASSISTANT};

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error(code = 0)]
const EInvalidAuthorityRole: vector<u8> = b"This function only accepts ADMIN or ASSISTANT authority roles.";

#[error(code = 1)]
const EPackageAuthorityCapAlreadyCreated: vector<u8> =
    b"The package authority cap has already been created.";

#[error(code = 2)]
const EVaultAuthorityCapAlreadyCreated: vector<u8> =
    b"The vault authority cap has already been created.";

//************************************************************************************************//
// AuthorityCap                                                                                   //
//************************************************************************************************//

//******************************************** Contexts ******************************************//

public struct PACKAGE() has drop;

public struct VAULT<phantom LpCoin>() has drop;

//********************************************* Roles ********************************************//

public struct MAINTENANCE() has drop;

public struct PAUSE_GUARDIAN() has drop;

public struct TREASURY() has drop;

public struct FREEZE_GUARDIAN() has drop;

//****************************************** Constructors ****************************************//

#[allow(lint(self_transfer))]
public(package) fun create_package_admin_cap<T: drop>(
    witness: &T,
    config_id: &mut UID,
): AuthorityCap<PACKAGE, ADMIN> {
    abort 404
}

public(package) fun create_multiton_package_assistant_cap(
    config_id: &mut UID,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, ASSISTANT> {
    abort 404
}

public(package) fun create_multiton_package_pause_guardian_cap(
    config_id: &mut UID,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, PAUSE_GUARDIAN> {
    abort 404
}

public(package) fun create_multiton_package_maintenance_cap(
    config_id: &mut UID,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, MAINTENANCE> {
    abort 404
}

public(package) fun create_multiton_package_freeze_guardian_cap(
    config_id: &mut UID,
    ctx: &mut TxContext,
): AuthorityCap<PACKAGE, FREEZE_GUARDIAN> {
    abort 404
}

public(package) fun create_vault_admin_cap<LpCoin>(
    vault_id: &mut UID,
): AuthorityCap<VAULT<LpCoin>, ADMIN> {
    abort 404
}

public(package) fun create_vault_assistant_cap<LpCoin>(
    vault_id: &mut UID,
    ctx: &mut TxContext,
): AuthorityCap<VAULT<LpCoin>, ASSISTANT> {
    abort 404
}

public(package) fun create_vault_treasury_cap<LpCoin>(
    vault_id: &mut UID,
    ctx: &mut TxContext,
): AuthorityCap<VAULT<LpCoin>, TREASURY> {
    abort 404
}

public(package) fun assert_is_not_admin<Role>() {
    abort 404
}

public(package) fun package_id(): ID {
    abort 404
}
