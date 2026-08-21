// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: BUSL-1.1

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module ordered_map::ordered_map;

use sui::dynamic_field as df;
use ordered_map::enum_option::{Self, Option};

const LEAF_FLAG: u64 = 0x8000_0000_0000_0000;

#[error(code = 0x80)]
const EInvalidMapParameters: vector<u8> = b"Invalid map parameters";
#[error(code = 0x81)]
const EKeyNotExist: vector<u8> = b"Key does not exist in the map";
#[error(code = 0x82)]
const EKeyAlreadyExists: vector<u8> = b"Key already exists in the map";
#[error(code = 0x83)]
const EDestroyNotEmpty: vector<u8> = b"Cannot destroy a non-empty map";
#[error(code = 0x84)]
const EMapTooSmall: vector<u8> = b"Map must have more than 3 entries to change parameters";

// -----------------------------------------------------------------------------
//      Module Structs
// -----------------------------------------------------------------------------

public struct Map<phantom V> has key, store {
    id: UID,
    size: u64,
    counter: u64,
    root: u64,
    first: u64,
    branch_min: u64,
    branches_merge_max: u64,
    branch_max: u64,
    leaf_min: u64,
    leaves_merge_max: u64,
    leaf_max: u64,
}

public struct Branch has drop, store {
    keys: vector<u128>,
    kids: vector<u64>,
}

public struct Pair<V> has copy, drop, store {
    key: u128,
    val: V,
}

public struct Leaf<V> has drop, store {
    keys_vals: vector<Pair<V>>,
    next: u64,
}

// -----------------------------------------------------------------------------
//      Public Functions
// -----------------------------------------------------------------------------

public fun empty<V: store>(
    branch_min: u64,
    branches_merge_max: u64,
    branch_max: u64,
    leaf_min: u64,
    leaves_merge_max: u64,
    leaf_max: u64,
    ctx: &mut TxContext,
): Map<V> {
    abort 404
}

public fun destroy_empty<V: store>(map: Map<V>) {
    abort 404
}

public fun drop<V: drop + store>(mut map: Map<V>) {
    abort 404
}

public fun is_empty<V>(map: &Map<V>): bool {
    abort 404
}

public fun map_size<V>(map: &Map<V>): u64 {
    abort 404
}

public use fun map_size as Map.size;

public fun change_params<V>(
    map: &mut Map<V>,
    branch_min: u64,
    branches_merge_max: u64,
    branch_max: u64,
    leaf_min: u64,
    leaves_merge_max: u64,
    leaf_max: u64,
) {
    abort 404
}

public fun min_key<V: store>(map: &Map<V>): u128 {
    abort 404
}

public fun first_leaf_ptr<V>(map: &Map<V>): u64 {
    abort 404
}

public fun get_leaf<V: store>(map: &Map<V>, leaf_ptr: u64): &Leaf<V> {
    abort 404
}

public fun get_leaf_mut<V: store>(map: &mut Map<V>, leaf_ptr: u64): &mut Leaf<V> {
    abort 404
}

public fun size<V>(leaf: &Leaf<V>): u64 {
    abort 404
}

public fun elem<V>(leaf: &Leaf<V>, index: u64): (u128, &V) {
    abort 404
}

public fun elem_mut<V>(leaf: &mut Leaf<V>, index: u64): (u128, &mut V) {
    abort 404
}

public fun next<V>(leaf: &Leaf<V>): u64 {
    abort 404
}

public fun find_index<V>(leaf: &Leaf<V>, key: u128): u64 {
    abort 404
}

public fun find_leaf<V>(map: &Map<V>, key: u128): u64 {
    abort 404
}

public fun has_key<V: store>(map: &Map<V>, key: u128): bool {
    abort 404
}

#[syntax(index)]
public fun borrow<V: store>(map: &Map<V>, key: u128): &V {
    abort 404
}

#[syntax(index)]
public fun borrow_mut<V: store>(map: &mut Map<V>, key: u128): &mut V {
    abort 404
}

public fun insert<V: store>(map: &mut Map<V>, key: u128, val: V) {
    abort 404
}

public fun remove<V: copy + drop + store>(map: &mut Map<V>, key: u128): V {
    abort 404
}

public fun try_remove<V: copy + drop + store>(map: &mut Map<V>, key: u128): Option<V> {
    abort 404
}

public fun clear<V: drop + store>(map: &mut Map<V>) {
    abort 404
}

public fun batch_drop<V: copy + drop + store>(
    map: &mut Map<V>, mut key: u128, inclusive: bool
) {
    abort 404
}

// -----------------------------------------------------------------------------
//      Private Functions
// -----------------------------------------------------------------------------

fun check_map_params(
    branch_min: u64,
    branches_merge_max: u64,
    branch_max: u64,
    leaf_min: u64,
    leaves_merge_max: u64,
    leaf_max: u64,
) {
    abort 404
}

fun clear_leaf<V: drop + store>(map: &mut Map<V>, leaf_ptr: u64) {
    abort 404
}

fun split_leaf<V>(
    leaf: &mut Leaf<V>,
    counter: &mut u64,
    len: u64
): (u64, u128, Leaf<V>) {
    abort 404
}

fun insert_into_leaf<V>(leaf: &mut Leaf<V>, key: u128, val: V): u64 {
    abort 404
}

fun split_branch(
    branch: &mut Branch,
    counter: &mut u64,
    len: u64
): (u64, u128, Branch) {
    abort 404
}

