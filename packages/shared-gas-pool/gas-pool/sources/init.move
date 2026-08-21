// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: BUSL-1.1

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module shared_gas_pool::init;

use shared_gas_pool::authority;
use shared_gas_pool::config;

use sui::package;

//************************************************************************************************//
// Package Init                                                                                   //
//************************************************************************************************//

public struct INIT() has drop;

fun init(witness: INIT, ctx: &mut TxContext) {
    abort 404
}
