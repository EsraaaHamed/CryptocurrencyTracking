//
//  ContentView.swift
//  CryptocurrencyTracking
//
//  Created by Israa hamed on 22/12/2024.
//

import SwiftUI

struct CryptocurrencyTabView: View {
    @EnvironmentObject var favoriteCryptocurrency: FavoriteCryptocurrencies
    @StateObject var cryptocurrencyPricelistviewModel = CryptocurrencyPricelistViewModel(networkManager: NetworkManager())
    init() {
    }
    var body: some View {
        TabView {
            CryptocurrencyPricelistView(viewModel: cryptocurrencyPricelistviewModel).tabItem {Label("Price List", systemImage: "house") }
            FavoriteCryptocurrencyView().tabItem {Label("Favorite", systemImage: "heart") }
        }.onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)){ _ in
            print("willTerminateNotification recieved")
            CachingManager.shared.cachFavorites(favoriteCryptocurrency.favoriteCryptocurrencies)
            print("cache list:\(favoriteCryptocurrency.favoriteCryptocurrencies.map{$0.id})")
        }.onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            print("didEnterBackgroundNotification recieved")
            CachingManager.shared.cachFavorites(favoriteCryptocurrency.favoriteCryptocurrencies)
            print("cache list:\(favoriteCryptocurrency.favoriteCryptocurrencies.map{$0.id})")
        }
    }
}

#Preview {
    CryptocurrencyTabView()
}
