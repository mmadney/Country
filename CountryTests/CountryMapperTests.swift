//
//  CountryMapperTests.swift
//  CountryTests
//
//  Created by Madney on 16/11/2025.
//

import XCTest
@testable import Country

final class CountryMapperTests: XCTestCase {

    func test_toDomain_mapsAllFieldsCorrectly() {
        let dto = CountryDTO(
            flags: FlagsDTO(png: "https://flagcdn.com/w320/eg.png", svg: nil, alt: nil),
            name: NameDTO(
                common: "Egypt",
                official: "Arab Republic of Egypt",
                nativeName: nil
            ),
            currencies: [
                "EGP": CurrencyDTO(name: "Egyptian pound", symbol: "E£")
            ],
            capital: ["Cairo"],
            latlng: [26.0, 30.0]
        )

        
        let domain = dto.toDomain()

        XCTAssertEqual(domain.id, "Egypt")
        XCTAssertEqual(domain.name, "Egypt")
        XCTAssertEqual(domain.officialName, "Arab Republic of Egypt")
        XCTAssertEqual(domain.capital, "Cairo")
        XCTAssertEqual(domain.currencyCode, "EGP")
        XCTAssertEqual(domain.currencyName, "Egyptian pound")
        XCTAssertEqual(domain.flagURL, "https://flagcdn.com/w320/eg.png")
        XCTAssertEqual(domain.latitude, 26.0)
        XCTAssertEqual(domain.longitude, 30.0)
    }

    func test_toDomain_usesFallbacksWhenOptionalDataMissing() {
        let dto = CountryDTO(
            flags: FlagsDTO(png: "https://flagcdn.com/w320/xx.png", svg: nil, alt: nil),
            name: NameDTO(
                common: "Nowhere Land",
                official: "Nowhere Land Official",
                nativeName: nil
            ),
            currencies: nil,
            capital: nil,
            latlng: nil
        )


        let domain = dto.toDomain()


        XCTAssertEqual(domain.id, "Nowhere Land")
        XCTAssertEqual(domain.name, "Nowhere Land")
        XCTAssertEqual(domain.officialName, "Nowhere Land Official")
        XCTAssertEqual(domain.capital, "Unknown")
        XCTAssertEqual(domain.currencyCode, "")
        XCTAssertEqual(domain.currencyName, "")
        XCTAssertEqual(domain.flagURL, "https://flagcdn.com/w320/xx.png")
        XCTAssertEqual(domain.latitude, 0)
        XCTAssertEqual(domain.longitude, 0)
    }
}
