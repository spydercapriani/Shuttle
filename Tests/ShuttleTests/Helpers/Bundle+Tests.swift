//
//  Bundle+Tests.swift
//  ShuttleTests
//

import Foundation

extension Bundle {
    static let tests = Bundle(for: BundleTag.self)
}

private final class BundleTag {}
