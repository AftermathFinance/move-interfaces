// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

#[allow(unused_field)]
module stable_kitchen::events;

use std::ascii;

//************************************************************************************************//
// Event                                                                                          //
//************************************************************************************************//

public struct Event<VersionedEvent: copy + drop>(VersionedEvent) has copy, drop;

//************************************************************************************************//
// CreatedVaultEventV1                                                                            //
//************************************************************************************************//

public struct CreatedVaultEventV1 has copy, drop {
    vault: ID,
    input: ascii::String,
    output: ascii::String,
    owner: address,
}

//************************************************************************************************//
// MintedEventV1                                                                                  //
//************************************************************************************************//

public struct MintedEventV1 has copy, drop {
    vault: ID,
    input: ascii::String,
    output: ascii::String,
    amount_in: u64,
    amount_out: u64,
}

//************************************************************************************************//
// BurnedEventV1                                                                                  //
//************************************************************************************************//

public struct BurnedEventV1 has copy, drop {
    vault: ID,
    input: ascii::String,
    output: ascii::String,
    amount_in: u64,
    amount_out: u64,
    amount_fee: u64,
}

//************************************************************************************************//
// DepositedRewardEventV1                                                                         //
//************************************************************************************************//

public struct DepositedRewardEventV1 has copy, drop {
    vault: ID,
    reward: ascii::String,
    amount: u64,
}

//************************************************************************************************//
// WithdrewRewardEventV1                                                                          //
//************************************************************************************************//

public struct WithdrewRewardEventV1 has copy, drop {
    vault: ID,
    reward: ascii::String,
    amount: u64,
}

//************************************************************************************************//
// UpgradedVersionEventV1                                                                         //
//************************************************************************************************//

public struct UpgradedVersionEventV1 has copy, drop {
    previous: u64,
    new: u64,
}
