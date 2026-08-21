// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module oracle_aggregator_stork_integration::price_feed_storage;

use oracle_aggregator_stork_integration::source::STORK;
use oracle_aggregator_stork_integration::feed_info_object::FeedInfoObject;

use oracle_aggregator::price_feed_storage::PriceFeedStorage;
use oracle_aggregator::authority::{PACKAGE, VENDOR};
use oracle_aggregator::config::Config;
use oracle_aggregator::source::Source;

use authority_cap::authority::{AuthorityCap, ADMIN};

use stork::temporal_numeric_value::TemporalNumericValue;
use stork::state::StorkState;

use fun oracle_aggregator_stork_integration::source::source_cap as Source.source_cap;
use fun oracle_aggregator_stork_integration::source::assert_version as Source.assert_version;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error(code = 0)]
const EPriceIsNegative: vector<u8> = b"Stork integration: the price cannot be negative.";

//************************************************************************************************//
// PriceFeedStorage                                                                               //
//************************************************************************************************//

//******** Constructor [Permissioned] [AuthorityCap<VENDOR<VendorKey>, ADMIN | ASSISTANT>] *******//

public fun new_price_feed<VendorKey, ADMIN_OR_ASSISTANT>(
    source: &Source<STORK>,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    config: &Config,
    price_feed_storage: &mut PriceFeedStorage,
    stork_state: &StorkState,
    feed_info_object: &FeedInfoObject,
    twap_period_ms: u64,
) {
    abort 404
}

//******************************************* Mutators *******************************************//

public fun update_price_feed(
    source: &Source<STORK>,
    config: &Config,
    price_feed_storage: &mut PriceFeedStorage,
    stork_state: &StorkState,
    feed_info_object: &FeedInfoObject,
) {
    abort 404
}

//******** Mutators [Permissioned] [AuthorityCap<VENDOR<VendorKey>, ADMIN | MAINTENANCE>] ********//

public fun set_twap_period_ms<VendorKey, ADMIN_OR_MAINTENANCE>(
    source: &Source<STORK>,
    authority_cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_MAINTENANCE>,
    config: &Config,
    price_feed_storage: &mut PriceFeedStorage,
    twap_period_ms: u64,
) {
    abort 404
}

//************* Deconstructor [Permissioned] [AuthorityCap<VENDOR<VendorKey>, ADMIN>] ************//

public fun remove_price_feed<VendorKey>(
    source: &Source<STORK>,
    authority_cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN>,
    config: &Config,
    price_feed_storage: &mut PriceFeedStorage,
) {
    abort 404
}

//*********** Deconstructor [Permissioned] [AuthorityCap<PACKAGE, ADMIN | ASSISTANT>] ***********//

public fun force_remove_price_feed<ADMIN_OR_ASSISTANT>(
    source: &Source<STORK>,
    authority_cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    config: &Config,
    price_feed_storage: &mut PriceFeedStorage,
) {
    abort 404
}

//************************************************************************************************//
// Internal Functions                                                                             //
//************************************************************************************************//

use fun stork::stork::get_temporal_numeric_value_unchecked
    as StorkState.temporal_numeric_value_unchecked;
