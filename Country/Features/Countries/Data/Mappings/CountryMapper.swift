//
//  CountryMapper.swift
//  Country
//
//  Created by Madney on 14/11/2025.
//

import Foundation

extension CountryDTO {
    func toDomain() -> Country {
        let currencyKey = currencies?.keys.first
        let currency = currencyKey.flatMap { currencies?[$0] }

        return Country(
            id: name.common,
            name: name.common,
            officialName: name.official,
            capital: capital?.first ?? "Unknown",
            currencyCode: currencyKey ?? "",
            currencyName: currency?.name ?? "",
            flagURL: flags.png,
            latitude: latlng?.first ?? 0,
            longitude: latlng?.last ?? 0
        )
    }
}
