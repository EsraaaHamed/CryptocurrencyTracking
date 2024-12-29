//
//  FavoriteCryptocurrencyView.swift
//  CryptocurrencyTracking
//
//  Created by Israa hamed on 22/12/2024.
//

import SwiftUI

struct FavoriteCryptocurrencyView: View {
    @EnvironmentObject var favoriteCryptocurrencies: FavoriteCryptocurrencies
    var body: some View {
        ZStack {
            if favoriteCryptocurrencies.favoriteCryptocurrencies.isEmpty {
                FavoriteEmptyState()
            } else {
                VStack {
                    List {
                        ForEach(favoriteCryptocurrencies.favoriteCryptocurrencies, id: \.id) { favoriteCryptocurrency in
                            
                            CryptocurrencyListViewCell(cryptocurrency: favoriteCryptocurrency).listRowSeparator(.hidden)
                            
                        }
                    }.navigationTitle("Favorites")
                        .listStyle(PlainListStyle())
                }
            }
        }
    }
}

struct FavoriteCryptocurrencyViewPreviews: PreviewProvider {
    static var previews: some View {
        FavoriteCryptocurrencyView()
    }
}
