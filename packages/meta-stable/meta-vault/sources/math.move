// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

/// Module: math
module meta_vault::math;

//**************************************************************************************************//
// Constants                                                                                        //
//**************************************************************************************************//

const EXCHANGE_RATE_ONE_TO_ONE: u128 = 1__000_000_000_000_000_000;
const ONE_HUNDRED_PERCENT_BASE_18: u128 = 1__000_000_000_000_000_000;
const ZERO: u64 = 0;

//**************************************************************************************************//
// Errors                                                                                           //
//**************************************************************************************************//

#[error]
const EConversionTooSmall: vector<u8> = b"You are trying to normalize `amount` by a magnitude larger than `amount`.";

#[error]
const EUnreachable: vector<u8> = b"This is supposed to be unreachable -- idk how you ended up here. GL.";

//************************************************************************************************//
// Public Functions                                                                               //
//************************************************************************************************//

public fun exchange_rate_one_to_one(): u128 { abort 404 }
public fun one_hundred_percent_base_18(): u128 { abort 404 }
/// Calculates the amount of `coin_out_amount` that will be taken as a fee. The fee is calculated
/// off of how far the withdraw brings the `Vault`s liquidity of an asset below its desired
/// liquidity threshold of that asset; i.e.,
///               .' min_fee, if end_liquidity >= target_liquidity.
///               |
///  fee_amount = |             / (max_fee - min_fee) * end_liquidity \
///               |  max_fee - |---------------------------------------|, otherwise
///               '.            \          target_liquidity           /
public fun calculate_dynamic_fee(
    coin_out_amount: u64,
    target_liquidity: u64,
    end_liquidity: u64,
    max_fee: u64,
    min_fee: u64,
): u64 /* fee_amount */ {
    abort 404
}

#[allow(dead_code)]
/// Normalizes the `amount` from one decimal precision (`decimals_from`) to another
/// (`decimals_to`); e.g., if `decimals_from` = 6, `decimals_to` = 9, and `amount` = 1_000_000,
/// then it will be normalized to 1_000_000 * 10^9 / 10^6 = 1_000_000_000.
public fun normalize_decimals(
    amount: u64,
    decimals_from: u8,
    decimals_to: u8,
): u64 {
    abort 404
}

use fun multiply_and_divide as u64.multiply_and_divide;
/// Multiply `numerator_2` by the fraction `numerator_2` / `denominator`.
public fun multiply_and_divide(
    numerator_1: u64,
    numerator_2: u128,
    denominator: u128,
): u64 {
    abort 404
}
