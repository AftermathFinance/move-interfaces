// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: BUSL-1.1

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module perpetuals::orderbook;

use perpetuals::account::IntegratorInfo;
use perpetuals::constants;
use perpetuals::order_id;
use perpetuals::keys;

use ordered_map::ordered_map::{Self as map, Map};
use ordered_map::enum_option as enum_option;

use ifixed::ifixed;

use sui::dynamic_object_field as dof;

use std::option::{Self, Option};

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//
// Error code range: 3000-3899.

macro fun invalid_user_for_order(): u64 { 3000 }

macro fun invalid_map_params(): u64 { 3001 }

//************************************************************************************************//
// Order                                                                                          //
//************************************************************************************************//

public struct Order has copy, drop, store {
    account_id: u64,
    size: u64,
    reduce_only: bool,
    expiration_timestamp_ms: Option<u64>,
    integrator_info: Option<IntegratorInfo>,
    client_order_id: Option<u64>,
}

//******************************************** Getters *******************************************//

public fun as_parts(order: &Order): (
    u64,
    u64,
    bool,
    Option<u64>,
    Option<u64>,
    Option<IntegratorInfo>,
) {
    abort 404
}

//************************************************************************************************//
// OrderBook                                                                                      //
//************************************************************************************************//

public struct Orderbook has key, store {
    id: UID,
    counter: u64,
    best_ask_price: Option<u64>,
    best_bid_price: Option<u64>,
}

//****************************************** Constructor *****************************************//

public(package) fun create_orderbook(
    branch_min: u64,
    branches_merge_max: u64,
    branch_max: u64,
    leaf_min: u64,
    leaves_merge_max: u64,
    leaf_max: u64,
    ctx: &mut TxContext,
): Orderbook {
    abort 404
}

//******************************************** Getters *******************************************//

public fun book_price(book: &Orderbook): Option<u64> {
    abort 404
}

public fun best_price(book: &Orderbook, side: bool): Option<u64> {
    abort 404
}

public fun book_price_or_index(orderbook: &Orderbook, index_price: u256): u256 {
    abort 404
}

public fun order_size(book: &Orderbook, order_id: u128): u64 {
    abort 404
}

public fun get_order(book: &Orderbook, order_id: u128): Option<Order> {
    abort 404
}

public(package) fun asks(self: &Orderbook): &Map<Order> {
    abort 404
}

public(package) fun borrow_mut_asks(self: &mut Orderbook): &mut Map<Order> {
    abort 404
}

public(package) fun bids(self: &Orderbook): &Map<Order> {
    abort 404
}

public(package) fun borrow_mut_bids(self: &mut Orderbook): &mut Map<Order> {
    abort 404
}

public(package) fun order_snapshot(
    order: &Order
): (u64, Option<u64>, u64, bool, Option<u64>, Option<IntegratorInfo>) {
    abort 404
}

public fun inspect_orders(
    orderbook: &Orderbook,
    side: bool,
    price_from: u64,
    price_to: u64,
    mut limit: u64,
): (
    vector<u128>,
    vector<Order>,
) {
    abort 404
}
//******************************************* Mutators *******************************************//

public(package) fun cancel_limit_order(
    orderbook: &mut Orderbook,
    account_id: u64,
    order_id: u128
): (u64, Option<u64>) {
    abort 404
}

public(package) fun try_cancel_limit_order(
    orderbook: &mut Orderbook,
    account_id: u64,
    order_id: u128
): (bool, u64, Option<u64>) {
    abort 404
}

public(package) fun try_cancel_stale_limit_order(
    orderbook: &mut Orderbook,
    account_id: u64,
    order_id: u128,
    timestamp_ms: u64,
    account_base: u256,
): (bool, bool, u64, Option<u64>) {
    abort 404
}

public(package) fun post_order(
    orderbook: &mut Orderbook,
    account_id: u64,
    side: bool,
    size: u64,
    price: u64,
    client_order_id: Option<u64>,
    reduce_only: bool,
    expiration_timestamp_ms: Option<u64>,
    integrator_info: Option<IntegratorInfo>,
): u128 {
    abort 404
}

public(package) fun reduce_order_size(
    order: &mut Order,
    size_to_reduce: u64,
) {
    abort 404
}

public(package) fun set_best_price(
    orderbook: &mut Orderbook,
    side: bool,
    best_price: Option<u64>,
) {
    abort 404
}

fun increase_counter(counter: &mut u64): u64 {
    abort 404
}
