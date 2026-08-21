// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module oracle_aggregator::price_feed;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error(code = 0)]
const EPriceFeedAlreadyExists: vector<u8> =
    b"A price feed already exists for the provided source.";

#[error(code = 1)]
const EPriceFeedDoesNotExist: vector<u8> =
    b"A price feed does not exist for the provided source.";

#[error(code = 2)]
const EInvalidTwapPeriodMs: vector<u8> = b"The TWAP period must be greater than zero.";

#[error(code = 3)]
const EInvalidPrice: vector<u8> = b"Price must be non-zero";

//************************************************************************************************//
// PriceFeed                                                                                      //
//************************************************************************************************//

public struct PriceFeed has store, drop {
    source_id: u16,

    from: ID,

    price: u128,

    timestamp_ms: u64,

    twap_price: u128,
    twap_period_ms: u64,
}

//****************************************** Constructor *****************************************//

public(package) fun new(
    source_id: u16,
    from: ID,
    price: u128,
    timestamp_ms: u64,
    twap_period_ms: u64,
): PriceFeed {
    abort 404
}

//******************************************** Getters *******************************************//

public fun source_id(feed: &PriceFeed): u16 {
    abort 404
}

public fun from(feed: &PriceFeed): ID {
    abort 404
}

public fun price(feed: &PriceFeed): u128 {
    abort 404
}

public fun timestamp_ms(feed: &PriceFeed): u64 {
    abort 404
}

public fun price_and_timestamp_ms(feed: &PriceFeed): (u128, u64) {
    abort 404
}

public fun twap_price(feed: &PriceFeed): u128 {
    abort 404
}

public fun twap_period_ms(feed: &PriceFeed): u64 {
    abort 404
}

public(package) fun as_parts(feed: &PriceFeed): (
    u128, /* price */
    u64,  /* timestamp_ms */
    u128, /* twap_price */
    u64,  /* twap_period_ms */
) {
    abort 404
}

public(package) fun price_timestamp_ms_twap_price(feed: &PriceFeed): (
    u128, /* price */
    u64,  /* timestamp_ms */
    u128, /* twap_price */
) {
    abort 404
}

public(package) fun borrow_feed(feeds: &vector<PriceFeed>, source_id: u16): &PriceFeed {
    abort 404
}

public(package) fun borrow_feed_mut(
    feeds: &mut vector<PriceFeed>,
    source_id: u16,
): &mut PriceFeed {
    abort 404
}

public(package) fun binary_search(feeds: &vector<PriceFeed>, source_id: u16): (bool, u64) {
    abort 404
}

public(package) fun contains(feeds: &vector<PriceFeed>, source_id: u16): bool {
    abort 404
}

public(package) fun add_feed(
    feeds: &mut vector<PriceFeed>,
    source_id: u16,
    from: ID,
    price: u128,
    timestamp_ms: u64,
    twap_period_ms: u64,
) {
    abort 404
}

public(package) fun remove_feed(feeds: &mut vector<PriceFeed>, source_id: u16) {
    abort 404
}

//******************************************* Mutators *******************************************//

public(package) fun maybe_set_price(
    price_feed: &mut PriceFeed,
    price: u128,
    timestamp_ms: u64,
): bool {
    abort 404
}

public(package) fun set_feed_twap_period_ms(
    price_feed: &mut PriceFeed,
    twap_period_ms: u64,
): u64 {
    abort 404
}

public(package) fun update_twap(
    price_now: u128,
    last_twap: u128,
    time_now_ms: u64,
    last_timestamp_ms: u64,
    twap_period_ms: u64,
): u128 {
    abort 404
}
