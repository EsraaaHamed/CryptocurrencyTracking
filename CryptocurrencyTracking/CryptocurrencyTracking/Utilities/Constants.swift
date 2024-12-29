//
//  Constants.swift
//  CryptocurrencyTracking
//
//  Created by Israa hamed on 24/12/2024.
//

class APIConstants {
    static let baseURL = "https://api.coingecko.com/api/v3/"
    static let getAllCoinsEndPoint = "coins/markets"
    static let searchCoinsEndPoint = "search"
    static let apiKeyValue = "CG-ZRaSKzeThaPFfa8uZ9hRQET5"
    static let apiKeyHeaderKey = "x_cg_demo_api_key"
    static let targetMarketQueryParamKey = "vs_currency"
    static let targetMarketQueryParamValue = "usd"

}

class AppConstants {
    static let favoriteCryptocurrencies = "favoriteCryptocurrencies"
}

class ImageNameConstants {
    static let favoriteImageName = "favorite"
    static let unfavoriteImageName = "unfavorite"
    static let coinDetailsplaceholderImageName = "placeholderImage"
    static let coinCellPlaceholderImageName = "placeholderImage"
    static let priceListeEmptyState = "money-exchange"
}
