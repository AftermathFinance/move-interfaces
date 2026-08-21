// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module oracle_aggregator_pyth_lazer_rolling_integration::events;

use sui::event::emit;

//************************************************************************************************//
// MigratedFeedInfoObjectV1                                                                       //
//************************************************************************************************//

public struct MigratedFeedInfoObjectV1 has copy, drop {
    feed_info_object_id: ID,
    front_feed_id: u32,
    next_feed_id: u32,
    expiry_timestamp_ms: u64,
}

public(package) fun emit_migrated_feed_info_object(
    feed_info_object_id: ID,
    front_feed_id: u32,
    next_feed_id: u32,
    expiry_timestamp_ms: u64,
) {
    abort 404
}

//************************************************************************************************//
// UpdatedRollingWindowV1                                                                         //
//************************************************************************************************//

public struct UpdatedRollingWindowV1 has copy, drop {
    feed_info_object_id: ID,
    roll_start_timestamp_ms: u64,
    roll_end_timestamp_ms: u64,
}

public(package) fun emit_updated_rolling_window(
    feed_info_object_id: ID,
    roll_start_timestamp_ms: u64,
    roll_end_timestamp_ms: u64,
) {
    abort 404
}
