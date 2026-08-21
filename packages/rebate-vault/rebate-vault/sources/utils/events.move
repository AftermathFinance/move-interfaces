// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module rebate_vault::events;

use std::type_name;
use std::ascii;

//************************************************************************************************//
// Event                                                                                          //
//************************************************************************************************//

public struct Event<VersionedEvent: copy + drop>(VersionedEvent) has copy, drop;

fun emit<VersionedEvent: copy + drop>(
    event: VersionedEvent
) {
    abort 404
}

//************************************************************************************************//
// CreateVaultEventV1                                                                             //
//************************************************************************************************//

public struct CreateVaultEventV1 has copy, drop {
    vault_id: ID,
}

public (package) fun emit_create_vault_event(
    vault_id: ID,
) {
    abort 404
}

//************************************************************************************************//
// DepositEventV1                                                                                 //
//************************************************************************************************//

public struct DepositEventV1 has copy, drop {
    vault_id: ID,
    address: address,
    coin_type: ascii::String,
    amount: u64,
}

public (package) fun emit_deposit_event<CoinType>(
    vault_id: ID,
    address: address,
    amount: u64,
) {
    abort 404
}

//************************************************************************************************//
// DepositSessionEventV1                                                                          //
//************************************************************************************************//

public struct DepositSessionEventV1 has copy, drop {
    vault_id: ID,
    domain: ascii::String,
    rebate_type: ascii::String,
    rebate_amount: u64,
    num_of_addresses: u64,
    epoch_start_timestamp_ms: u64,
    epoch_end_timestamp_ms: u64,
}

public (package) fun emit_deposit_session_event<CoinType>(
    vault_id: ID,
    domain: ascii::String,
    rebate_amount: u64,
    num_of_addresses: u64,
    epoch_start_timestamp_ms: u64,
    epoch_end_timestamp_ms: u64,
) {
    abort 404
}

//************************************************************************************************//
// WithdrawRebateEventV1                                                                          //
//************************************************************************************************//

public struct WithdrawRebateEventV1 has copy, drop {
    vault_id: ID,
    sender: address,
    types: vector<ascii::String>,
    amounts: vector<u64>,
}

public (package) fun emit_withdraw_rebate_event(
    vault_id: ID,
    sender: address,
    types: vector<ascii::String>,
    amounts: vector<u64>,
) {
    abort 404
}
