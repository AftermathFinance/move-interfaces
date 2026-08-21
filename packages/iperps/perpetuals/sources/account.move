// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: BUSL-1.1

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module perpetuals::account;

use perpetuals::authority::ACCOUNT;
use perpetuals::registry::Registry;
use perpetuals::constants;
use perpetuals::events;
use perpetuals::keys;

use authority_cap::authority::{AuthorityCap, ADMIN, ASSISTANT};

use ifixed::ifixed;

use sui::dynamic_field as df;
use sui::transfer::Receiving;
use sui::balance::Balance;
use sui::coin::Coin;

use std::type_name::{Self, TypeName};
use std::option::{Self, Option};

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//
// Error code range: 4000-4999.

macro fun invalid_account_cap(): u64 { 4000 }

macro fun invalid_integrator_fee(): u64 { 4001 }

macro fun collateral_is_not_registered(): u64 { 4002 }

macro fun invalid_share_policy(): u64 { 4003 }

macro fun order_invalid_account(): u64 { 4004 }

macro fun too_many_assistants_per_account(): u64 { 4005 }

//************************************************************************************************//
// IntegratorConfig                                                                               //
//************************************************************************************************//

public struct IntegratorConfig has store {
    max_integrator_fee_b9: u32
}

//******************************************** Getters *******************************************//

public fun max_integrator_fee_b9(config: &IntegratorConfig): u32 {
    abort 404
}

//************************************************************************************************//
// IntegratorInfo                                                                                 //
//************************************************************************************************//

public struct IntegratorInfo has copy, drop, store {
    integrator_id: u32,
    integrator_fee: u32
}

//****************************************** Constructor *****************************************//

public fun create_integrator_info(
    integrator_id: u32,
    integrator_fee_b9: u32,
): Option<IntegratorInfo> {
    abort 404
}

//******************************************** Getters *******************************************//

public fun integrator_id(info: &IntegratorInfo): u32 {
    abort 404
}

public fun integrator_fee_b9(info: &IntegratorInfo): u32 {
    abort 404
}

public fun integrator_fee(info: &IntegratorInfo): u256 {
    abort 404
}

//************************************************************************************************//
// AccountSharePolicy                                                                             //
//************************************************************************************************//

public struct AccountSharePolicy(ID) /* has hot_potato */

//************************************************************************************************//
// Account                                                                                        //
//************************************************************************************************//

public struct Account<phantom T> has key, store {
    id: UID,
    account_id: u64,
    collateral: Balance<T>,
    active_assistants: vector<ID>,
}

//****************************************** Constructor *****************************************//

public fun create_account<T>(
    registry: &mut Registry,
    ctx: &mut TxContext,
): (Account<T>, AccountSharePolicy, AuthorityCap<ACCOUNT, ADMIN>) {
    abort 404
}

public fun create_and_share_account<T>(
    registry: &mut Registry,
    ctx: &mut TxContext,
): AuthorityCap<ACCOUNT, ADMIN> {
    abort 404
}

#[allow(lint(share_owned, custom_state_change))]
public fun consume_policy_and_share_account<T>(
    account: Account<T>,
    share_policy: AccountSharePolicy,
) {
    abort 404
}

//******************************************** Getters *******************************************//

public fun account_id<T>(account: &Account<T>): u64 {
    abort 404
}

public fun collateral_balance<T>(account: &Account<T>): u64 {
    abort 404
}

public(package) fun borrow_mut_collateral<T>(account: &mut Account<T>): &mut Balance<T> {
    abort 404
}

public fun has_order_ticket<T>(
    account: &Account<T>,
    ticket_id: ID,
): bool {
    abort 404
}

public(package) fun borrow_mut_order_ticket<T, Ticket: key + store>(
    account: &mut Account<T>,
    ticket_id: ID,
): &mut Ticket {
    abort 404
}

public fun integrator_config<T>(
    account: &Account<T>,
    integrator_id: u32,
): &IntegratorConfig {
    abort 404
}

//******************************************* Mutators *******************************************//

public(package) fun add_order_ticket<T, Ticket: key + store>(
    account: &mut Account<T>,
    ticket: Ticket,
): ID {
    abort 404
}

public(package) fun remove_order_ticket<T, Ticket: key + store>(
    account: &mut Account<T>,
    ticket_id: ID,
): Ticket {
    abort 404
}

//******************** Mutators [Permissioned] [AuthorityCap<ACCOUNT, ADMIN>] ********************//

public fun withdraw_collateral<T>(
    account: &mut Account<T>,
    cap: &AuthorityCap<ACCOUNT, ADMIN>,
    registry: &Registry,
    amount: u64,
    ctx: &mut TxContext,
): Coin<T> {
    abort 404
}

public fun new_assistant_account_cap<T>(
    account: &mut Account<T>,
    cap: &AuthorityCap<ACCOUNT, ADMIN>,
    registry: &mut Registry,
    ctx: &mut TxContext,
): AuthorityCap<ACCOUNT, ASSISTANT> {
    abort 404
}

public fun revoke_assistant_account_cap<T>(
    account: &mut Account<T>,
    cap: &AuthorityCap<ACCOUNT, ADMIN>,
    registry: &mut Registry,
    assistant_cap_id: ID,
) {
    abort 404
}

//******************* Mutators [Permissioned] [AuthorityCap<ACCOUNT, ASSISTANT>] ******************//

public fun destroy_assistant_account_cap<T>(
    account: &mut Account<T>,
    cap: AuthorityCap<ACCOUNT, ASSISTANT>,
    registry: &mut Registry,
) {
    abort 404
}

//************** Mutators [Permissioned] [AuthorityCap<ACCOUNT, ADMIN_OR_ASSISTANT>] *************//

public fun deposit_collateral<T, ADMIN_OR_ASSISTANT>(
    account: &mut Account<T>,
    cap: &AuthorityCap<ACCOUNT, ADMIN_OR_ASSISTANT>,
    registry: &Registry,
    coin: Coin<T>,
) {
    abort 404
}

public fun receive_from_account<T, ADMIN_OR_ASSISTANT, Obj: key + store>(
    account: &mut Account<T>,
    cap: &AuthorityCap<ACCOUNT, ADMIN_OR_ASSISTANT>,
    registry: &Registry,
    receiving: Receiving<Obj>,
): Obj {
    abort 404
}

public fun add_integrator_config<T, ADMIN_OR_ASSISTANT>(
    account: &mut Account<T>,
    cap: &AuthorityCap<ACCOUNT, ADMIN_OR_ASSISTANT>,
    registry: &Registry,
    integrator_id: u32,
    max_integrator_fee_b9: u32,
) {
    abort 404
}

public fun remove_integrator_config<T>(
    account: &mut Account<T>,
    cap: &AuthorityCap<ACCOUNT, ADMIN>,
    registry: &Registry,
    integrator_id: u32,
) {
    abort 404
}

fun revoke_assistant_account_cap_<T>(
    account: &mut Account<T>,
    assistant_cap_id: ID,
) {
    abort 404
}

//************************************************************************************************//
// Validity Checks                                                                                //
//************************************************************************************************//

public(package) fun assert_authority_cap_is_valid<T, Role>(
    account: &Account<T>,
    cap: &AuthorityCap<ACCOUNT, Role>,
) {
    abort 404
}

public(package) fun assert_order_ticket_exists<T>(
    account: &Account<T>,
    ticket_id: ID,
) {
    abort 404
}

public(package) fun validate_session_integrator_info<T>(
    account: &Account<T>,
    integrator_info: &IntegratorInfo,
): u32 {
    abort 404
}
