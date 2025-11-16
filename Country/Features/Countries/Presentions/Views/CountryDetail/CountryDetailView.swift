//
//  CountryDetailView.swift
//  Country
//
//  Created by Madney on 15/11/2025.
//

import SwiftUI

struct CountryDetailView: View {
    let country: Country

    var body: some View {
        VStack(alignment: .center, spacing: 50) {
            AsyncImage(url: URL(string: country.flagURL)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5)
            } placeholder: {
                ProgressView()
                    .frame(height: 200)
            }

            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .center, spacing: 10) {
                    Text("Capital:")
                        .customFont(.title1, ThemeColor.gray)

                    Text(country.capital)
                        .customFont(.title1)
                }

                HStack(alignment: .center, spacing: 10) {
                    Text("Currency:")
                        .customFont(.title1, ThemeColor.gray)

                    Text(country.currencyName)
                        .customFont(.title1)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal , 16)
        .navigationTitle(country.name)
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    CountryDetailView(country: Country.sampleBrunei)
}
