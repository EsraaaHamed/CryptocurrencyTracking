//
//  CachingManager.swift
//  CryptocurrencyTracking
//
//  Created by Israa hamed on 28/12/2024.
//
import Foundation

class CachingManager {
    static let shared = CachingManager()
    private let cacheImage = NSCache<NSString, NSData>()
    
    private init() {}
    
    func setCachedImage(_ imageData: Data, forKey key: String) {
        cacheImage.setObject(imageData as NSData, forKey: key as NSString)
    }
    
    func getcahedImage(forKey key: String) -> Data? {
        cacheImage.object(forKey: key as NSString) as Data?
    }
    
    func cachFavorites(_ favoriteCryptocurrencies: [Cryptocurrency]) {
        DispatchQueue.global(qos: .background).async {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(favoriteCryptocurrencies) {
                UserDefaults.standard.set(encoded, forKey: AppConstants.favoriteCryptocurrencies)
            }
        }
    }
    
    func getCachedFavorites() -> [Cryptocurrency]? {
        let decoder = JSONDecoder()
        
        if let decoded = UserDefaults.standard.data(forKey: AppConstants.favoriteCryptocurrencies), let decoderResult = try? decoder.decode([Cryptocurrency].self, from: decoded) {
            return decoderResult
        }
        
        return nil;
    }
    
}
