// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

/// Module: admin
module mpoints::admin;

use mpoints::mpoints::MPOINTS;

use sui::coin::TreasuryCap;

//************************************************************************************************//
// AdminCap                                                                                       //
//************************************************************************************************//

/// Admin capability object to allow permissioned functionality on the `Registry` object.
public struct AdminCap has key, store {
    id: UID,
}

//****************************************** Constructors ****************************************//

/// Create the package's unique `AdminCap` object. The `TreasuryCap<MPOINTS>` will be converted
/// into a `Supply<MPOINTS>` after this function is called, therefore we are guaranteed that only
/// one `AdminCap` will ever exist.
public(package) fun create_admin_cap(
    _: &TreasuryCap<MPOINTS>,
    _ctx: &mut TxContext
): AdminCap {
    abort 404
}
