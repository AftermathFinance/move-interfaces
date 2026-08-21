// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module oracle_aggregator_pyth_lazer_rolling_integration::feed_info_object;

use oracle_aggregator_pyth_lazer_rolling_integration::source::PYTH_LAZER_ROLLING;
use oracle_aggregator_pyth_lazer_rolling_integration::events;

use oracle_aggregator::authority::VENDOR;
use oracle_aggregator::config::Config;
use oracle_aggregator::source::Source;

use authority_cap::authority::AuthorityCap;

use sui::derived_object;
use sui::clock::Clock;

use std::string::String;

use fun oracle_aggregator_pyth_lazer_rolling_integration::source::assert_version
    as Source.assert_version;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error(code = 0)]
const EFeedInfoObjectAlreadyCreated: vector<u8> =
    b"Pyth Lazer Rolling integration: the feed info object has already been created.";

#[error(code = 1)]
const EInvalidVendor: vector<u8> = b"The FeedInfoObject belongs to another Vendor.";

#[error(code = 2)]
const ERollStartTimestampMustPrecedeRollEndTimestamp: vector<u8> =
    b"Pyth Lazer Rolling integration: the roll start timestamp must precede the roll end timestamp.";

#[error(code = 3)]
const EInvalidSharePolicy: vector<u8> =
    b"Pyth Lazer Rolling integration: the provided SharePolicy does not match the FeedInfoObject.";

#[error(code = 4)]
const ECurrentRollNotComplete: vector<u8> =
    b"Pyth Lazer Rolling integration: the current roll window has not completed.";

#[error(code = 5)]
const ERollWindowMustBeFuture: vector<u8> =
    b"Pyth Lazer Rolling integration: the roll window must start in the future.";

#[error(code = 6)]
const ERollWindowMustEndInFuture: vector<u8> =
    b"Pyth Lazer Rolling integration: the roll window must end in the future.";

#[error(code = 7)]
const ERollMustCompleteBeforeExpiry: vector<u8> =
    b"Pyth Lazer Rolling integration: the roll must complete before the front-month contract expires.";

#[error(code = 8)]
const ENextFeedIdMustDiffer: vector<u8> =
    b"Pyth Lazer Rolling integration: the next feed id must differ from the front feed id.";

//************************************************************************************************//
// FeedInfoObjectKey                                                                              //
//************************************************************************************************//

public struct FeedInfoObjectKey<phantom VendorKey>(vector<u8>) has copy, drop, store;

//************************************************************************************************//
// SharePolicy                                                                                    //
//************************************************************************************************//

public struct SharePolicy(ID)

//************************************************************************************************//
// FeedInfoObject                                                                                 //
//************************************************************************************************//

public struct FeedInfoObject has key, store {
    id: UID,

    symbol: String,

    front_feed_id: u32,

    next_feed_id: u32,

    roll_start_timestamp_ms: u64,

    roll_end_timestamp_ms: u64,

    expiry_timestamp_ms: u64,
}

//******** Constructor [Permissioned] [AuthorityCap<VENDOR<VendorKey>, ADMIN | ASSISTANT>] *******//

public fun new<VendorKey, ADMIN_OR_ASSISTANT>(
    source: &mut Source<PYTH_LAZER_ROLLING>,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    config: &Config,
    symbol: String,
    front_feed_id: u32,
    next_feed_id: u32,
    expiry_timestamp_ms: u64,
    roll_start_timestamp_ms: u64,
    roll_end_timestamp_ms: u64,
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

public fun symbol(
    feed_info_object: &FeedInfoObject,
): String {
    abort 404
}

public fun front_feed_id(
    feed_info_object: &FeedInfoObject,
): u32 {
    abort 404
}

public fun next_feed_id(
    feed_info_object: &FeedInfoObject,
): u32 {
    abort 404
}

public fun expiry_timestamp_ms(
    feed_info_object: &FeedInfoObject,
): u64 {
    abort 404
}

public fun roll_start_timestamp_ms(
    feed_info_object: &FeedInfoObject,
): u64 {
    abort 404
}

public fun roll_end_timestamp_ms(
    feed_info_object: &FeedInfoObject,
): u64 {
    abort 404
}

//******** Mutators [Permissioned] [AuthorityCap<VENDOR<VendorKey>, ADMIN | MAINTENANCE>] *******//

public fun migrate<VendorKey, ADMIN_OR_MAINTENANCE>(
    feed_info_object: &mut FeedInfoObject,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_MAINTENANCE>,
    source: &Source<PYTH_LAZER_ROLLING>,
    config: &Config,
    next_feed_id: u32,
    expiry_timestamp_ms: u64,
    roll_start_timestamp_ms: u64,
    roll_end_timestamp_ms: u64,
    clock: &Clock,
) {
    abort 404
}

public fun set_rolling_window<VendorKey, ADMIN_OR_MAINTENANCE>(
    feed_info_object: &mut FeedInfoObject,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_MAINTENANCE>,
    source: &Source<PYTH_LAZER_ROLLING>,
    config: &Config,
    roll_start_timestamp_ms: u64,
    roll_end_timestamp_ms: u64,
    clock: &Clock,
) {
    abort 404
}
