import Foundation

protocol CountryRemoteDataSource {
    func getCountries() async throws -> [CountryDTO]
}

final class CountryRemoteDataSourceImp: NetworkApi, CountryRemoteDataSource {
    var session: URLSession

    init() {
        session = URLSession(configuration: .default)
    }

    func getCountries() async throws -> [CountryDTO] {
        return try await fetch(type: [CountryDTO].self, with: CountryAPIRequest.fetchAllCountries)
    }
}
