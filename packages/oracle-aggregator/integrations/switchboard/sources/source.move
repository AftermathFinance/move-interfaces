// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module oracle_aggregator_switchboard_integration::source;

use oracle_aggregator::authority::{PACKAGE, SourceCap};
use oracle_aggregator::config::Config;
use oracle_aggregator::source::Source;

use authority_cap::authority::AuthorityCap;

//************************************************************************************************//
// Constants                                                                                      //
//************************************************************************************************//

const CURRENT_VERSION: u64 = 1;

//************************************************************************************************//
// SWITCHBOARD                                                                                    //
//************************************************************************************************//

public struct SWITCHBOARD() has drop;

//************************************************************************************************//
// Source                                                                                         //
//************************************************************************************************//

//************ Constructors [Permissioned] [AuthorityCap<PACKAGE, ADMIN | ASSISTANT>] ************//

public fun create<ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
): Source<SWITCHBOARD> {
    abort 404
}

//******************************************** Getters *******************************************//

public(package) fun source_cap(source: &Source<SWITCHBOARD>): &SourceCap {
    abort 404
}

//************** Mutators [Permissioned] [AuthorityCap<PACKAGE, ADMIN | ASSISTANT>] **************//

public fun authorize<ADMIN_OR_ASSISTANT>(
    source: &mut Source<SWITCHBOARD>,
    config: &Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
) {
    abort 404
}

public fun deauthorize<ADMIN_OR_ASSISTANT>(
    source: &mut Source<SWITCHBOARD>,
    config: &Config,
    cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
) {
    abort 404
}

//**************************************** Validity Checks ***************************************//

public(package) fun assert_version(source: &Source<SWITCHBOARD>) {
    abort 404
}
