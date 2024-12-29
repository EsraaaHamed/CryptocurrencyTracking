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
//    let marketCapRank: Double
//    let fullyDilutedValuation: Double?
//    let totalVolume: Double
//    let high24h: Double?
//    let low24h: Double?
    let priceChange24h: Double?
    let priceChangePercentage24h: Double?
//    let marketCapChange24h: Double?
//    let marketCapChangePercentage24h: Double?
//    let circulatingSupply: Double?
//    let totalSupply: Double?
//    let maxSupply: Double?
//    let ath: Double?
//    let athChangePercentage: Double?
//    let athDate: String
//    let atl: Double
//    let atlChangePercentage: Double?
//    let atlDate: String?
//    let roi: String?
//    let lastUpdated: String?

}

struct CryptocurrencyMockedData {
    static let cryptocurrencyMockedData = Cryptocurrency(id: "bitcoin", symbol: "btc", name: "Bitcoin", image: URL(string:"https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400")!, currentPrice: 70187, marketCap: 1381651251183, priceChange24h: 2126.88, priceChangePercentage24h: 3.12502)
}
