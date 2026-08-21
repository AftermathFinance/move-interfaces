// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: BUSL-1.1

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module shared_gas_pool::events;

use sui::event;

//************************************************************************************************//
// Event                                                                                          //
//************************************************************************************************//

public struct Event<VersionedEvent: copy + drop>(VersionedEvent) has copy, drop;

fun emit<VersionedEvent: copy + drop>(event: VersionedEvent) {
    abort 404
}

//************************************************************************************************//
// CreateGasPoolEventV1                                                                           //
//************************************************************************************************//

public struct CreateGasPoolEventV1 has copy, drop {
    gas_pool_id: ID,
    owner: address,
}

public(package) fun emit_create_gas_pool_event(gas_pool_id: ID, owner: address) {
    abort 404
}

//************************************************************************************************//
// JoinGasPoolEventV1                                                                             //
//************************************************************************************************//

public struct JoinGasPoolEventV1 has copy, drop {
    gas_pool_id: ID,
    amount: u64,
}

public(package) fun emit_join_gas_pool_event(gas_pool_id: ID, amount: u64) {
    abort 404
}

//************************************************************************************************//
// SplitGasPoolEventV1                                                                            //
//************************************************************************************************//

public struct SplitGasPoolEventV1 has copy, drop {
    gas_pool_id: ID,
    amount: u64,
}

public(package) fun emit_split_gas_pool_event(gas_pool_id: ID, amount: u64) {
    abort 404
}

//************************************************************************************************//
// SponsorEventV1                                                                                 //
//************************************************************************************************//

public struct SponsorEventV1 has copy, drop {
    gas_pool_id: ID,
    sender: address,
    sponsor: address,
    amount: u64,
}

public(package) fun emit_sponsor_event(
    gas_pool_id: ID,
    sender: address,
    sponsor: address,
    amount: u64,
) {
    abort 404
}

//************************************************************************************************//
// AuthorizeGasPoolAddressEventV1                                                                 //
//************************************************************************************************//

public struct AuthorizeGasPoolAddressEventV1 has copy, drop {
    gas_pool_id: ID,
    authorized_address: address,
}

public(package) fun emit_authorize_gas_pool_address_event(gas_pool_id: ID, authorized_address: address) {
    abort 404
}

//************************************************************************************************//
// DeauthorizeGasPoolAddressEventV1                                                               //
//************************************************************************************************//

public struct DeauthorizeGasPoolAddressEventV1 has copy, drop {
    gas_pool_id: ID,
    deauthorized_address: address,
}

public(package) fun emit_deauthorize_gas_pool_address_event(
    gas_pool_id: ID,
    deauthorized_address: address,
) {
    abort 404
}

//************************************************************************************************//
// AdminSplitGasPoolEventV1                                                                       //
//************************************************************************************************//

public struct AdminSplitGasPoolEventV1 has copy, drop {
    gas_pool_id: ID,
    amount: u64,
    recipient: address,
    settled_from: u64,
    settled_to: u64,
}

public(package) fun emit_admin_split_gas_pool_event(
    gas_pool_id: ID,
    amount: u64,
    recipient: address,
    settled_from: u64,
    settled_to: u64,
) {
    abort 404
}

//************************************************************************************************//
// AdminJoinGasPoolEventV1                                                                        //
//************************************************************************************************//

public struct AdminJoinGasPoolEventV1 has copy, drop {
    gas_pool_id: ID,
    amount: u64,
    sponsor: address,
    settled_from: u64,
    settled_to: u64,
}

public(package) fun emit_admin_join_gas_pool_event(
    gas_pool_id: ID,
    amount: u64,
    sponsor: address,
    settled_from: u64,
    settled_to: u64,
) {
    abort 404
}

//************************************************************************************************//
// ApproveSponsorEventV1                                                                          //
//************************************************************************************************//

public struct ApproveSponsorEventV1 has copy, drop {
    sponsor: address,
}

public(package) fun emit_approve_sponsor_event(sponsor: address) {
    abort 404
}

//************************************************************************************************//
// UnapproveSponsorEventV1                                                                        //
//************************************************************************************************//

public struct UnapproveSponsorEventV1 has copy, drop {
    sponsor: address,
}

public(package) fun emit_unapprove_sponsor_event(sponsor: address) {
    abort 404
}
