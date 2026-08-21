// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module oracle_aggregator_pyth_lazer_integration::price_feed_storage;

use oracle_aggregator_pyth_lazer_integration::source::PYTH_LAZER;
use oracle_aggregator_pyth_lazer_integration::feed_info_object::FeedInfoObject;

use oracle_aggregator::price_feed_storage::PriceFeedStorage;
use oracle_aggregator::authority::{PACKAGE, VENDOR};
use oracle_aggregator::config::Config;
use oracle_aggregator::source::Source;

use authority_cap::authority::{AuthorityCap, ADMIN};

use pyth_lazer::update::Update;
use pyth_lazer::state::State;
use pyth_lazer::feed::Feed;
use pyth_lazer::i16::I16;

use sui::clock::Clock;

use fun oracle_aggregator_pyth_lazer_integration::source::source_cap as Source.source_cap;
use fun oracle_aggregator_pyth_lazer_integration::source::assert_version as Source.assert_version;
use fun pyth_lazer::pyth_lazer::parse_and_verify_le_ecdsa_update
    as State.parse_and_verify_le_ecdsa_update;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error(code = 0)]
const EFeedNotFound: vector<u8> = b"Pyth Lazer integration: the requested feed was not found.";

#[error(code = 1)]
const EPriceNotReported: vector<u8> = b"Pyth Lazer integration: the feed did not report a price.";

#[error(code = 2)]
const EExponentNotReported: vector<u8> =
    b"Pyth Lazer integration: the feed did not report an exponent.";

#[error(code = 3)]
const EPriceIsNegative: vector<u8> = b"Pyth Lazer integration: the price cannot be negative.";

#[error(code = 4)]
const EUnsupportedExponent: vector<u8> =
    b"Pyth Lazer integration: the feed's exponent is too large for the price to be representable.";

#[error(code = 5)]
const EPriceOverflow: vector<u8> =
    b"Pyth Lazer integration: the normalized price does not fit into a u128.";

#[error(code = 6)]
const EFeedUpdateTimestampNotReported: vector<u8> =
    b"Pyth Lazer integration: the feed did not report an update timestamp.";

//************************************************************************************************//
// PriceFeedStorage                                                                               //
//************************************************************************************************//

//******** Constructor [Permissioned] [AuthorityCap<VENDOR<VendorKey>, ADMIN | ASSISTANT>] *******//

public fun new_price_feed_from_update<VendorKey, ADMIN_OR_ASSISTANT>(
    source: &Source<PYTH_LAZER>,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    config: &Config,
    price_feed_storage: &mut PriceFeedStorage,
    feed_info_object: &mut FeedInfoObject,
    update: &Update,
    twap_period_ms: u64,
) {
    abort 404
}

public fun new_price_feed<VendorKey, ADMIN_OR_ASSISTANT>(
    source: &Source<PYTH_LAZER>,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    config: &Config,
    price_feed_storage: &mut PriceFeedStorage,
    feed_info_object: &mut FeedInfoObject,
    lazer_state: &State,
    raw_update: vector<u8>,
    twap_period_ms: u64,
    clock: &Clock,
) {
    abort 404
}

//******************************************* Mutators *******************************************//

public fun update_price_feed_from_update(
    source: &Source<PYTH_LAZER>,
    config: &Config,
    price_feed_storage: &mut PriceFeedStorage,
    feed_info_object: &mut FeedInfoObject,
    update: &Update,
) {
    abort 404
}

public fun update_price_feed(
    source: &Source<PYTH_LAZER>,
    config: &Config,
    price_feed_storage: &mut PriceFeedStorage,
    feed_info_object: &mut FeedInfoObject,
    lazer_state: &State,
    raw_update: vector<u8>,
    clock: &Clock,
) {
    abort 404
}

//******** Mutators [Permissioned] [AuthorityCap<VENDOR<VendorKey>, ADMIN | MAINTENANCE>] ********//

public fun set_twap_period_ms<VendorKey, ADMIN_OR_MAINTENANCE>(
    source: &Source<PYTH_LAZER>,
    authority_cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_MAINTENANCE>,
    config: &Config,
    price_feed_storage: &mut PriceFeedStorage,
    twap_period_ms: u64,
) {
    abort 404
}

//************* Deconstructor [Permissioned] [AuthorityCap<VENDOR<VendorKey>, ADMIN>] ************//

public fun remove_price_feed<VendorKey>(
    source: &Source<PYTH_LAZER>,
    authority_cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN>,
    config: &Config,
    price_feed_storage: &mut PriceFeedStorage,
) {
    abort 404
}

//*********** Deconstructor [Permissioned] [AuthorityCap<PACKAGE, ADMIN | ASSISTANT>] ***********//

public fun force_remove_price_feed<ADMIN_OR_ASSISTANT>(
    source: &Source<PYTH_LAZER>,
    authority_cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    config: &Config,
    price_feed_storage: &mut PriceFeedStorage,
) {
    abort 404
}

//************************************************************************************************//
// Internal Functions                                                                             //
//************************************************************************************************//

use fun feed_for_id as Update.feed_for_id;
fun feed_for_id(
    update: &Update,
    feed_id: u32,
): &Feed {
    abort 404
}

use fun to_ms as u64.to_ms;
fun to_ms(timestamp_us: u64): u64 { abort 404 }
use fun scaled_by_exponent as u64.scaled_by_exponent;
fun scaled_by_exponent(
    magnitude: u64,
    exponent: I16,
): u128 {
    abort 404
}

use fun timestamp_ms as Feed.timestamp_ms;
fun timestamp_ms(
    feed: &Feed,
    update: &Update,
): u64 {
    abort 404
}

use fun price_and_timestamp_ms as FeedInfoObject.price_and_timestamp_ms;
fun price_and_timestamp_ms(
    feed_info_object: &FeedInfoObject,
    update: &Update,
): (u128 /* price */, u64 /* timestamp_ms */) {
    abort 404
}
