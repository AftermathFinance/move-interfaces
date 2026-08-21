// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module market_making_vault::keys;

// =========================================================================
//  Module public structs
// =========================================================================

public struct AccountCapKey has copy, drop, store {}

public struct OwnerLockedLpCoinKey has copy, drop, store {}

public struct OwnerFeesKey has copy, drop, store {}

public struct ActiveAssistantCountKey has copy, drop, store {}

public struct VaultRecordKey has copy, drop, store {
    vault_id: ID,
}

public struct UserLpCoinRecordKey has copy, drop, store {
    user_lp_coin_id: ID,
}

public struct WithdrawRequestKey has copy, drop, store {
    sender: address,
}

public struct VaultMetadataKey has copy, drop, store {}

public struct FrozenVersionKey has copy, drop, store {}

// =========================================================================
//  Public(friend) Functions Implementation
// =========================================================================

public(package) fun owner_user_lp_coin_key(): OwnerLockedLpCoinKey {
    abort 404
}

public(package) fun owner_fees_key(): OwnerFeesKey {
    abort 404
}

public(package) fun active_assistant_count_key(): ActiveAssistantCountKey {
    abort 404
}

public(package) fun vault_record_key(vault_id: ID): VaultRecordKey {
    abort 404
}

public(package) fun user_lp_coin_record_key(user_lp_coin_id: ID): UserLpCoinRecordKey {
    abort 404
}

public(package) fun account_cap_key(): AccountCapKey {
    abort 404
}

public(package) fun withdraw_request(sender: address): WithdrawRequestKey {
    abort 404
}

public(package) fun vault_metadata_key(): VaultMetadataKey {
    abort 404
}

public(package) fun frozen_version_key(): FrozenVersionKey {
    abort 404
}
