// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module market_making_vault::events;
use std::string::String;
use std::type_name::TypeName;

use sui::event::emit;

// =========================================================================
//  Events public structs
// =========================================================================

/* ================= User's events ================= */

public struct UserDeposit has copy, drop {
    vault_id: ID,
    user: address,
    provided_balance: u64,
    lp_coin_minted: u64,
    vault_balance_value: u256,
}

public struct UserCreateWithdrawRequest has copy, drop {
    vault_id: ID,
    user: address,
    provided_lp_coin: u64,
    min_expected_balance_out: u64,
}

public struct UserRemoveWithdrawRequest has copy, drop {
    vault_id: ID,
    user: address,
    provided_lp_coin: u64,
}

public struct UserWithdrawRequestSetSlippage has copy, drop {
    vault_id: ID,
    user: address,
    min_expected_balance_out: u64,
}

public struct OwnerWithdraw has copy, drop {
    vault_id: ID,
    user: address,
    provided_lp_coin: u64,
    withdrawn_balance: u64,
    vault_balance_value: u256,
}

public struct OwnerLockedLiquidityWithdraw has copy, drop {
    vault_id: ID,
    user: address,
    provided_lp_coin: u64,
    withdrawn_balance: u64,
    remaining_locked_lp: u64,
}

public struct UserForceWithdraw has copy, drop {
    vault_id: ID,
    user: address,
    provided_lp_coin: u64,
    withdrawn_balance: u64,
    vault_balance_value: u256,
}

/* ================= Vault's events ================= */

public struct CreateVault has copy, drop {
    vault_id: ID,
    owner_cap_id: ID,
    vault_metadata_id: ID,
    collateral_storage_id: u32,
    lp_coin_type: String,
    collateral_type: String,
    lp_coin_decimals: u8,
    initial_liquidity: u64,
    vault_admin: address,
    account_id: u64,
    lock_period: u64,
}

public struct CreateVaultAssistantCap has copy, drop {
    vault_id: ID,
    assistant_cap_id: ID,
}

public struct CreateVaultTreasuryCap has copy, drop {
    vault_id: ID,
    treasury_cap_id: ID,
}

public struct RevokedVaultAuthorityCap has copy, drop {
    vault_id: ID,
    role: TypeName,
    cap_id: ID,
}

public struct CreatePackageAssistantCap has copy, drop {
    config_id: ID,
    assistant_cap_id: ID,
}

public struct CreatePackagePauseGuardianCap has copy, drop {
    config_id: ID,
    pause_guardian_cap_id: ID,
}

public struct CreatePackageMaintenanceCap has copy, drop {
    config_id: ID,
    maintenance_cap_id: ID,
}

public struct RevokedPackageAuthorityCap has copy, drop {
    config_id: ID,
    role: TypeName,
    cap_id: ID,
}

public struct CreatedPackageFreezeGuardianCap has copy, drop {
    config_id: ID,
    cap_id: ID,
}

public struct Froze has copy, drop {
    id: ID,
    resume_version: u64,
    guardian_cap_id: ID,
}

public struct Unfroze has copy, drop {
    id: ID,
    version: u64,
}

public struct AddYield has copy, drop {
    vault_id: ID,
    amount: u64,
}

public struct AdminPauseVault has copy, drop {
    vault_id: ID,
}

public struct AdminUnpauseVault has copy, drop {
    vault_id: ID,
}

public struct UpgradeVaultVersion has copy, drop {
    vault_id: ID,
    version: u64
}

public struct UpgradeConfigVersion has copy, drop {
    config_id: ID,
    version: u64
}

public struct UpdateMinPauseVaultForForceWithdrawFrequencyMs has copy, drop {
    vault_id: ID,
    min_pause_vault_for_force_withdraw_frequency_ms: u64
}

public struct UpdateMinForceWithdrawPositionUsd has copy, drop {
    vault_id: ID,
    min_force_withdraw_position_usd: u256
}

public struct UpdateMinOwnerLockUsd has copy, drop {
    vault_id: ID,
    min_owner_lock_usd: u256
}

public struct UpdateCollateralPfsInfo has copy, drop {
    vault_id: ID,
    collateral_storage_id: u32,
    collateral_source_id: u16,
}

public struct UpdateCollateralPfsSourceTolerance has copy, drop {
    vault_id: ID,
    collateral_pfs_tolerance: u64
}

public struct UpdateVaultMetadata has copy, drop {
    vault_id: ID,
    field: String,
    value: String,
}

public struct UpdateOwnerFeeRate has copy, drop {
    vault_id: ID,
    owner_fee_rate: u256
}

public struct UpdateLockPeriod has copy, drop {
    vault_id: ID,
    lock_period: u64
}

public struct UpdateForceWithdrawDelay has copy, drop {
    vault_id: ID,
    force_withdraw_delay: u64
}

public struct UpdateMaxForceWithdrawMrTolerance has copy, drop {
    vault_id: ID,
    max_force_withdraw_mr_tolerance: u256
}

public struct UpdateMaxTotalDepositedCollateral has copy, drop {
    vault_id: ID,
    max_total_deposited_collateral: u64
}

public struct WithdrawFees has copy, drop {
    vault_id: ID,
    amount_to_withdraw: u64
}

public struct MaxMarketsUpdated has copy, drop {
    vault_id: ID,
    new_max_markets: u64,
}

public struct MaxPendingOrdersUpdated has copy, drop {
    vault_id: ID,
    new_max_pending_orders: u64,
}

// =========================================================================
//  Events Emits
// =========================================================================

/* ================= User's emits ================= */

public(package) fun emit_user_deposit(
    vault_id: ID,
    user: address,
    provided_balance: u64,
    lp_coin_minted: u64,
    vault_balance_value: u256,
   ) {
    abort 404
}

