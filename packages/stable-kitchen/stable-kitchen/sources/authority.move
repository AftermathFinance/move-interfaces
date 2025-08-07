// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_field)]
module stable_kitchen::authority;

//************************************************************************************************//
// Roles                                                                                          //
//************************************************************************************************//

//******************************************** Contexts ******************************************//

public struct PACKAGE()
public struct VAULT()

//********************************************** Roles *******************************************//

public struct ADMIN()
public struct ASSISTANT()

//************************************************************************************************//
// AuthorityCap                                                                                   //
//************************************************************************************************//

/// Capability object that grants the owner authority to call a set of permissioned functions. The
/// `AuthorityCap` contains a generic type parameter to enable role-based ACLs. Currently, there
/// is support for one context--`PACKAGE`--and two roles --`ADMIN` and `ASSISTANT`.
///
/// In general an `ADMIN` has full authority to call all permissioned functions. An `ASSISTANT` has
/// a subset of the permissioned functions.
///
/// The `AuthorityCap<PACKAGE, ADMIN>` is created when the package is originally published.
public struct AuthorityCap<phantom Context, phantom Role> has key, store {
    id: UID,
    /// Set to the original package ID of this package.
    `for`: ID,
}
