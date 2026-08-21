// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

module af_lp::af_lp;

//************************************************************************************************//
// Constants                                                                                      //
//************************************************************************************************//

const SYMBOL: vector<u8> = b"afLP";
const NAME: vector<u8> = b"afLP";
const DESCRIPTION: vector<u8> = b"The LP Coin underpinning Aftermath's afLP Vault";
const URL: vector<u8> = b"https://aftermath.finance/coins/perpetuals/af-lp.svg";
const DECIMALS: u8 = 6;

//************************************************************************************************//
// AF_LP                                                                                          //
//************************************************************************************************//

public struct AF_LP() has drop;

//************************************************************************************************//
// Package Initialization                                                                         //
//************************************************************************************************//

#[allow(deprecated_usage)]
fun init(otw: AF_LP, ctx: &mut TxContext) {
    use fun sui::url::new_unsafe_from_bytes as vector.into;

    // `market_making_vault::vault::create_vault` reads `L`'s decimals from `CoinMetadata<L>`.
    // This coin package fixes afLP metadata decimals to 6.
    //
    // To reduce the total number of transactions required to create a `Vault`, we favor creating
    // the legacy `CoinMetadata` during package init and call `migrate_legacy_metadata within
    // `create_vault`.
    //
    // Compare this to:
    //  1. `sui::coin_registry::new_currency`: first transaction is required to publish the new
    //     type `L` and a second is required to call `new_currency", which shares the created
    //     `Currency`, thus requiring a third tx for `create_vault` to access the created
    //     `Currency`. Minimum tx = 3.
    //  2. `sui::coin_registry::new_currency_with_otw`: `Currency` is created during package init
    //     (first tx), but a second tx is required to call `finalize_registration` to "receive" and
    //     share the `Currency`. Thus, again, a third tx is required for `create_vault` to access the
    //     created `Currency`. Minimum tx = 3.
    //
    // For this reason, we create the `CoinMetadata` during package init (1st tx), and pass in the
    // `CoinMetadata` to `create_vault` to access the `decimals` value directly and migrate the
    // legacy metadata to a `Currency` object. Minimum tx = 2. Through this setup we achieve the
    // minimum transaction count while (1) reading the configured decimals from metadata and
    // (2) using the new `Currency` standard.
    //
    // i. Create the 'CoinMetadata<AF_LP>' and 'TreasuryCap<AF_LP›' objects.
    let (treasury_cap, coin_metadata) = sui::coin::create_currency(
        otw,
        DECIMALS,
        SYMBOL,
        NAME,
        DESCRIPTION,
        option::some(URL.into()),
        ctx,
    );

    sui::transfer::public_freeze_object(coin_metadata);
    sui::transfer::public_transfer(treasury_cap, ctx.sender());
}

//************************************************************************************************//
// Test Functions                                                                                 //
//************************************************************************************************//

#[test_only]
public fun init_for_testing(ctx: &mut TxContext) {
    init(AF_LP(), ctx);
}
