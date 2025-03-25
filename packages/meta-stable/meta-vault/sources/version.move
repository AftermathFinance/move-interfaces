// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

/// Module: version
module meta_vault::version;
use meta_vault::admin::AdminCap;

use sui::types::is_one_time_witness;

//************************************************************************************************//
// Errors                                                                                         //
//************************************************************************************************//

#[error]
const EInvalidVersion: vector<u8> = b"You are interacting with an outdated contract.";

#[error]
const EVersionAlreadyCreated: vector<u8> = b"The singleton `Version` has already been created.";

//************************************************************************************************//
// Constants                                                                                      //
//************************************************************************************************//

const CURRENT_VERSION: u64 = 2;

//************************************************************************************************//
// Version                                                                                         //
//************************************************************************************************//

/// The package's singleton object that contains all relevant configuration variables. This object
///  is used for versioning across the entire `MetaVault` package.
public struct Version has key {
    id: UID,
    /// Versioning field to allow for safe upgrades.
    version: u64,
}

//****************************************** Constructor *****************************************//

/// Create + share a unique `Version` object.
///
/// Aborts:
///   i. [meta_vault::version::EVersionAlreadyCreated]
public(package) fun create_version<T: drop>(
    witness: &T,
    ctx: &mut TxContext
) {
    abort 404
}

//******************************************** Getters *******************************************//

public fun current_version(): u64 { abort 404 }

//************************************ Mutators [Permissioned] ***********************************//

public fun upgrade_version(
    _: &AdminCap,
    version: &mut Version,
) {
    abort 404
}

//**************************************************************************************************//
// Validity Checks                                                                                  //
//**************************************************************************************************//

public(package) fun assert_correct_package(version: &Version) {
    abort 404
}
