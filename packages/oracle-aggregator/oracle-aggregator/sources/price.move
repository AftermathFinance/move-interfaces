// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module oracle_aggregator::price;

use oracle_aggregator::price_feed_storage::PriceFeedStorage;
use oracle_aggregator::config::Config;

use sui::clock::Clock;

use std::u64::{min, max};

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error(code = 0)]
const ENoSources: vector<u8> = b"There are no source feeds to query.";

#[error(code = 1)]
const ENoValidPrices: vector<u8> = b"There are no valid prices to query.";

#[error(code = 2)]
const ETooManyPriceFeedsForMedian: vector<u8> =
    b"Median price calculation supports at most three price feeds.";

//************************************************************************************************//
// PriceFeedStorage                                                                               //
//************************************************************************************************//

//******************************************** Getters *******************************************//

public fun valid_prices_from_sources(
    price_feed_storage: &PriceFeedStorage,
    config: &Config,
    source_ids: vector<u16>,
    staleness_threshold_ms: u64,
    may_abort: bool,
    clock: &Clock,
): vector<u128> {
    abort 404
}

public fun valid_twap_prices_from_sources(
    price_feed_storage: &PriceFeedStorage,
    config: &Config,
    source_ids: vector<u16>,
    staleness_threshold_ms: u64,
    may_abort: bool,
    clock: &Clock,
): vector<u128> {
    abort 404
}

public fun valid_prices_and_twap_prices_from_sources(
    price_feed_storage: &PriceFeedStorage,
    config: &Config,
    source_ids: vector<u16>,
    staleness_threshold_ms: u64,
    may_abort: bool,
    clock: &Clock,
): (vector<u128>, vector<u128>) {
    abort 404
}

public fun newest_price_from_sources_(
    price_feed_storage: &PriceFeedStorage,
    config: &Config,
    source_ids: vector<u16>,
    staleness_threshold_ms: u64,
    may_abort: bool,
    clock: &Clock,
): u128 {
    abort 404
}

public fun newest_twap_price_from_sources_(
    price_feed_storage: &PriceFeedStorage,
    config: &Config,
    source_ids: vector<u16>,
    staleness_threshold_ms: u64,
    may_abort: bool,
    clock: &Clock,
): u128 {
    abort 404
}

public fun newest_price_and_twap_price_from_sources_(
    price_feed_storage: &PriceFeedStorage,
    config: &Config,
    source_ids: vector<u16>,
    staleness_threshold_ms: u64,
    may_abort: bool,
    clock: &Clock,
): (u128, u128) {
    abort 404
}

public fun median_price_from_sources_(
    price_feed_storage: &PriceFeedStorage,
    config: &Config,
    source_ids: vector<u16>,
    staleness_threshold_ms: u64,
    clock: &Clock,
): u128 {
    abort 404
}

public fun median_twap_price_from_sources_(
    price_feed_storage: &PriceFeedStorage,
    config: &Config,
    source_ids: vector<u16>,
    staleness_threshold_ms: u64,
    clock: &Clock,
): u128 {
    abort 404
}

public fun median_price_and_twap_price_from_sources_(
    price_feed_storage: &PriceFeedStorage,
    config: &Config,
    source_ids: vector<u16>,
    staleness_threshold_ms: u64,
    clock: &Clock,
): (u128, u128) {
    abort 404
}

public fun average_twap_price_from_sources_(
    price_feed_storage: &PriceFeedStorage,
    config: &Config,
    source_ids: vector<u16>,
    staleness_threshold_ms: u64,
    may_abort: bool,
    clock: &Clock,
): u128 {
    abort 404
}

public fun average_price_and_twap_price_from_sources_(
    price_feed_storage: &PriceFeedStorage,
    config: &Config,
    source_ids: vector<u16>,
    staleness_threshold_ms: u64,
    may_abort: bool,
    clock: &Clock,
): (u128, u128) {
    abort 404
}

public fun average_reciprocal_twap_price_from_sources_(
    price_feed_storage: &PriceFeedStorage,
    config: &Config,
    source_ids: vector<u16>,
    staleness_threshold_ms: u64,
    may_abort: bool,
    clock: &Clock,
): u128 {
    abort 404
}

public fun average_reciprocal_price_and_twap_price_from_sources_(
    price_feed_storage: &PriceFeedStorage,
    config: &Config,
    source_ids: vector<u16>,
    staleness_threshold_ms: u64,
    may_abort: bool,
    clock: &Clock,
): (u128, u128) {
    abort 404
}

//******************************** All-feeds aggregation cores ***********************************//

public fun valid_prices_(
    price_feed_storage: &PriceFeedStorage,
    config: &Config,
    staleness_threshold_ms: u64,
    may_abort: bool,
    clock: &Clock,
): vector<u128> {
    abort 404
}

public fun valid_twap_prices_(
    price_feed_storage: &PriceFeedStorage,
    config: &Config,
    staleness_threshold_ms: u64,
    may_abort: bool,
    clock: &Clock,
): vector<u128> {
    abort 404
}

public fun valid_prices_and_twap_prices_(
    price_feed_storage: &PriceFeedStorage,
    config: &Config,
    staleness_threshold_ms: u64,
    may_abort: bool,
    clock: &Clock,
): (vector<u128>, vector<u128>) {
    abort 404
}

public fun newest_price_(
    price_feed_storage: &PriceFeedStorage,
    config: &Config,
    staleness_threshold_ms: u64,
    may_abort: bool,
    clock: &Clock,
): u128 {
    abort 404
}

public fun newest_twap_price_(
    price_feed_storage: &PriceFeedStorage,
    config: &Config,
    staleness_threshold_ms: u64,
    may_abort: bool,
    clock: &Clock,
): u128 {
    abort 404
}

public fun newest_price_and_twap_price_(
    price_feed_storage: &PriceFeedStorage,
    config: &Config,
    staleness_threshold_ms: u64,
    may_abort: bool,
    clock: &Clock,
): (u128, u128) {
    abort 404
}

public fun median_of(prices: vector<u128>): u128 {
    abort 404
}
