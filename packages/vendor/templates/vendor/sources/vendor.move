// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: BUSL-1.1

module template::vendor;

// use vendor::{config::Config, metadata::VendorMetadata, authority::VENDOR};

// use authority_cap::authority::{AuthorityCap, ADMIN};

// use std::ascii::String;

//************************************************************************************************//
// TEMPLATE                                                                                       //
//************************************************************************************************//

public struct TEMPLATE() has drop;

//************************************************************************************************//
// Public Functions                                                                               //
//************************************************************************************************//

// NOTE: Vendor creation is currently gated. When we want to permissionlessly enable it, uncomment
// this function.
//
// /// Registers a new vendor within the Aftermath ecosystem. Returns the vendor's admin cap.
// /// The vendor's `VendorMetadata` is then created via `vendor::metadata::new` and can be
// /// further edited in the same PTB before sharing.
// ///
// /// Aborts:
// ///   i. [vendor::config::EInvalidVersion]
// ///  ii. [vendor::authority::EAuthorityCapAlreadyCreated]
// public fun register_vendor(
//     config: &mut Config,
// ): AuthorityCap<VENDOR<TEMPLATE>, ADMIN> {
//     config.register_vendor(&TEMPLATE())
// }
