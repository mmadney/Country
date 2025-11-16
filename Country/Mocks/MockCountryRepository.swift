//
//  MockCountryRepository.swift
//  Country
//
//  Created by Madney on 16/11/2025.
//

import CoreLocation
import Foundation

final actor MockCountryRepository: CountryRepository {
    private let countriesToReturn: [Country]
    private var savedCountries: [Country] = []
    private let locationToReturn: CLLocationCoordinate2D?

    init(
        countries: [Country],
        locationToReturn: CLLocationCoordinate2D? = nil
    ) {
        countriesToReturn = countries
        self.locationToReturn = locationToReturn
    }

    func fetchAll() async throws -> [Country] {
        countriesToReturn
    }

    func loadLocalCountries() async -> [Country] {
        savedCountries
    }

    func removeLocalCountry(country: Country) async {
        savedCountries.removeAll { $0.id == country.id }
    }

    func addLocalCountry(country: Country) async {
        savedCountries.append(country)
    }

    func getUserLocation() async throws -> CLLocationCoordinate2D {
        if let locationToReturn {
                   return locationToReturn
               } else {
                   throw NSError(domain: "Location", code: 1, userInfo: nil)
               }
    }
}
