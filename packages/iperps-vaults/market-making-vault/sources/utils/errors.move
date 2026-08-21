// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module market_making_vault::errors;
const ESlippageCheck: u64 = 1;

const ENotEnoughCollateralBalance: u64 = 2;

const ENonZeroTotalSupply: u64 = 3;

const ECannotForceWithdraw: u64 = 4;

const EForceWithdrawDelayNotPassed: u64 = 5;

const EInvalidLockPeriod: u64 = 6;

const EInvalidOwnerFeeRate: u64 = 7;

const EForceWithdrawTolerance: u64 = 8;

const EForceWithdrawBelowMarginRatio: u64 = 9;

const EWithdrawAmountZero: u64 = 10;

const EWithdrawAmountTooBig: u64 = 11;

const EWrongOrderIdsInForceWithdraw: u64 = 12;

const EForceWithdrawAboveMarginRatioTolerance: u64 = 13;

const ELockPeriodNotPassed: u64 = 14;

const EVaultTemporarilyPaused: u64 = 15;

const EInvalidVersion: u64 = 16;

const ENotAllChsProcessed: u64 = 17;

const EQueueIsEmpty: u64 = 18;

const EQueueIsNotEmpty: u64 = 19;

const EPackageAlreadyCreated: u64 = 21;

const EWrongCollateralOracle: u64 = 22;

const EWrongBaseOracle: u64 = 23;

const EUserLpCalculationZero: u64 = 24;

const EOwnerLockedAmountNotEnough: u64 = 25;

const EOwnerLockedAmountTooBig: u64 = 51;

const EUserDepositAmountNotEnough: u64 = 26;

const EClearingHouseIdNotFound: u64 = 27;

const EWithdrawRequestAlreadyExists: u64 = 28;

const EInvalidForceWithdrawDelayPeriod: u64 = 29;

const EWithdrawRequestDoesNotExist: u64 = 30;

const EMaxMarketsExceeded: u64 = 31;

const EMaxPendingOrdersExceeded: u64 = 32;

const ENotEnoughFees: u64 = 33;

const EUserLpCalculationNegative: u64 = 34;

const EInvalidSplitAmount: u64 = 35;

const ENegativeAmountToWithdraw: u64 = 36;

const EBadNewVaultVesrion: u64 = 37;

const EMustForceWithdraw: u64 = 38;

const EInvalidMaxPendingOrdersPerPosition: u64 = 39;

const EInvalidMaxMarketsInVault: u64 = 40;

const EWrongVaultForSession: u64 = 41;

const EInvalidCollateralPfsTolerance: u64 = 42;

const EExceedingMaxTotalDepositedCollateral: u64 = 43;

const EInvalidSender: u64 = 45;

const EPauseVaultForForceWithdrawTooFrequent: u64 = 46;

const EForceWithdrawCollateralLeftover: u64 = 47;

const EInvalidVaultAssistantCap: u64 = 48;

const EOwnerLockedAmountTooLowAfterWithdraw: u64 = 49;

const ETooManyAssistants: u64 = 50;

const EInvalidDecimals: u64 = 51;

const EBadOraclePrice: u64 = 52;

const ENonPositiveMarketMargin: u64 = 53;

const ENotFrozen: u64 = 54;

const EInvalidResumeVersion: u64 = 55;

const EClearingHouseNotEmpty: u64 = 56;

const EDepositRoundingLossTooHigh: u64 = 57;

// =========================================================================
//  Getters
// =========================================================================

public(package) fun  slippage_check(): u64 {
    abort 404
}

public(package) fun  not_enough_collateral_balance(): u64 {
    abort 404
}

public(package) fun  non_zero_total_supply(): u64 {
    abort 404
}

public(package) fun  invalid_lock_period(): u64 {
    abort 404
}

public(package) fun  invalid_force_withdraw_delay(): u64 {
    abort 404
}

public(package) fun  withdraw_request_does_not_exist(): u64 {
    abort 404
}

public(package) fun  invalid_owner_fee_rate(): u64 {
    abort 404
}

