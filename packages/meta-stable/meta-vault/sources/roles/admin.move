// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

/// Module: admin
module meta_vault::admin;

use meta_vault::events;

use sui::types::is_one_time_witness;
use sui::dynamic_field as df;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error]
/// `create_admin_cap` is called with a non-one-time-witness provided for the `witness` field.
const EAdminCapAlreadyCreated: vector<u8> = b"The singleton `AdminCap` has already been created.";

#[error]
const ENotAuthorized: vector<u8> = b"The Admin has not granted this singleton object the authority to call `create_deposit_cap` or `create_wthdraw_cap`.";

#[error]
const EAlreadyAuthorized: vector<u8> = b"The Admin has already granted this singleton object the authority to call `create_deposit_cap` or `create_wthdraw_cap`.";

//************************************************************************************************//
// AdminCap                                                                                       //
//************************************************************************************************//

/// Admin capability object to allow permissioned functionality on the `Vault` object.
public struct AdminCap has key, store {
    id: UID,
}

//****************************************** Constructors ****************************************//

/// Create the packages unique `AdminCap` object.
///
/// aborts:
///   i. [meta_vault::admin::EAdminCapAlreadyCreated]
public(package) fun create_admin_cap<T: drop>(
    witness: &T,
    ctx: &mut TxContext
): AdminCap {
    abort 404
}

//************************************************************************************************//
// AuthKey                                                                                        //
//************************************************************************************************//

public struct AuthKey has copy, store, drop { }

//********************************************* Getters ******************************************//

public fun has_authorized(app_id: &UID): bool {
    abort 404
}

//************************************************************************************************//
// AuthCap                                                                                        //
//************************************************************************************************//

public struct AuthCap has store, drop { }

//********************************************* Mutators ******************************************//

/// Grants an object's UID access to call `create_deposit_cap` and `create_withdraw_cap`. The UID
/// should come from a singleton object.
public fun authorize(
    _: &AdminCap,
    app_id: &mut UID,
) {
    abort 404
}

/// Revoke the ability for the corresponding object to call `create_deposit_cap` and
/// `create_withdraw_cap`. The UID should come from a singleton object.
public fun deauthorize(
    _: &AdminCap,
    app_id: &mut UID
) {
    abort 404
}

//**************************************************************************************************//
// Validity Checks                                                                                  //
//**************************************************************************************************//

use fun assert_app_is_authorized as UID.assert_app_is_authorized;
public fun assert_app_is_authorized(app_id: &UID) {
    abort 404
}

use fun assert_app_is_deauthorized as UID.assert_app_is_deauthorized;
fun assert_app_is_deauthorized(app_id: &UID) {
    abort 404
}
