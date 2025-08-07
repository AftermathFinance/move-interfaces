// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

module cook_usd::cook_usd;

use stable_kitchen::vault::CreateVaultCap;

use sui::coin::TreasuryCap;

//************************************************************************************************//
// Constants                                                                                      //
//************************************************************************************************//

const DECIMALS: u8 = 6;
const SYMBOL: vector<u8> = b"cookUSD";
const NAME: vector<u8> = b"Cook USD";
const DESCRIPTION: vector<u8> = b"The official yield-bearing stablecoin created by stable.kitchen";
const ICON_URL: vector<u8> = b"https://stable.kitchen/coins/cookusd.svg";

//************************************************************************************************//
// Package Init                                                                                   //
//************************************************************************************************//

public struct COOK_USD() has drop;

fun init(witness: COOK_USD, ctx: &mut TxContext) {
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
