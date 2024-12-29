//
//  FavorieCryptocurrencies.swift
//  CryptocurrencyTracking
//
//  Created by Israa hamed on 26/12/2024.
//
import SwiftUI
import Combine
class FavoriteCryptocurrencies: ObservableObject {
    @Published var favoriteCryptocurrencies: [Cryptocurrency] = []
    private var disposables = Set<AnyCancellable>()

    init() {
        loadCachedFavoriteCryptocurrencies()
    }
    
    func loadCachedFavoriteCryptocurrencies() {
        self.favoriteCryptocurrencies = CachingManager.shared.getCachedFavorites() ?? []
        print("load fave: ",favoriteCryptocurrencies.map{$0.id})

    }
    
    func addFavoriteCryptocurrency(cryptocurrency: Cryptocurrency) {
        if (!favoriteCryptocurrencies.contains(cryptocurrency)) {
            favoriteCryptocurrencies.append(cryptocurrency)
            print("add to fav: ",favoriteCryptocurrencies.map{$0.id})
        }
    }
    
    func unFavoriteCryptocurrency(cryptocurrency: Cryptocurrency) {
        favoriteCryptocurrencies.removeAll { $0.id == cryptocurrency.id }
        print("remove from fav: ",favoriteCryptocurrencies.map{$0.id})
    }
    
    func contains(cryptocurrency: Cryptocurrency) -> Bool {
        return self.favoriteCryptocurrencies.contains(where: { $0.id == cryptocurrency.id })
    }
    
    func toggleFav(cryptocurrency: Cryptocurrency) {
        if self.favoriteCryptocurrencies.contains(where: { $0.id == cryptocurrency.id }) {
            self.unFavoriteCryptocurrency(cryptocurrency: cryptocurrency)
        } else {
            self.addFavoriteCryptocurrency(cryptocurrency: cryptocurrency)
        }
    }
    
    
}