fun remove_from_branch<V: copy + drop + store>(map: &mut Map<V>, branch_ptr: u64, key: u128): (V, u64) {
    abort 404
}

fun try_remove_from_branch<V: copy + drop + store>(map: &mut Map<V>, branch_ptr: u64, key: u128): (Option<V>, u64) {
    abort 404
}

fun migrate_to_left_branch<V>(
    map: &mut Map<V>,
    left: u64,
    left_len: u64,
    separating_key: u128,
    right: u64
): u128 {
    abort 404
}

fun migrate_to_right_branch<V>(
    map: &mut Map<V>,
    left: u64,
    separating_key: u128,
    right: u64,
    right_len: u64
): u128 {
    abort 404
}

fun merge_branches<V>(map: &mut Map<V>, left: u64, separating_key: u128, right: u64) {
    abort 404
}

fun update_after_migration<V>(
    map: &mut Map<V>,
    branch_ptr: u64,
    branch_len: &mut u64,
    left_index: u64,
    separating_key: u128,
    right_index: u64
) {
    abort 404
}

fun update_after_migration_last<V>(
    map: &mut Map<V>,
    branch_ptr: u64,
    branch_len: &mut u64,
    left_index: u64,
    separating_key: u128
) {
    abort 404
}

fun remove_from_leaf<V: store>(
    map: &mut Map<V>,
    leaf_ptr: u64,
    key: u128
): (V, u64) {
    abort 404
}

fun try_remove_from_leaf<V: store>(
    map: &mut Map<V>,
    leaf_ptr: u64,
    key: u128
): (Option<V>, u64) {
    abort 404
}

fun migrate_to_left_leaf<V: copy + drop + store>(
    map: &mut Map<V>,
    left: u64,
    left_len: u64,
    right: u64
): u128 {
    abort 404
}

fun migrate_to_right_leaf<V: copy + drop + store>(map: &mut Map<V>, left: u64, right: u64, right_len: u64): u128 {
    abort 404
}

fun merge_leaves<V: copy + drop + store>(map: &mut Map<V>, left: u64, right: u64) {
    abort 404
}

fun batch_drop_from_root<V: copy + drop + store>(map: &mut Map<V>, key: u128) {
    abort 404
}

fun batch_drop_from_branch<V: copy + drop + store>(
    map: &mut Map<V>, branch_ptr: u64, mut branch_separating_key: u128, neighbor: u64, key: u128
): u128 {
    abort 404
}

fun drop_kids<V: drop + store>(
    map: &mut Map<V>,
    mut drop_count: u64,
    kids_are_branches: bool,
    mut rev_branch_kids: vector<u64>,
) {
    abort 404
}

fun migrate_to_left_branch1<V>(
    map: &mut Map<V>, left: u64, left_len: u64, separating_key: u128, right: u64
): (u128, u128, u64) {
    abort 404
}

fun batch_drop_from_leaf<V: copy + drop + store>(map: &mut Map<V>, leaf_ptr: u64, key: u128): u64 {
    abort 404
}

fun drop_branch<V: drop + store>(map: &mut Map<V>, branch_ptr: u64) {
    abort 404
}

fun drop_first_leaves<V: drop + store>(map: &mut Map<V>, mut count: u64) {
    abort 404
}

fun increase_counter(counter: &mut u64): u64 {
    abort 404
}

// -----------------------------------------------------------------------------
//      Additional Functions For Vectors
// -----------------------------------------------------------------------------

public fun reverse<V>(vec: &mut vector<V>) {
    abort 404
}

public fun remove_at<V>(vec: &mut vector<V>, index: u64): V {
    abort 404
}

fun last<V>(vec: &vector<V>): &V {
    abort 404
}

fun binary_search(vec: &vector<u128>, mut r: u64, key: u128): u64 {
    abort 404
}

fun binary_search_p<V>(vec: &vector<Pair<V>>, mut r: u64, key: u128): u64 {
    abort 404
}

fun binary_search_rightmost<V>(vec: &vector<Pair<V>>, mut r: u64, key: u128): u64 {
    abort 404
}

fun copy_slice<V: copy>(vec: &vector<V>, mut from: u64, to: u64): vector<V> {
    abort 404
}

fun cut_reversed_right<V>(vec: &mut vector<V>, mut count: u64): vector<V> {
    abort 404
}

fun cut_right<V>(vec: &mut vector<V>, count: u64): vector<V> {
    abort 404
}

fun append_reversed_right<V>(left: &mut vector<V>, mut reversed_right: vector<V>) {
    abort 404
}

fun append_right<V: copy>(left: &mut vector<V>, right: &vector<V>) {
    abort 404
}

fun cut_reversed_left<V: copy + drop>(vec: &mut vector<V>, count: u64): vector<V> {
    abort 404
}

fun cut_reversed_left1<V: copy + drop>(vec: &mut vector<V>, count: u64): (V, vector<V>) {
    abort 404
}

fun append_left<V>(left: vector<V>, right: &mut vector<V>) {
    abort 404
}

fun drop_right<V: drop>(vec: &mut vector<V>, mut count: u64) {
    abort 404
}

fun drop_left<V: copy + drop>(vec: &mut vector<V>, count: u64) {
    abort 404
}

fun drop_first<V: drop>(vec: &mut vector<V>) {
    abort 404
}

fun drop_second<V: drop>(vec: &mut vector<V>) {
    abort 404
}
