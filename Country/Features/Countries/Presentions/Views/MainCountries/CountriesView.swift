//
//  ContentView.swift
//  Country
//
//  Created by Madney on 14/11/2025.
//

import SwiftUI

struct CountriesView: View {
    @StateObject private var viewModel = CountryViewModel()
    @State private var selectedCountry: Country?

    var body: some View {
        NavigationStack {
            List {
                if !viewModel.savedCountries.isEmpty {
                    Section("Saved Countries (\(viewModel.savedCountries.count)/5)") {
                        ForEach(viewModel.savedCountries) { country in
                            CountryRow(country: country, showDeleteButton: true, showAddButton: false, removeCountry: { country in
                                Task {
                                    await viewModel.remove(country)
                                }

                            })
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedCountry = country
                            }
                        }
                    }
                }

                Section("All Countries") {
                    ForEach(viewModel.searchResults) { country in
                        CountryRow(country: country, showDeleteButton: false, showAddButton: viewModel.showAddButton(for: country), saveCountry: { country in
                            Task {
                                await viewModel.addCountry(country)
                            }
                        })
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedCountry = country
                        }
                    }
                }
            }
            .navigationTitle("Countries")
            .task {
                await viewModel.onAppear()
            }
            .searchable(text: $viewModel.searchQuery, placement: .navigationBarDrawer(displayMode: .automatic))
            .navigationDestination(item: $selectedCountry) { country in
                CountryDetailView(country: country)
            }
            .onChange(of: viewModel.searchQuery) {
                viewModel.search()
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil), actions: {
                Button("OK") { viewModel.errorMessage = nil }
            }, message: {
                Text(viewModel.errorMessage ?? "")
            })
        }
    }
}

#Preview {
    CountriesView()
}
