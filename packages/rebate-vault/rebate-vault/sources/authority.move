// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module rebate_vault::authority;

use authority_cap::authority::{AuthorityCap, ADMIN, ASSISTANT};

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error(code = 0)]
const EPackageAuthorityCapAlreadyCreated: vector<u8> =
    b"The singleton `AuthorityCap<PACKAGE, ADMIN>` has already been created.";

//************************************************************************************************//
// AuthorityCap                                                                                   //
//************************************************************************************************//

//******************************************** Contexts ******************************************//

public struct PACKAGE() has drop;

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
