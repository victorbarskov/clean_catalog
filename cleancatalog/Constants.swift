//
//  Constants.swift
//  Dixi
//
//  Created by Victor Barskov on 18/04/2018.
//  Copyright © 2018 usetech. All rights reserved.
//

import Foundation

// Main keys
public let defaults = UserDefaults.standard
public var BaseURL = setBaseURL()

// Base URL
public let testURL = ""
public let prodURL = ""

// MARK: - Base URL -
public func setBaseURL() -> String {
    #if DEBUG
    // debug only code
        return testURL
    #else
    // release only code
         return prodURL
    #endif
}
