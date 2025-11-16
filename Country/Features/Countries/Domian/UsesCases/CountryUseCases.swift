import CoreLocation
import Foundation

final class FetchAllCountriesUseCase {
    private let repo: CountryRepository

    init(repo: CountryRepository) {
        self.repo = repo
    }

    // fetch all countries from repository
    func execute() async throws -> [Country] {
        try await repo.fetchAll()
    }
}

final class SearchCountryUseCase {
    // search countries by name
    func execute(all: [Country], query: String) -> [Country] {
        guard !query.isEmpty else { return all }
        return all.filter { $0.name.lowercased().contains(query.lowercased()) }
    }
}

final class GetCountryByLocationUseCase {
    // paramter countries array of countries
    // parameter userLat user latitude
    // get nerest country to user location
    func execute(countries: [Country], userLat: Double, userLon: Double) -> Country {
        countries.min(by: { dist($0, userLat, userLon) < dist($1, userLat, userLon) })!
    }

    // paramter c country to get distance betwen lat lng and country lat lng
    // parameter lat to latitude
    // get nerest lng to  longitude
    private func dist(_ c: Country, _ lat: Double, _ lon: Double) -> Double {
        let l1 = CLLocation(latitude: lat, longitude: lon)
        let l2 = CLLocation(latitude: c.latitude, longitude: c.longitude)
        return l1.distance(from: l2)
    }
}

final class GetUserLocationUseCase {
    private let repo: CountryRepository

    init(repo: CountryRepository) {
        self.repo = repo
    }

    // get user location from repository
    func execute() async throws -> CLLocationCoordinate2D {
        return try await repo.getUserLocation()
    }
}

final class GetDefaultCountryUseCase {
    private let repo: CountryRepository

    init(repo: CountryRepository) {
        self.repo = repo
    }

    // get default country from country array
    func execute(all: [Country]) -> Country? {
        all.first(where: { $0.name == Constants.defaultCountryName })
    }
}

final class GetCountryFromLocationAndSetDefualtUseCase {
    private let getUserLocationUseCase: GetUserLocationUseCase
    private let countryByLocationUseCase: GetCountryByLocationUseCase
    private let getDefaultCountryUseCase: GetDefaultCountryUseCase

    init(
        getUserLocationUseCase: GetUserLocationUseCase,
        countryByLocationUseCase: GetCountryByLocationUseCase,
        getDefaultCountryUseCase: GetDefaultCountryUseCase
    ) {
        self.getUserLocationUseCase = getUserLocationUseCase
        self.countryByLocationUseCase = countryByLocationUseCase
        self.getDefaultCountryUseCase = getDefaultCountryUseCase
    }

    // nearest country from user location if fail get default country
    func execute(all: [Country]) async -> Country? {
        do {
            let location = try await getUserLocationUseCase.execute()
            return countryByLocationUseCase.execute(countries: all, userLat: location.latitude, userLon: location.longitude)
        } catch {
            return getDefaultCountryUseCase.execute(all: all)
        }
    }
}

final class AddTopNearestLocationCountryUseCase {
    func execute(country: Country, countries: [Country]) -> [Country] {
        var resultCountries = countries
        resultCountries.removeAll { $0.id == country.id }
        return [country] + resultCountries
    }
}

final class SavedCountryOperationUseCase {
    private let repo: CountryRepository

    init(repo: CountryRepository) {
        self.repo = repo
    }

    // save country to local storage
    func save(country: Country) async {
        await repo.addLocalCountry(country: country)
    }

    // remove country from local storage
    func remove(country: Country) async {
        await repo.removeLocalCountry(country: country)
    }

    // get saved country from local storage
    func getSavedCountry() async -> [Country] {
        await repo.loadLocalCountries()
    }
}
