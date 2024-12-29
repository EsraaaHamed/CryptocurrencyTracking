//
//  CryptocurrencyTrackingApp.swift
//  CryptocurrencyTracking
//
//  Created by Israa hamed on 22/12/2024.
//

import SwiftUI
@main

struct CryptocurrencyTrackingApp: App {
    @StateObject var favoriteCryptocurrencies = FavoriteCryptocurrencies()
    var body: some Scene {
        WindowGroup {
            CryptocurrencyTabView().environmentObject(favoriteCryptocurrencies)

        }
    }
}


