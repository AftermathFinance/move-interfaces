// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

/// Module: vault_assistant
module meta_vault::vault_assistant;

//************************************************************************************************//
// VaultAssistantCap                                                                              //
//************************************************************************************************//

/// Admin capability object to allow a subset og the full permissioned functionality on a specific
/// `Vault` object. Each `Vault` maintains one active `VaultAssistantCap` object.
///
/// Only the `AdminCap` holder can create a `VaultAssistantCap` object and they do so through
/// `rotate_assistant_cap` flow.
public struct VaultAssistantCap has key, store {
    id: UID,
    `for`: ID,
}

//****************************************** Constructors ****************************************//

/// Create a new `VaultAssistantCap`.
public(package) fun create_vault_assistant_cap(
    vault_id: ID,
    ctx: &mut TxContext,
): VaultAssistantCap {
    abort 404
}
