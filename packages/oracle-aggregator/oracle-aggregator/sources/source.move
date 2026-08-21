// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module oracle_aggregator::source;

use oracle_aggregator::authority::{PACKAGE, SourceCap};
use oracle_aggregator::config::Config;
use oracle_aggregator::events;

use authority_cap::authority::AuthorityCap;

use sui::derived_object;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error(code = 0)]
const EInvalidVersion: vector<u8> =
    b"This integration package version cannot be used for the requested action.";

//************************************************************************************************//
// SourceObjectKey                                                                                //
//************************************************************************************************//

public struct SourceObjectKey(u16) has copy, drop, store;

//************************************************************************************************//
// Source                                                                                         //
//************************************************************************************************//

public struct Source<phantom SourceKey> has key, store {
    id: UID,
    source_cap: SourceCap,

    version: u64,
}

//****************************************** Constructors ****************************************//

public fun create<SourceKey, ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    _: &SourceKey,
    version: u64,
): Source<SourceKey> {
    abort 404
}

//************** Mutators [Permissioned] [AuthorityCap<PACKAGE, ADMIN | ASSISTANT>] **************//

public fun set_authorized<SourceKey, ADMIN_OR_ASSISTANT>(
    source: &mut Source<SourceKey>,
    config: &Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    authorized: bool,
) {
    abort 404
}

public fun upgrade_version<SourceKey, ADMIN_OR_ASSISTANT>(
    source: &mut Source<SourceKey>,
    config: &Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    version: u64,
) {
    abort 404
}

//******************************************** Getters *******************************************//

public fun source_id<SourceKey>(source: &Source<SourceKey>): u16 {
    abort 404
}

public fun version<SourceKey>(source: &Source<SourceKey>): u64 {
    abort 404
}

public fun object_id<SourceKey>(source: &Source<SourceKey>): ID {
    abort 404
}

public fun derived_id(
    config: &Config,
    source_id: u16,
): ID {
    abort 404
}

//********************************* Getters [permissioned] [Key] *********************************//

public fun child_exists<SourceKey, Key: copy + drop + store>(
    source: &Source<SourceKey>,
    key: Key,
): bool {
    abort 404
}

public fun child_id<SourceKey, Key: copy + drop + store>(
    source: &Source<SourceKey>,
    key: Key,
): ID {
    abort 404
}

//****************************** Getters [permissioned] [SourceKey] ******************************//

public fun borrow_source_cap<SourceKey: drop>(
    source: &Source<SourceKey>,
    _witness: SourceKey,
): &SourceCap {
    abort 404
}

public fun borrow_mut_id<SourceKey: drop>(
    source: &mut Source<SourceKey>,
    _witness: SourceKey,
): &mut UID {
    abort 404
}

//**************************************** Validity Checks ***************************************//

public fun assert_version<SourceKey>(
    source: &Source<SourceKey>,
    current_version: u64,
) {
    abort 404
}
