//
//  CountryViewModelTest.swift
//  CountryTests
//
//  Created by Madney on 16/11/2025.
//

@testable import Country
import Testing
import XCTest

@MainActor
final class CountryViewModelTest: XCTestCase {
    private var sut: CountryViewModel!

    override func setUp() {
        super.setUp()
        sut = CountryViewModel()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testAddCountry_ReachToLimit() async {
        await sut.addCountry(Country.egypt)
        await sut.addCountry(Country.sampleNZ)
        await sut.addCountry(Country.sampleSyria)
        await sut.addCountry(Country.sampleBrunei)
        await sut.addCountry(Country.sampleNZ)
        await sut.addCountry(Country.sampleNZ)

        XCTAssertEqual(sut.savedCountries.count, sut.maxSaved)
        XCTAssertEqual(sut.errorMessage, "You have reached the maximum number of saved countries.")

        await sut.remove(Country.sampleSyria)
        await sut.remove(Country.sampleBrunei)

        XCTAssertEqual(sut.savedCountries.count, sut.maxSaved - 2)
    }

    func testSearch_WhenQueryIsEmpty_ReturnsAllCountries() {
        sut.allCountries = [.egypt, .sampleNZ, .sampleSyria]
        sut.searchQuery = ""
        sut.search()
        XCTAssertEqual(sut.searchResults, sut.allCountries)
    }

    func testSearch_WhenQueryMatchesOneCountry_ReturnsThatCountry() {
        sut.allCountries = [.egypt, .sampleNZ, .sampleSyria]
        sut.searchQuery = "egy"

        sut.search()

        XCTAssertEqual(sut.searchResults.count, 1)
        XCTAssertEqual(sut.searchResults.first, .egypt)
    }

    func testSearch_IsCaseInsensitive() {
        sut.allCountries = [.egypt, .sampleNZ, .sampleSyria]
        sut.searchQuery = "SYR"

        sut.search()

        XCTAssertEqual(sut.searchResults.count, 1)
        XCTAssertEqual(sut.searchResults.first, .sampleSyria)
    }

    func testSearch_WhenNoMatch_ReturnsEmptyArray() {
        sut.allCountries = [.egypt, .sampleNZ, .sampleSyria]
        sut.searchQuery = "xyz"

        sut.search()

        XCTAssertTrue(sut.searchResults.isEmpty)
    }

    func testShowAddButton_ReturnsFalse_WhenCountryAlreadySaved() {
        sut.savedCountries = [.egypt]

        let result = sut.showAddButton(for: .egypt)

        XCTAssertFalse(result)
    }

    func testShowAddButton_ReturnsTrue_WhenCountryNotSaved() {
        sut.savedCountries = [.egypt]

        let result = sut.showAddButton(for: .sampleNZ)

        XCTAssertTrue(result)
    }
}
