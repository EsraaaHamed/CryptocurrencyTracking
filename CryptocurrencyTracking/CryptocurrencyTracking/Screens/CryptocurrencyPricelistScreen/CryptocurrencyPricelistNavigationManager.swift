//
//  Untitled.swift
//  CryptocurrencyTracking
//
//  Created by Israa hamed on 28/12/2024.
//

struct CryptocurrencyPricelistNavigationManager {
    static func getDetailsScreenVM(cryptocurrency: Cryptocurrency) -> CryptocurrencyDetailsViewModel {
        return CryptocurrencyDetailsViewModel(cryptocurrency: cryptocurrency, networkManager: NetworkManager())
    }
}
