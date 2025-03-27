// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

/// Module: events
module meta_vault::events;

use std::type_name;

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
// CreateVaultEvent                                                                               //
//************************************************************************************************//

public struct CreateVaultEvent has copy, drop {
    vault_id: ID,
    meta_coin_type: vector<u8>,
    meta_coin_decimals: u8,
}

public(package) fun emit_create_vault_event<MetaCoin>(
    vault_id: ID,
    meta_coin_decimals: u8,
) {
    abort 404
}

//************************************************************************************************//
// DepositEvent                                                                                   //
//************************************************************************************************//

public struct DepositEvent has copy, drop {
    vault_id: ID,
    meta_coin_type: vector<u8>,
    meta_coin_amount_minted: u64,
    meta_coin_amount_total_supply: u64,
    coin_in_type: vector<u8>,
    coin_in_amount_deposited: u64,
    coin_in_amount_in_vault: u64,
    exchange_rate_meta_coin_to_coin_in: u128,
}

public(package) fun emit_deposit_event<MetaCoin, CoinIn>(
    vault_id: ID,
    meta_coin_amount_minted: u64,
    meta_coin_amount_total_supply: u64,
    coin_in_amount_deposited: u64,
    coin_in_amount_in_vault: u64,
    exchange_rate_meta_coin_to_coin_in: u128,
) {
    abort 404
}

//************************************************************************************************//
// WithdrawEvent                                                                                  //
//************************************************************************************************//

public struct WithdrawEvent has copy, drop {
    vault_id: ID,
    meta_coin_type: vector<u8>,
    meta_coin_amount_burned: u64,
    meta_coin_amount_total_supply: u64,
    coin_out_type: vector<u8>,
    coin_out_amount_withdrawn: u64,
    coin_out_amount_in_vault: u64,
    fee_coin_amount: u64,
    exchange_rate_meta_coin_to_coin_out: u128,
}

public(package) fun emit_withdraw_event<MetaCoin, CoinOut>(
    vault_id: ID,
    meta_coin_amount_burned: u64,
    meta_coin_amount_total_supply: u64,
    coin_out_amount_withdrawn: u64,
    coin_out_amount_in_vault: u64,
    fee_coin_amount: u64,
    exchange_rate_meta_coin_to_coin_out: u128,
) {
    abort 404
}

//************************************************************************************************//
// SwapEvent                                                                                      //
//************************************************************************************************//

public struct SwapEvent has copy, drop {
    vault_id: ID,
    coin_in_type: vector<u8>,
    coin_in_amount_deposited: u64,
    coin_in_amount_in_vault: u64,
    coin_out_type: vector<u8>,
    coin_out_amount_withdrawn: u64,
    coin_out_amount_in_vault: u64,
    fee_coin_amount: u64,
    exchange_rate_meta_coin_to_coin_in: u128,
    exchange_rate_meta_coin_to_coin_out: u128,
}

public(package) fun emit_swap_event<CoinIn, CoinOut>(
    vault_id: ID,
    coin_in_amount_deposited: u64,
    coin_in_amount_in_vault: u64,
    coin_out_amount_withdrawn: u64,
    coin_out_amount_in_vault: u64,
    fee_coin_amount: u64,
    exchange_rate_meta_coin_to_coin_in: u128,
    exchange_rate_meta_coin_to_coin_out: u128,
) {
    abort 404
}

//***********************************************************************************************//
// SupportCoinEvent                                                                              //
//***********************************************************************************************//

/// Emitted when a new coin type is supported in the vault.
public struct SupportCoinEvent has copy, drop {
    vault_id: ID,
    coin_type: vector<u8>,
    deposit_cap: u64,
    min_fee: u64,
    max_fee: u64,
    priority: u64,
    decimals: u8,
}

public(package) fun emit_support_coin_event<CoinType>(
    vault_id: ID,
    deposit_cap: u64,
    min_fee: u64,
    max_fee: u64,
    priority: u64,
    decimals: u8,
) {
    abort 404
}

//***********************************************************************************************//
// UpdateFeeEvent                                                                                //
//***********************************************************************************************//

public struct UpdateFeeEvent has copy, drop {
    vault_id: ID,
    coin_type: vector<u8>,
    new_min_fee: u64,
    new_max_fee: u64,
    new_flash_loan_fee: u64,
}

public(package) fun emit_update_fee_event<CoinType>(
    vault_id: ID,
    new_min_fee: u64,
    new_max_fee: u64,
    new_flash_loan_fee: u64,
) {
    abort 404
}

//************************************************************************************************//
// AuthorizedAppEvent                                                                             //
//************************************************************************************************//

/// Emitted when the owner of the `AdminCap` calls `authorize` on an objects `UID`. The UID is
///  converted to an `address` before being emitted.
public struct AuthorizedAppEvent has copy, drop {
    app_id: address
}

public(package) fun emit_authorized_app_event(
    app_id: &UID
) {
    abort 404
}

//************************************************************************************************//
// DeauthorizedAppEvent                                                                           //
//************************************************************************************************//

/// Emitted when the owner of the `AdminCap` calls `deauthorize` on an objects `UID`. The UID is
///  converted to an `address` before being emitted.
public struct DeauthorizedAppEvent has copy, drop {
    app_id: address
}

public(package) fun emit_deauthorized_app_event(
    app_id: &UID
) {
    abort 404
}
