//
//  CountryTests.swift
//  CountryTests
//
//  Created by Madney on 14/11/2025.
//

import CoreLocation
@testable import Country
import Testing
import XCTest

final class CountryUseCasesTests: XCTestCase {
    // MARK: - Helpers

    private var allCountries: [Country]!

    override func setUp() {
        super.setUp()
        allCountries = Country.countries
        XCTAssertFalse(allCountries.isEmpty, "Sample countries should not be empty")
    }

    // MARK: - SearchCountryUseCase

    func testSearchCountryUseCase_FindsMatchingCountries() {
        let useecase = SearchCountryUseCase()

        let results = useecase.execute(all: allCountries, query: "Bru")

        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(results.first?.id, Country.sampleBrunei.id)
    }

    func testSearchCountryUseCase_NoMatchingReturnAll() {
        let sut = SearchCountryUseCase()

        let results = sut.execute(all: allCountries, query: "")

        XCTAssertEqual(results.count, allCountries.count)
    }

    // MARK: - GetCountryByLocationUseCase

    func testGetCountryByLocationUseCase_returnsNearestCountry() {
        let sut = GetCountryByLocationUseCase()

        let lat = Country.sampleNZ.latitude + 0.1
        let lon = Country.sampleNZ.longitude + 0.1

        let result = sut.execute(countries: allCountries, userLat: lat, userLon: lon)

        XCTAssertEqual(result.id, Country.sampleNZ.id)
    }

    // MARK: - GetCountryFromLocationAndSetDefualtUseCase

    func testGetCountryFromLocationAndSetDefualtUseCaseWhengetLocationNilOrNotPermission() async {
        let repo = MockCountryRepository(countries: allCountries,
                                         locationToReturn: nil)

        let userLocationUseCase = GetUserLocationUseCase(repo: repo)
        let countryByLocationUseCase = GetCountryByLocationUseCase()
        let defaultCountryUseCase = GetDefaultCountryUseCase(repo: repo)
        let sut = GetCountryFromLocationAndSetDefualtUseCase(getUserLocationUseCase: userLocationUseCase,
                                                             countryByLocationUseCase: countryByLocationUseCase,
                                                             getDefaultCountryUseCase: defaultCountryUseCase)

        let result = await sut.execute(all: allCountries)

        XCTAssertNotNil(result)
        XCTAssertEqual(result?.id, Constants.defaultCountryName)
    }

    func testGetLocationCountryUseCaseWhenCannotGetLocationCountry() async {
        let repo = MockCountryRepository(countries: allCountries,
                                         locationToReturn: Country.sampleNZ.coordinate)

        let userLocationUseCase = GetUserLocationUseCase(repo: repo)
        let countryByLocationUseCase = GetCountryByLocationUseCase()
        let defaultCountryUseCase = GetDefaultCountryUseCase(repo: repo)
        let sut = GetCountryFromLocationAndSetDefualtUseCase(getUserLocationUseCase: userLocationUseCase,
                                                             countryByLocationUseCase: countryByLocationUseCase,
                                                             getDefaultCountryUseCase: defaultCountryUseCase)

        let result = await sut.execute(all: allCountries)

        XCTAssertNotNil(result)
        XCTAssertEqual(result?.id, Country.sampleNZ.id)
    }

    // MARK: - AddTopNearestLocationCountryUseCase

    func testAddInTopLocationCountryUseCase() {
        let sut = AddTopNearestLocationCountryUseCase()

        let result = sut.execute(country: Country.sampleSyria, countries: allCountries)

        XCTAssertEqual(result.first, Country.sampleSyria)
    }

    // MARK: - SavedCountryOperationUseCase
    func testSavedCountryOperationUseCase() async {
        let repo = MockCountryRepository(countries: allCountries,
                                         locationToReturn: nil)
        let sut = SavedCountryOperationUseCase(repo: repo)

        await sut.save(country: Country.egypt)
        await sut.save(country: Country.sampleNZ)

        var results = await sut.getSavedCountry()
        XCTAssertEqual(results.count, 2)

        await sut.remove(country: Country.egypt)

        results = await sut.getSavedCountry()
        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(results.first?.id, Country.sampleNZ.id)
    }
}
