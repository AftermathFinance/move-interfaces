// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module oracle_aggregator_pyth_integration::price_feed_storage;

use oracle_aggregator_pyth_integration::source::PYTH;

use oracle_aggregator::authority::{PACKAGE, VENDOR};
use oracle_aggregator::price_feed_storage::PriceFeedStorage;
use oracle_aggregator::config::Config;
use oracle_aggregator::source::Source;

use authority_cap::authority::{AuthorityCap, ADMIN};

use pyth::price_info::PriceInfoObject as PythPriceInfo;
use pyth::price::Price;
use pyth::i64::I64;
use pyth::pyth;

use fun oracle_aggregator_pyth_integration::source::source_cap as Source.source_cap;
use fun oracle_aggregator_pyth_integration::source::assert_version as Source.assert_version;
use fun pyth::get_price_unsafe as PythPriceInfo.get_price;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error(code = 0)]
const EUnsupportedExponent: vector<u8> =
    b"Pyth integration: the feed's exponent is too large for the price to be representable.";

#[error(code = 1)]
const EPriceOverflow: vector<u8> =
    b"Pyth integration: the normalized price does not fit into a u128.";

//************************************************************************************************//
// PriceFeedStorage                                                                               //
//************************************************************************************************//

//******** Constructor [Permissioned] [AuthorityCap<VENDOR<VendorKey>, ADMIN | ASSISTANT>] *******//

public fun new_price_feed<VendorKey, ADMIN_OR_ASSISTANT>(
    source: &Source<PYTH>,
    cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_ASSISTANT>,
    config: &Config,
    price_feed_storage: &mut PriceFeedStorage,
    pyth_price_info: &PythPriceInfo,
    twap_period_ms: u64,
) {
    abort 404
}

//******************************************* Mutators *******************************************//

public fun update_price_feed(
    source: &Source<PYTH>,
    config: &Config,
    price_feed_storage: &mut PriceFeedStorage,
    pyth_price_info: &PythPriceInfo,
) {
    abort 404
}

//******** Mutators [Permissioned] [AuthorityCap<VENDOR<VendorKey>, ADMIN | MAINTENANCE>] ********//

public fun set_twap_period_ms<VendorKey, ADMIN_OR_MAINTENANCE>(
    source: &Source<PYTH>,
    authority_cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN_OR_MAINTENANCE>,
    config: &Config,
    price_feed_storage: &mut PriceFeedStorage,
    twap_period_ms: u64,
) {
    abort 404
}

//************* Deconstructor [Permissioned] [AuthorityCap<VENDOR<VendorKey>, ADMIN>] ************//

public fun remove_price_feed<VendorKey>(
    source: &Source<PYTH>,
    authority_cap: &AuthorityCap<VENDOR<VendorKey>, ADMIN>,
    config: &Config,
    price_feed_storage: &mut PriceFeedStorage,
) {
    abort 404
}

//*********** Deconstructor [Permissioned] [AuthorityCap<PACKAGE, ADMIN | ASSISTANT>] ***********//

public fun force_remove_price_feed<ADMIN_OR_ASSISTANT>(
    source: &Source<PYTH>,
    authority_cap: &AuthorityCap<PACKAGE, ADMIN_OR_ASSISTANT>,
    config: &Config,
    price_feed_storage: &mut PriceFeedStorage,
) {
    abort 404
}

public(package) fun scaled_by_exponent(
    magnitude: u64,
    exponent: I64,
): u128 {
    abort 404
}
