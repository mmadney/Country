//
//  CountryRow.swift
//  Country
//
//  Created by Madney on 15/11/2025.
//

import SwiftUI

struct CountryRow: View {
    let country: Country
    var showDeleteButton: Bool
    var showAddButton: Bool
    var saveCountry: ((Country) -> Void)? = nil
    var removeCountry: ((Country) -> Void)? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(alignment: .center, spacing: 10) {
                AsyncImage(url: URL(string: country.flagURL)) { image in
                    image
                        .resizable()
                        .frame(width: 60, height: 40)
                        .scaledToFill()
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                        .frame(width: 60, height: 40)
                }

                Text(country.name)
                    .customFont(.label1)

                Spacer()

                if showAddButton {
                    Button {
                        saveCountry?(country)
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    .buttonStyle(.borderless)
                }

                if showDeleteButton {
                    Button(role: .destructive) {
                        removeCountry?(country)
                    } label: {
                        Image(systemName: "trash")
                            .font(.title2)
                            .foregroundColor(.red)
                    }
                    .buttonStyle(.borderless)
                }
            }
        }
    }
}

#Preview {
    CountryRow(country: Country.sampleNZ,
               showDeleteButton: true,
               showAddButton: true,
               saveCountry: { _ in

    }) { _ in
    }
}
