// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: BUSL-1.1

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module perpetuals::adl;
use perpetuals::clearing_house::{Self, ClearingHouse};
use perpetuals::authority::{PACKAGE, ADL};
use perpetuals::registry::Registry;
use perpetuals::constants;
use perpetuals::events;
use position::position::Position;

use oracle_aggregator::price_feed_storage::PriceFeedStorage;

use authority_cap::authority::AuthorityCap;

use ifixed::ifixed;

use sui::clock::Clock;

use std::option;

use fun perpetuals::clearing_house::settle_position_funding_and_emit as Position.settle_position_funding_and_emit;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//
// Error code range: 6000-6099.

macro fun size_not_multiple_of_lot_size(): u64 { 6000 }

macro fun adl_counterparties_mismatch(): u64 { 6001 }

macro fun adl_counterparty_insufficient(): u64 { 6002 }

macro fun adl_bad_debt_position_not_closed(): u64 { 6003 }

macro fun adl_weights_do_not_sum_to_one(): u64 { 6004 }

//************************************************************************************************//
// Public Functions                                                                               //
//************************************************************************************************//

public fun execute_adl<T>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<PACKAGE, ADL>,
    registry: &Registry,
    bad_debt_account_id: u64,
    bad_debt_open_orders: vector<u128>,
    counterparty_account_ids: vector<u64>,
    sizes_reduced: vector<u64>,
    collateral_distribution: vector<u64>,
    base_oracle: &PriceFeedStorage,
    collateral_oracle: &PriceFeedStorage,
    clock: &Clock,
) {
    abort 404
}

public fun execute_closed_market_adl<T>(
    clearing_house: &mut ClearingHouse<T>,
    cap: &AuthorityCap<PACKAGE, ADL>,
    registry: &Registry,
    bad_debt_account_id: u64,
    bad_debt_open_orders: vector<u128>,
    counterparty_account_ids: vector<u64>,
    sizes_reduced: vector<u64>,
    collateral_distribution: vector<u64>,
) {
    abort 404
}

fun execute_adl_<T>(
    clearing_house: &mut ClearingHouse<T>,
    bad_debt_account_id: u64,
    bad_debt_open_orders: vector<u128>,
    counterparty_account_ids: vector<u64>,
    sizes_reduced: vector<u64>,
    collateral_distribution: vector<u64>,
    mark_price: u256,
    collateral_price: u256,
) {
    abort 404
}
