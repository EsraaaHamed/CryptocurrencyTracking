//
//  Cryptocurrency.swift
//  CryptocurrencyTracking
//
//  Created by Israa hamed on 22/12/2024.
//

import Foundation

struct Cryptocurrency: Codable, Identifiable, Equatable {
    let id: String
    let symbol: String
    let name: String
    let image: URL
    let currentPrice: Double
    let marketCap: Double
    let priceChange24h: Double?
    let priceChangePercentage24h: Double?

    enum CodingKeys: String, CodingKey {
           case id
           case symbol
           case name
           case image
           case currentPrice = "current_price"
           case marketCap = "market_cap"
           case priceChange24h = "price_change_24h"
           case priceChangePercentage24h = "price_change_percentage_24h"
       }
}

struct CryptocurrencyMockedData {
    static let cryptocurrencyMockedData = Cryptocurrency(id: "bitcoin", symbol: "btc", name: "Bitcoin", image: URL(string:"https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400")!, currentPrice: 70187, marketCap: 1381651251183, priceChange24h: 2126.88, priceChangePercentage24h: 3.12502)
}
