// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module ifixed::ifixed;

const ONE: u256  = 1__000_000_000_000_000_000;const NEG_ONE: u256 = 0xffff_ffff_ffff_ffff_ffff_ffff_ffff_ffff_ffff_ffff_ffff_ffff_ffff_ffff_ffff_ffff;
const GREATEST_BIT: u256 = (1 << 255);
const NOT_GREATEST_BIT: u256 = (1 << 255) - 1;
const OVERFLOW_ERROR: u64 = 12001;
const SCALING_FACTORS: vector<u64> = vector<u64>[
    1__000_000_000_000_000_000,
    0__100_000_000_000_000_000,
    0__010_000_000_000_000_000,
    0__001_000_000_000_000_000,
    0__000_100_000_000_000_000,
    0__000_010_000_000_000_000,
    0__000_001_000_000_000_000,
    0__000_000_100_000_000_000,
    0__000_000_010_000_000_000,
    0__000_000_001_000_000_000,
    0__000_000_000_100_000_000,
    0__000_000_000_010_000_000,
    0__000_000_000_001_000_000,
    0__000_000_000_000_100_000,
    0__000_000_000_000_010_000,
    0__000_000_000_000_001_000,
    0__000_000_000_000_000_100,
    0__000_000_000_000_000_010,
    0__000_000_000_000_000_001,
];

#[allow(implicit_const_copy)]
public fun decimal_scalar_from_decimals(decimals: u64): u64 {
    abort 404
}

public fun one(): u256 {
    abort 404
}

public fun neg_one(): u256 {
    abort 404
}

public fun min_value(): u256 {
    abort 404
}

public fun max_value(): u256 {
    abort 404
}

public fun overflow_error(): u64 {
    abort 404
}

public fun is_cast_safe(x: u256): bool {
    abort 404
}

// =========================================================================
//  u64 Conversion Functions
// =========================================================================

public fun from_u64(a: u64): u256 {
    abort 404
}

public fun to_u64(x: u256): u64 {
    abort 404
}

public fun from_u64fraction(numerator: u64, denominator: u64): u256 {
    abort 404
}

// =========================================================================
//  u128 Conversion Functions
// =========================================================================

public fun from_u128(a: u128): u256 {
    abort 404
}

public fun to_u128(x: u256): u128 {
    abort 404
}

public fun from_u128fraction(numerator: u128, denominator: u128): u256 {
    abort 404
}

// =========================================================================
//  U256 Conversion Functions
// =========================================================================

public fun from_u256(x: u256): u256 {
    abort 404
}

public fun to_u256(x: u256): u256 {
    abort 404
}

public fun from_u256fraction(numerator: u256, denominator: u256): u256 {
    abort 404
}

// =========================================================================
//  Balance Conversion Functions
// =========================================================================

public fun from_balance(balance: u64, scaling_factor: u256): u256 {
    abort 404
}

public fun to_balance(x: u256, scaling_factor: u256): u64 {
    abort 404
}

public fun from_u128balance(balance: u128, scaling_factor: u256): u256 {
    abort 404
}

public fun to_u128balance(x: u256, scaling_factor: u256): u128 {
    abort 404
}

public fun from_u256balance(balance: u256, scaling_factor: u256): u256 {
    abort 404
}

public fun to_u256balance(x: u256, scaling_factor: u256): u256 {
    abort 404
}

// =========================================================================
//  Math Functions
// =========================================================================

public fun add(x: u256, y: u256): u256 {
    abort 404
}

public fun sub(x: u256, y: u256): u256 {
    abort 404
}

public fun mul(x: u256, y: u256): u256 {
    abort 404
}

public fun mul_toward_zero(x: u256, y: u256): u256 {
    abort 404
}

public fun mul_up(x: u256, y: u256): u256 {
    abort 404
}

public fun mul_away_from_zero(x: u256, y: u256): u256 {
    abort 404
}

public fun div(x: u256, y: u256): u256 {
    abort 404
}

public fun div_toward_zero(x: u256, y: u256): u256 {
    abort 404
}

public fun div_up(x: u256, y: u256): u256 {
    abort 404
}

public fun div_away_from_zero(x: u256, y: u256): u256 {
    abort 404
}

public fun neg(x: u256): u256 {
    abort 404
}

public fun abs(x: u256): u256 {
    abort 404
}

// =========================================================================
//  Compare Functions
// =========================================================================

public fun max(x: u256, y: u256): u256 {
    abort 404
}

public fun min(x: u256, y: u256): u256 {
    abort 404
}

public fun is_neg(x: u256): bool {
    abort 404
}

public fun same_sign(x: u256, y: u256): bool {
    abort 404
}

public fun diff_sign(x: u256, y: u256): bool {
    abort 404
}

public fun greater_than(x: u256, y: u256): bool {
    abort 404
}

public fun greater_than_eq(x: u256, y: u256): bool {
    abort 404
}

public fun less_than(x: u256, y: u256): bool {
    abort 404
}

public fun less_than_eq(x: u256, y: u256): bool {
    abort 404
}

/**
 * @dev Compares two fixed point numbers for relative error
 */
public fun close_enough(a: u256, b: u256, tolerance: u256): bool {
    abort 404
}

public fun mul_i256(x: u256, y: u256): u256 {
    abort 404
}