public(package) fun  force_withdraw_tolerance(): u64 {
    abort 404
}

public(package) fun  force_withdraw_below_margin_ratio(): u64 {
    abort 404
}

public(package) fun  force_withdraw_above_margin_ratio_tolerance(): u64 {
    abort 404
}

public(package) fun  withdraw_amount_zero(): u64 {
    abort 404
}

public(package) fun  withdraw_amount_too_big(): u64 {
    abort 404
}

public(package) fun  wrong_order_ids_in_force_withdraw(): u64 {
    abort 404
}

public(package) fun  lock_period_not_passed(): u64 {
    abort 404
}

public(package) fun  vault_temporarily_paused(): u64 {
    abort 404
}

public(package) fun  force_withdraw_delay_not_passed(): u64 {
    abort 404
}

public(package) fun  cannot_force_withdraw(): u64 {
    abort 404
}

public(package) fun  must_force_withdraw(): u64 {
    abort 404
}

public(package) fun  invalid_version(): u64 {
    abort 404
}

public(package) fun  not_all_chs_processed(): u64 {
    abort 404
}

public(package) fun  queue_is_empty(): u64 {
    abort 404
}

public(package) fun  queue_is_not_empty(): u64 {
    abort 404
}

public(package) fun  owner_locked_amount_not_enough(): u64 {
    abort 404
}

public(package) fun  owner_locked_amount_too_big(): u64 {
    abort 404
}

public(package) fun  wrong_vault_for_session(): u64 {
    abort 404
}

public(package) fun  package_already_created(): u64 {
    abort 404
}

public(package) fun  wrong_collateral_oracle(): u64 {
    abort 404
}

public(package) fun  wrong_base_oracle(): u64 {
    abort 404
}

public(package) fun  user_deposit_amount_not_enough(): u64 {
    abort 404
}

public(package) fun  user_lp_calculation_zero(): u64 {
    abort 404
}

public(package) fun  user_lp_calculation_negative(): u64 {
    abort 404
}

public(package) fun  clearing_house_id_not_found(): u64 {
    abort 404
}

public(package) fun  owner_locked_amount_too_low_after_withdraw(): u64 {
    abort 404
}

public(package) fun  withdraw_request_already_exists(): u64 {
    abort 404
}

public(package) fun  max_markets_exceeded(): u64 {
    abort 404
}

public(package) fun  max_pending_orders_exceeded(): u64 {
    abort 404
}

public(package) fun  not_enough_fees(): u64 {
    abort 404
}

public(package) fun  invalid_split_amount(): u64 {
    abort 404
}

public(package) fun  negative_amount_to_withdraw(): u64 {
    abort 404
}

public(package) fun  bad_new_vault_version(): u64 {
    abort 404
}

public(package) fun  invalid_max_pending_orders_per_position(): u64 {
    abort 404
}

public(package) fun  invalid_max_markets_in_vault(): u64 {
    abort 404
}

public(package) fun  invalid_collateral_pfs_tolerance(): u64 {
    abort 404
}

public(package) fun  exceeding_max_total_deposited_collateral(): u64 {
    abort 404
}

public(package) fun  invalid_sender(): u64 {
    abort 404
}

public(package) fun  pause_vault_for_force_withdraw_too_frequent(): u64 {
    abort 404
}

public(package) fun  force_withdraw_collateral_leftover(): u64 {
    abort 404
}

public(package) fun  invalid_vault_assistant_cap(): u64 {
    abort 404
}

public(package) fun too_many_assistants(): u64 {
    abort 404
}

public(package) fun invalid_decimals(): u64 {
    abort 404
}

public(package) fun bad_oracle_price(): u64 {
    abort 404
}

public(package) fun non_positive_market_margin(): u64 {
    abort 404
}

public(package) fun not_frozen(): u64 {
    abort 404
}

public(package) fun invalid_resume_version(): u64 {
    abort 404
}

public(package) fun clearing_house_not_empty(): u64 {
    abort 404
}

public(package) fun deposit_rounding_loss_too_high(): u64 {
    abort 404
}
