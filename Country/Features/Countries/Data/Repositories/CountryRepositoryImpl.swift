import CoreLocation
import Foundation

final class CountryRepositoryImpl: CountryRepository {
    private let api: CountryRemoteDataSource
    private let localSavedData: CountryLocalStore
    private let remoteSavedData: CountryRemoteLocalStore
    private let locationService: LocationService

    init(api: CountryRemoteDataSource, localSavedData: CountryLocalStore, remoteSavedData: CountryRemoteLocalStore, locationService: LocationService) {
        self.api = api
        self.localSavedData = localSavedData
        self.remoteSavedData = remoteSavedData
        self.locationService = locationService
    }

    func fetchAll() async throws -> [Country] {
        let countries = await loadRemoteCountries()
        if countries.isEmpty {
            let dtos = try await api.getCountries()
            let domains = dtos.map { $0.toDomain() }
            // save to local for offline
            await saveRemoteCountries(domains)
            return domains
        } else {
            return countries
        }
    }

    private func saveRemoteCountries(_ countries: [Country]) async {
        remoteSavedData.save(countries)
    }

    private func loadRemoteCountries() async -> [Country] {
        remoteSavedData.load()
    }

    func saveLocalCountries(_ countries: [Country]) async {
        localSavedData.save(countries)
    }

    func loadLocalCountries() async -> [Country] {
        localSavedData.load()
    }

    func removeLocalCountry(country: Country) async {
        var countries = await loadLocalCountries()
        countries.removeAll { $0.id == country.id }
        await saveLocalCountries(countries)
    }

    func addLocalCountry(country: Country) async {
        var countries = await loadLocalCountries()
        countries.append(country)
        await saveLocalCountries(countries)
    }

    func getUserLocation() async throws -> CLLocationCoordinate2D {
        let location = try await locationService.requestLocation()
        return location.coordinate
    }
}