public(package) fun emit_create_withdraw_request(
    vault_id: ID,
    user: address,
    provided_lp_coin: u64,
    min_expected_balance_out: u64
) {
    abort 404
}

public(package) fun emit_remove_withdraw_request(
    vault_id: ID,
    user: address,
    provided_lp_coin: u64,
) {
    abort 404
}

public(package) fun emit_user_withdraw_request_set_slippage(
    vault_id: ID,
    user: address,
    min_expected_balance_out: u64,
) {
    abort 404
}

public(package) fun emit_owner_withdraw(
    vault_id: ID,
    user: address,
    provided_lp_coin: u64,
    withdrawn_balance: u64,
    vault_balance_value: u256,
) {
    abort 404
}

public(package) fun emit_owner_locked_liquidity_withdraw(
    vault_id: ID,
    user: address,
    provided_lp_coin: u64,
    withdrawn_balance: u64,
    remaining_locked_lp: u64,
) {
    abort 404
}

public(package) fun emit_user_force_withdraw(
    vault_id: ID,
    user: address,
    provided_lp_coin: u64,
    withdrawn_balance: u64,
    vault_balance_value: u256,
) {
    abort 404
}

/* ================= Vault's events ================= */

public(package) fun emit_created_vault_event(
    vault_id: ID,
    vault_metadata_id: ID,
    owner_cap_id: ID,
    collateral_storage_id: u32,
    lp_coin_type: String,
    collateral_type: String,
    lp_coin_decimals: u8,
    initial_liquidity: u64,
    vault_admin: address,
    account_id: u64,
    lock_period: u64,
) {
    abort 404
}

public(package) fun emit_create_vault_assistant_cap(
    vault_id: ID,
    assistant_cap_id: ID,
) {
    abort 404
}

public(package) fun emit_revoked_vault_authority_cap(
    vault_id: ID,
    role: TypeName,
    cap_id: ID,
) {
    abort 404
}

public(package) fun emit_create_vault_treasury_cap(
    vault_id: ID,
    treasury_cap_id: ID,
) {
    abort 404
}

public(package) fun emit_create_package_assistant_cap(
    config_id: ID,
    assistant_cap_id: ID,
) {
    abort 404
}

public(package) fun emit_create_package_pause_guardian_cap(
    config_id: ID,
    pause_guardian_cap_id: ID,
) {
    abort 404
}

public(package) fun emit_create_package_maintenance_cap(
    config_id: ID,
    maintenance_cap_id: ID,
) {
    abort 404
}

public(package) fun emit_revoked_package_authority_cap(
    config_id: ID,
    role: TypeName,
    cap_id: ID,
) {
    abort 404
}

public(package) fun emit_created_package_freeze_guardian_cap(
    config_id: ID,
    cap_id: ID,
) {
    abort 404
}

public(package) fun emit_froze(
    id: ID,
    resume_version: u64,
    guardian_cap_id: ID,
) {
    abort 404
}

public(package) fun emit_unfroze(
    id: ID,
    version: u64,
) {
    abort 404
}

public(package) fun emit_add_yield_event(
    vault_id: ID,
    amount: u64,
) {
    abort 404
}

public(package) fun emit_admin_pause_vault(
    vault_id: ID,
) {
    abort 404
}

public(package) fun emit_admin_unpause_vault(
    vault_id: ID,
) {
    abort 404
}

public(package) fun emit_upgrade_vault_version(
    vault_id: ID,
    version: u64
) {
    abort 404
}

public(package) fun emit_upgrade_config_version(
    config_id: ID,
    version: u64
) {
    abort 404
}

public(package) fun emit_update_min_pause_vault_for_force_withdraw_frequency_ms(
    vault_id: ID,
    min_pause_vault_for_force_withdraw_frequency_ms: u64
) {
    abort 404
}

public(package) fun emit_update_min_force_withdraw_position_usd(
    vault_id: ID,
    min_force_withdraw_position_usd: u256
) {
    abort 404
}

public(package) fun emit_update_min_owner_lock_usd(
    vault_id: ID,
    min_owner_lock_usd: u256
) {
    abort 404
}

public(package) fun emit_update_collateral_pfs_info(
    vault_id: ID,
    collateral_storage_id: u32,
    collateral_source_id: u16,
) {
    abort 404
}

public(package) fun emit_update_collateral_pfs_tolerance(
    vault_id: ID,
    collateral_pfs_tolerance: u64
) {
    abort 404
}

public(package) fun emit_update_max_force_withdraw_mr_tolerance(
    vault_id: ID,
    max_force_withdraw_mr_tolerance: u256
) {
    abort 404
}

public(package) fun emit_update_vault_metadata(
    vault_id: ID,
    field: String,
    value: String,
) {
    abort 404
}

public(package) fun emit_update_owner_fee_rate(
    vault_id: ID,
    owner_fee_rate: u256
) {
    abort 404
}

public(package) fun emit_update_lock_period(
    vault_id: ID,
    lock_period: u64
) {
    abort 404
}

public(package) fun emit_update_force_withdraw_delay(
    vault_id: ID,
    force_withdraw_delay: u64
) {
    abort 404
}

public(package) fun emit_update_max_total_deposited_collateral(
    vault_id: ID,
    max_total_deposited_collateral: u64
) {
    abort 404
}

public(package) fun emit_withdraw_fees(
    vault_id: ID,
    amount_to_withdraw: u64
) {
    abort 404
}

public(package) fun emit_max_markets_updated(
    vault_id: ID,
    new_max_markets: u64,
) {
    abort 404
}

public(package) fun emit_max_pending_orders_updated(
    vault_id: ID,
    new_max_pending_orders: u64,
) {
    abort 404
}
