import CoreLocation
import Foundation

protocol CountryRepository {
    func fetchAll() async throws -> [Country]
    func loadLocalCountries() async -> [Country]
    func removeLocalCountry(country: Country) async
    func addLocalCountry(country: Country) async
    func getUserLocation() async throws -> CLLocationCoordinate2D
}
