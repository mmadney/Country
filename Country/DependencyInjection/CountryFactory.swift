//
//  CountryFactory.swift
//  Country
//
//  Created by Madney on 14/11/2025.
//

import Factory
import Foundation

extension Container {
    // MARK: DataLayer --------------------------------------------------------------------------------------

    // Remote DataSource
    var countryRemoteDataSource: Factory<CountryRemoteDataSource> {
        self { CountryRemoteDataSourceImp() }
    }

    // Local DataSource
    var countryLocalStore: Factory<CountryLocalStore> {
        self { CountryLocalStore() }
    }

    var countryRemoteLocalStore: Factory<CountryRemoteLocalStore> {
        self { CountryRemoteLocalStore() }
    }

    // Location Service
    var locationService: Factory<LocationService> {
        self { LocationService() }
    }

    // MARK: DomianLayer --------------------------------------------------------------------------------------

    // Repositories
    var countryRepository: Factory<CountryRepository> {
        self {
            CountryRepositoryImpl(api: self.countryRemoteDataSource(),
                                  localSavedData: self.countryLocalStore(),
                                  remoteSavedData: self.countryRemoteLocalStore(),
                                  locationService: self.locationService())
        }
    }

    // --------------------------------------------------------------------------------------
    // UseCases
    var fetchAllCountriesUseCase: Factory<FetchAllCountriesUseCase> {
        self {
            FetchAllCountriesUseCase(repo: self.countryRepository())
        }
    }

    var searchCountryUseCase: Factory<SearchCountryUseCase> {
        self {
            SearchCountryUseCase()
        }
    }

    var getCountryByLocationUseCase: Factory<GetCountryByLocationUseCase> {
        self {
            GetCountryByLocationUseCase()
        }
    }

    var getUserLocationUseCase: Factory<GetUserLocationUseCase> {
        self {
            GetUserLocationUseCase(repo: self.countryRepository())
        }
    }

    var getDefaultCountryUseCase: Factory<GetDefaultCountryUseCase> {
        self {
            GetDefaultCountryUseCase(repo: self.countryRepository())
        }
    }

    var getLocationCountryUseCase: Factory<GetCountryFromLocationAndSetDefualtUseCase> {
        self {
            GetCountryFromLocationAndSetDefualtUseCase(getUserLocationUseCase: self.getUserLocationUseCase(),
                                      countryByLocationUseCase: self.getCountryByLocationUseCase(),
                                      getDefaultCountryUseCase: self.getDefaultCountryUseCase())
        }
    }

    var savedCountryOperationUseCase: Factory<SavedCountryOperationUseCase> {
        self {
            SavedCountryOperationUseCase(repo: self.countryRepository())
        }
    }
    
    var addTopNearestLocationCountryUseCase: Factory<AddTopNearestLocationCountryUseCase> {
        self {
            AddTopNearestLocationCountryUseCase()
        }
    }
}
