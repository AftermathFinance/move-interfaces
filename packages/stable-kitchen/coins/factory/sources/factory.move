// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

module stable_kitchen_factory::stable_coin;

use stable_kitchen::vault::CreateVaultCap;

use sui::coin::TreasuryCap;

//************************************************************************************************//
// Constants                                                                                      //
//************************************************************************************************//

const DECIMALS: u8 = 6;
const SYMBOL: vector<u8> = b"symbolUSD";
const NAME: vector<u8> = b"nameUSD";
const DESCRIPTION: vector<u8> = b"descriptionUSD";
const ICON_URL: vector<u8> = b"iconUSD";

//************************************************************************************************//
// Package Init                                                                                   //
//************************************************************************************************//

public struct STABLE_COIN() has drop;

fun init(witness: STABLE_COIN, ctx: &mut TxContext) {
    use fun stable_kitchen::vault::to_create_vault_cap as TreasuryCap.to_create_vault_cap;
    use fun sui::url::new_unsafe_from_bytes as vector.into;

    let (treasury_cap, coin_metadata) = sui::coin::create_currency(
        witness,
        DECIMALS,
        SYMBOL,
        NAME,
        DESCRIPTION,
        std::option::some(ICON_URL.into()),
        ctx,
    );

    treasury_cap.to_create_vault_cap(coin_metadata, ctx)
        .keep!(ctx);
}

//************************************************************************************************//
// Internal Functions                                                                             //
//************************************************************************************************//

use fun keep as CreateVaultCap.keep;
macro fun keep<$QuoteStable>(
    $cap: CreateVaultCap<$QuoteStable>,
    $ctx: &mut TxContext,
) {
    let cap = $cap;
    let ctx = $ctx;

    sui::transfer::public_transfer(cap, ctx.sender());
}
