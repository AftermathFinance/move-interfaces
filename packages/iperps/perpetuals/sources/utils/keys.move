// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: BUSL-1.1

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module perpetuals::keys;

public struct RegistryMarketInfoKey has copy, drop, store {
    ch_id: ID
}

public(package) fun registry_market_info(ch_id: ID): RegistryMarketInfoKey {
    abort 404
}

public struct RegistryCollateralInfoKey<phantom T> has copy, drop, store {}

public(package) fun registry_collateral_info<T>(): RegistryCollateralInfoKey<T> {
    abort 404
}

public struct RegistryConfigKey has copy, drop, store {}

public(package) fun registry_config(): RegistryConfigKey {
    abort 404
}

public struct AccountKey has copy, drop, store {
    account_id: u64,
}

public(package) fun account(account_id: u64): AccountKey {
    abort 404
}

public struct OrderTicketKey has copy, drop, store {
    ticket_id: ID,
}

public(package) fun order_ticket(ticket_id: ID): OrderTicketKey {
    abort 404
}

public struct IntegratorConfigKey has copy, drop, store {
    integrator_id: u32,
}

public(package) fun integrator_config(integrator_id: u32): IntegratorConfigKey {
    abort 404
}

public struct IntegratorRegistrationKey has copy, drop, store {
    integrator_id: u32,
}

public(package) fun integrator_registration(integrator_id: u32): IntegratorRegistrationKey {
    abort 404
}

public struct MarketVaultKey has copy, drop, store {}

public(package) fun market_vault(): MarketVaultKey {
    abort 404
}

public struct PositionKey has copy, drop, store {
    account_id: u64,
}

public(package) fun position(account_id: u64): PositionKey {
    abort 404
}

public struct MarginRatioProposalKey has copy, drop, store {}

public(package) fun margin_ratio_proposal(): MarginRatioProposalKey {
    abort 404
}

public struct SettlementPricesKey has copy, drop, store {}

public(package) fun settlement_prices(): SettlementPricesKey {
    abort 404
}

public struct AsksMapKey has copy, drop, store {}

public(package) fun asks_map(): AsksMapKey {
    abort 404
}

public struct BidsMapKey has copy, drop, store {}

public(package) fun bids_map(): BidsMapKey {
    abort 404
}

//************************************************************************************************//
// VendorClearingHouseKey                                                                         //
//************************************************************************************************//

public struct VendorClearingHouseKey<phantom VendorKey>() has copy, drop, store;

public(package) fun vendor_clearing_house_key<VendorKey>(): VendorClearingHouseKey<VendorKey> {
    abort 404
}

//************************************************************************************************//
// VendorRegistrationOpenKey                                                                      //
//************************************************************************************************//

public struct VendorRegistrationOpenKey() has copy, drop, store;

public(package) fun vendor_registration_open(): VendorRegistrationOpenKey {
    abort 404
}

//************************************************************************************************//
// FrozenVersionKey                                                                               //
//************************************************************************************************//

public struct FrozenVersionKey() has copy, drop, store;

public(package) fun frozen_version(): FrozenVersionKey {
    abort 404
}
