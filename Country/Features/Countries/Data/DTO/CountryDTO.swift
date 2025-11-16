//
//  CountryDTO.swift
//  Country
//
//  Created by Madney on 14/11/2025.
//

import Foundation

struct CountryDTO: Decodable {
    let flags: FlagsDTO
    let name: NameDTO
    let currencies: [String: CurrencyDTO]?
    let capital: [String]?
    let latlng: [Double]?
}

struct FlagsDTO: Decodable {
    let png: String
    let svg: String?
    let alt: String?
}

struct NameDTO: Decodable {
    let common: String
    let official: String
    let nativeName: [String: NativeNameDTO]?
}

struct NativeNameDTO: Decodable {
    let official: String
    let common: String
}

struct CurrencyDTO: Decodable {
    let name: String
    let symbol: String?
}
