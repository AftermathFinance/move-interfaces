// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module oracle_aggregator_pyth_lazer_integration::feed_info_object;

use oracle_aggregator_pyth_lazer_integration::source::PYTH_LAZER;

use oracle_aggregator::authority::VENDOR;
use oracle_aggregator::config::Config;
use oracle_aggregator::source::Source;

use authority_cap::authority::AuthorityCap;

use sui::derived_object;
use fun oracle_aggregator_pyth_lazer_integration::source::assert_version as Source.assert_version;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error(code = 0)]
const EFeedInfoObjectAlreadyCreated: vector<u8> =
    b"Pyth Lazer integration: the feed info object has already been created.";

#[error(code = 1)]
const EInvalidSharePolicy: vector<u8> =
    b"Pyth Lazer integration: the provided SharePolicy does not match the FeedInfoObject.";

//************************************************************************************************//
// FeedInfoObjectKey                                                                              //
//************************************************************************************************//

public struct FeedInfoObjectKey<phantom VendorKey>(u32) has copy, drop, store;

//************************************************************************************************//
// SharePolicy                                                                                    //
//************************************************************************************************//

public struct SharePolicy(ID)

//************************************************************************************************//
// FeedInfoObject                                                                                 //
//************************************************************************************************//

public struct FeedInfoObject has key, store {
    id: UID,
    feed_id: u32,
}

//******** Constructor [Permissioned] [AuthorityCap<VENDOR<VendorKey>, ADMIN | ASSISTANT>] *******//

public fun new<VendorKey, ADMIN_OR_ASSISTANT>(
    source: &mut Source<PYTH_LAZER>,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    config: &Config,
    feed_id: u32,
): (FeedInfoObject, SharePolicy) {
    abort 404
}

#[allow(lint(custom_state_change))]
public fun share(
    feed_info_object: FeedInfoObject,
    share_policy: SharePolicy,
) {
    abort 404
}

//******************************************** Getters *******************************************//

public fun feed_id(
    feed_info_object: &FeedInfoObject,
): u32 {
    abort 404
}
