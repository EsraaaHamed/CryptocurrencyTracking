//
//  Coins.swift
//  CryptocurrencyTracking
//
//  Created by Israa hamed on 28/12/2024.
//
import Foundation

struct Coins: Codable{
    let coins: [Coin]
}

struct Coin: Codable{
    let id: String
    let name: String
    let symbol: String
}
