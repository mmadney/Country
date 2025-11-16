import CoreLocation
import Foundation

struct Country: Identifiable, Codable, Equatable , Hashable {
    let id: String
    let name: String
    let officialName: String
    let capital: String
    let currencyCode: String
    let currencyName: String
    let flagURL: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    static let sampleSyria = Country(
        id: "Syria",
        name: "Syria",
        officialName: "Syrian Arab Republic",
        capital: "Damascus",
        currencyCode: "SYP",
        currencyName: "Syrian pound",
        flagURL: "https://flagcdn.com/w320/sy.png",
        latitude: 35.0,
        longitude: 38.0
    )

    static let sampleNZ = Country(
        id: "New Zealand",
        name: "New Zealand",
        officialName: "New Zealand",
        capital: "Wellington",
        currencyCode: "NZD",
        currencyName: "New Zealand dollar",
        flagURL: "https://flagcdn.com/w320/nz.png",
        latitude: -41.0,
        longitude: 174.0
    )

    static let sampleBrunei = Country(
        id: "Brunei",
        name: "Brunei",
        officialName: "Nation of Brunei, Abode of Peace",
        capital: "Bandar Seri Begawan",
        currencyCode: "BND",
        currencyName: "Brunei dollar",
        flagURL: "https://flagcdn.com/w320/bn.png",
        latitude: 4.5,
        longitude: 114.66666666
    )
    
    static let egypt = Country(
               id: "Egypt",
               name: "Egypt",
               officialName: "Arab Republic of Egypt",
               capital: "Cairo",
               currencyCode: "EGP",
               currencyName: "Egyptian pound",
               flagURL: "https://flagcdn.com/w320/eg.png",
               latitude: 26.0,
               longitude: 30.0
           )
    

    static let countries = [
        egypt,
        sampleSyria,
        sampleNZ,
        sampleBrunei
    ]
}
