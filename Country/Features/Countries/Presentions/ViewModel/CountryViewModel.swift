//
//  CountryViewModel.swift
//  Country
//
//  Created by Madney on 14/11/2025.
//

import Combine
import CoreLocation
import Factory
import Foundation

@MainActor
final class CountryViewModel: ObservableObject {
    @Published var allCountries: [Country] = []
    @Published var savedCountries: [Country] = []
    @Published var searchQuery: String = ""
    @Published var searchResults: [Country] = []
    @Published var errorMessage: String?

    @LazyInjected(\.fetchAllCountriesUseCase) var fetchAllCountriesUseCase
    @LazyInjected(\.getLocationCountryUseCase) var getLocationCountryUseCase
    @LazyInjected(\.savedCountryOperationUseCase) var savedCountryOperationUseCase
    @LazyInjected(\.addTopNearestLocationCountryUseCase) var addTopNearestLocationCountryUseCase

    let maxSaved = 5

    // Fetch all from API
    // Load saved items
    // If the list is empty → auto-add based on location
    func onAppear() async {
        do {
            let countries = try await fetchAllCountriesUseCase.execute()
            if let nearestCountry = await getLocationCountryUseCase.execute(all: countries) {
                allCountries = addTopNearestLocationCountryUseCase.execute(country: nearestCountry, countries: countries)
                searchResults = allCountries
            }

            savedCountries = await savedCountryOperationUseCase.getSavedCountry()
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func search() {
        searchResults = searchQuery.isEmpty
            ? allCountries
            : allCountries.filter { $0.name.lowercased().contains(searchQuery.lowercased()) }
    }

    func addCountry(_ country: Country) async {
        guard savedCountries.count < maxSaved else {
            errorMessage = "You have reached the maximum number of saved countries."
            return
        }

        await savedCountryOperationUseCase.save(country: country)
        savedCountries.append(country)
    }

    func remove(_ country: Country) async {
        await savedCountryOperationUseCase.remove(country: country)
        savedCountries.removeAll { $0.id == country.id }
    }

    func showAddButton(for country: Country) -> Bool {
        return !savedCountries.contains(where: { $0.id == country.id })
    }
}
