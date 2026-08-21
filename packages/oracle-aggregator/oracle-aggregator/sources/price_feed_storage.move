// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module oracle_aggregator::price_feed_storage;

use oracle_aggregator::authority::{Self, PACKAGE, VENDOR, SourceCap};
use oracle_aggregator::config::Config;
use oracle_aggregator::events;
use oracle_aggregator::price_feed::{Self, PriceFeed};

use authority_cap::authority::{AuthorityCap, ADMIN};

use sui::derived_object;

use std::string::String;

public use fun oracle_aggregator::price::valid_prices_from_sources
    as PriceFeedStorage.valid_prices_from_sources;
public use fun oracle_aggregator::price::valid_twap_prices_from_sources
    as PriceFeedStorage.valid_twap_prices_from_sources;
public use fun oracle_aggregator::price::valid_prices_and_twap_prices_from_sources
    as PriceFeedStorage.valid_prices_and_twap_prices_from_sources;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error(code = 0)]
const EInvalidSourceObjectForFeed: vector<u8> =
    b"The provided source object is not authorized to update this feed.";

#[error(code = 1)]
const ESourceNotAuthorized: vector<u8> =
    b"The source is not authorized to write price feeds.";

//************************************************************************************************//
// PriceFeedStorageKey                                                                            //
//************************************************************************************************//

public struct PriceFeedStorageKey(u32) has copy, drop, store;

//************************************************************************************************//
// PriceFeedStorage                                                                               //
//************************************************************************************************//

public struct PriceFeedStorage has key, store {
    id: UID,
    storage_id: u32,
    symbol: String,
    feeds: vector<PriceFeed>,
}

//******** Constructor [Permissioned] [AuthorityCap<VENDOR<VendorKey>, ADMIN | ASSISTANT>] *******//

public fun new<VendorKey, ADMIN_OR_ASSISTANT>(
    config: &mut Config,
    authority_cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    symbol: String,
): PriceFeedStorage {
    abort 404
}

//******************************************** Getters *******************************************//

public fun derived_id(
    config: &Config,
    storage_id: u32,
): ID {
    abort 404
}

public fun storage_id(price_feed_storage: &PriceFeedStorage): u32 {
    abort 404
}

public fun symbol(price_feed_storage: &PriceFeedStorage): String {
    abort 404
}

public fun sources(price_feed_storage: &PriceFeedStorage): vector<u16> {
    abort 404
}

public fun feeds(price_feed_storage: &PriceFeedStorage): &vector<PriceFeed> {
    abort 404
}

public fun size(price_feed_storage: &PriceFeedStorage): u64 {
    abort 404
}

public fun contains(
    price_feed_storage: &PriceFeedStorage,
    source_id: u16,
): bool {
    abort 404
}

public fun any_source(price_feed_storage: &PriceFeedStorage): bool {
    abort 404
}

public fun has_vendor_authorization<VendorKey>(
    price_feed_storage: &PriceFeedStorage,
): bool {
    abort 404
}

public fun assert_has_vendor_authorization<VendorKey>(
    price_feed_storage: &PriceFeedStorage,
) {
    abort 404
}

#[syntax(index)]
public fun price_feed(
    price_feed_storage: &PriceFeedStorage,
    source_id: u16,
): &PriceFeed {
    abort 404
}

#[syntax(index)]
fun price_feed_mut(
    price_feed_storage: &mut PriceFeedStorage,
    source_id: u16,
): &mut PriceFeed {
    abort 404
}

//********* Mutators [Permissioned] [AuthorityCap<VENDOR<VendorKey>, ADMIN | ASSISTANT>] *********//

public fun new_price_feed<VendorKey, ADMIN_OR_ASSISTANT, PriceObject: key>(
    price_feed_storage: &mut PriceFeedStorage,
    authority_cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    config: &Config,
    source_cap: &SourceCap,
    price_object: &PriceObject,
    price: u128,
    timestamp_ms: u64,
    twap_period_ms: u64,
) {
    abort 404
}

//*************** Mutators [Permissioned] [AuthorityCap<VENDOR<VendorKey>, ADMIN>] ***************//

public fun remove_price_feed<VendorKey>(
    price_feed_storage: &mut PriceFeedStorage,
    authority_cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN>,
    config: &Config,
    source_cap: &SourceCap,
) {
    abort 404
}

//*************** Mutators [Permissioned] [AuthorityCap<PACKAGE, ADMIN | ASSISTANT>] *************//

public fun force_remove_price_feed<ADMIN_OR_ASSISTANT>(
    price_feed_storage: &mut PriceFeedStorage,
    authority_cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    config: &Config,
    source_id: u16,
) {
    abort 404
}

//******** Mutators [Permissioned] [AuthorityCap<VENDOR<VendorKey>, ADMIN | MAINTENANCE>] ********//

entry fun set_symbol<VendorKey, ADMIN_OR_MAINTENANCE>(
    price_feed_storage: &mut PriceFeedStorage,
    authority_cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_MAINTENANCE>,
    config: &Config,
    symbol: String
) {
    abort 404
}

public fun set_twap_period_ms<VendorKey, ADMIN_OR_MAINTENANCE>(
    price_feed_storage: &mut PriceFeedStorage,
    authority_cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_MAINTENANCE>,
    config: &Config,
    source_id: u16,
    twap_period_ms: u64,
) {
    abort 404
}

//********************************* Mutators [Permissioned] [UID] ********************************//

public fun update_price_feed<PriceObject: key>(
    price_feed_storage: &mut PriceFeedStorage,
    config: &Config,
    source_cap: &SourceCap,
    price_object: &PriceObject,
    price: u128,
    timestamp_ms: u64,
) {
    abort 404
}

//************************************************************************************************//
// Public Functions                                                                               //
//************************************************************************************************//

#[allow(lint(share_owned))]
public fun share_vec(price_feed_storages: vector<PriceFeedStorage>) {
    abort 404
}

//************************************************************************************************//
// Internal Functions                                                                             //
//************************************************************************************************//

fun remove_price_feed_(
    price_feed_storage: &mut PriceFeedStorage,
    source_id: u16,
) {
    abort 404
}
