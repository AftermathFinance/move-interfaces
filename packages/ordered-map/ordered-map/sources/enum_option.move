// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: BUSL-1.1

#[allow(unused_use, unused_const, unused_variable, unused_mut_parameter, unused_let_mut, unused_field, unused_function, unused_type_parameter)]
module ordered_map::enum_option;

public enum Option<Element> has copy, drop, store {
    None,
    Some(Element),
}

#[error(code = 0x40)]
const EOptionIsSet: vector<u8> = b"The `Option` is `Some` while it should be `None`";
#[error(code = 0x41)]
const EOptionNotSet: vector<u8> = b"The `Option` is `None` while it should be `Some`";

public fun none<Element>(): Option<Element> {
    abort 404
}

public fun some<Element>(value: Element): Option<Element> {
    abort 404
}

public fun is_none<Element>(option: &Option<Element>): bool {
    abort 404
}

public fun is_some<Element>(option: &Option<Element>): bool {
    abort 404
}

public fun contains<Element>(option: &Option<Element>, element_ref: &Element): bool {
    abort 404
}

public fun borrow<Element>(option: &Option<Element>): &Element {
    abort 404
}

public fun borrow_with_default<Element>(option: &Option<Element>, default_ref: &Element): &Element {
    abort 404
}

public fun get_with_default<Element: copy + drop>(option: &Option<Element>, default: Element): Element {
    abort 404
}

public fun borrow_mut<Element>(option: &mut Option<Element>): &mut Element {
    abort 404
}

public fun destroy_with_default<Element: drop>(option: Option<Element>, default: Element): Element {
    abort 404
}

public fun destroy_some<Element>(option: Option<Element>): Element {
    abort 404
}

public fun destroy_none<Element>(option: Option<Element>) {
    abort 404
}

public fun assert_none<Element>(option: &Option<Element>) {
    abort 404
}

public fun assert_some<Element>(option: &Option<Element>) {
    abort 404
}

public fun from_std<Element>(option: std::option::Option<Element>): Option<Element> {
    abort 404
}

public fun copy_from_std<Element: copy>(option: &std::option::Option<Element>): Option<Element> {
    abort 404
}

public fun to_std<Element>(option: Option<Element>): std::option::Option<Element> {
    abort 404
}
