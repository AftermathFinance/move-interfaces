// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_variable, unused_field, unused_function, unused_type_parameter)]
module stable_kitchen::config;

use stable_kitchen::authority::{AuthorityCap, PACKAGE};

use std::ascii;

//************************************************************************************************//
// Config                                                                                         //
//************************************************************************************************//

public struct Config has key {
    id: UID,

    /// Package versioning field.
    version: u64,

    /// The set of stablecoins that are allowed to be used in the system. A `Vault` can only
    /// be created with a `BaseStable` that is in this set.
    whitelisted_stables: vector<ascii::String>,

    /// Maximum permissible burn fee that can be set during `Vault` creation.
    max_fee_bps: u64,

    /// The `ID` of the singular, active `AuthorityCap<PACKAGE, ASSISTANT>`. Set to `@0x0` if no
    /// `AuthorityCap<PACKAGE, ASSISTANT>` is currently active.
    active_assistant: ID,
}

//******************************************* Getters *******************************************//

public fun is_whitelisted(
    config: &Config,
    stable: &ascii::String
): bool {
    abort 404
}

//******************************************* Mutators ******************************************//

/// Aborts:
///   i. [stable_kitchen::config::EInvalidVersion]
///  ii. [stable_kitchen::config::EInvalidAuthorityCap]
/// iii. [stable_kitchen::config::EAlreadyWhitelisted]
public fun whitelist_stable<Role, BaseStable>(
    config: &mut Config,
    authority_cap: &AuthorityCap<PACKAGE, Role>,
) {
    abort 404
}

/// Aborts:
///   i. [stable_kitchen::config::EInvalidVersion]
///  ii. [stable_kitchen::config::EInvalidAuthorityCap]
public fun set_max_fee_bps<Role>(
    config: &mut Config,
    authority_cap: &AuthorityCap<PACKAGE, Role>,
    max_fee_bps: u64,
) {
    abort 404
}

/// Aborts:
///   i. [stable_kitchen::config::EInvalidVersion]
public fun upgrade_version<Role>(
    _: &AuthorityCap<PACKAGE, Role>,
    config: &mut Config,
) {
    abort 404
}
