// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module rebate_vault::init;

//************************************************************************************************//
// Package Init                                                                                   //
//************************************************************************************************//

public struct INIT() has drop;

fun init(witness: INIT, ctx: &mut TxContext) {
    abort 404
}
