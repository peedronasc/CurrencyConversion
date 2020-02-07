//
//  Currency.swift
//  CurrencyConversion
//
//  Created by Pedro Nascimento on 05/02/20.
//  Copyright © 2020 PedroNascimento. All rights reserved.
//

import Foundation

// MARK: - Currency
struct Currency: Codable {
    let rates: [String: Double]?
    let base,date: String?
}

// MARK: - Conversion
struct Conversions: Codable {
    var conversions: [Conversion]
}

// MARK: - Conversion
struct Conversion: Codable {
    var currencyFrom, currencyTo: String
    var oldValue, newValue: Double
}
