import Foundation

final class CountryLocalStore {
    private let key = "saved_countries_v1"

    func save(_ countries: [Country]) {
        do {
            let data = try JSONEncoder().encode(countries)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print("Failed to save countries: \(error)")
        }
    }

    func load() -> [Country] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            return try JSONDecoder().decode([Country].self, from: data)
        } catch {
            print("Failed to decode countries: \(error)")
            return []
        }
    }
}


final class CountryRemoteLocalStore {
    private let key = "saved_countries_v2"

    func save(_ countries: [Country]) {
        do {
            let data = try JSONEncoder().encode(countries)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print("Failed to save countries: \(error)")
        }
    }

    func load() -> [Country] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            return try JSONDecoder().decode([Country].self, from: data)
        } catch {
            print("Failed to decode countries: \(error)")
            return []
        }
    }
}
