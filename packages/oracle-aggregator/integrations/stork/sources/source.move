// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module oracle_aggregator_stork_integration::source;

use oracle_aggregator::authority::{PACKAGE, SourceCap};
use oracle_aggregator::config::Config;
use oracle_aggregator::source::Source;

use authority_cap::authority::AuthorityCap;

//************************************************************************************************//
// Constants                                                                                      //
//************************************************************************************************//

const CURRENT_VERSION: u64 = 1;

//************************************************************************************************//
// STORK                                                                                          //
//************************************************************************************************//

public struct STORK() has drop;

//************************************************************************************************//
// Source                                                                                         //
//************************************************************************************************//

//************ Constructors [Permissioned] [AuthorityCap<PACKAGE, ADMIN | ASSISTANT>] ************//

public fun create<ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
): Source<STORK> {
    abort 404
}

//******************************************** Getters *******************************************//

public(package) fun source_cap(source: &Source<STORK>): &SourceCap {
    abort 404
}

public(package) fun borrow_mut_id(source: &mut Source<STORK>): &mut UID {
    abort 404
}

//************** Mutators [Permissioned] [AuthorityCap<PACKAGE, ADMIN | ASSISTANT>] **************//

public fun authorize<ADMIN_OR_ASSISTANT>(
    source: &mut Source<STORK>,
    config: &Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
) {
    abort 404
}

public fun deauthorize<ADMIN_OR_ASSISTANT>(
    source: &mut Source<STORK>,
    config: &Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
) {
    abort 404
}

//**************************************** Validity Checks ***************************************//

public(package) fun assert_version(source: &Source<STORK>) {
    abort 404
}
