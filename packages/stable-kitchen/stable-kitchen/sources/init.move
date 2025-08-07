// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_variable, unused_mut_parameter)]
module stable_kitchen::init;

//************************************************************************************************//
// Package Init                                                                                   //
//************************************************************************************************//

public struct INIT() has drop ;

fun init(witness: INIT, ctx: &mut TxContext) {
   abort 404
}
