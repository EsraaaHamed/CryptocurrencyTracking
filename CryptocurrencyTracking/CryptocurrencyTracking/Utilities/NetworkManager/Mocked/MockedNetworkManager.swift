//
//  MockedNetworkManager.swift
//  CryptocurrencyTracking
//
//  Created by Israa hamed on 29/12/2024.
//
@testable import CryptocurrencyTracking
import Combine
import Foundation
class MockedNetworkManager: NetworkManager {
    var isSuccessful: Bool
    let decoder = JSONDecoder()
    init(isSuccessful: Bool) {
        self.isSuccessful = isSuccessful
        super.init()
    }
    
    override func getCryptocurrencyPriceList() -> AnyPublisher<[Cryptocurrency], APIError> {
        guard isSuccessful else  {
            return Fail(error: APIError.testingError).eraseToAnyPublisher()
        }

        
        guard let fileURL = Bundle(for: type(of: self)).url(forResource: "priceListJson", withExtension: "json") else {
               print("File not found")
            return Fail(error: APIError.testingError).eraseToAnyPublisher()
           }
           do {
               let data = try Data(contentsOf: fileURL)
               let cryptocurrencies = try self.decoder.decode([Cryptocurrency].self, from: data)
               return Just(cryptocurrencies).setFailureType(to: APIError.self).eraseToAnyPublisher()

           } catch {
               print("Error reading or decoding JSON: \(error)")
               return Fail(error: APIError.parsingError).eraseToAnyPublisher()

           }
    }
    
    override func searchForCryptocurrency(serachText: String) -> AnyPublisher<Coins, APIError> {
        guard isSuccessful else  {
            return Fail(error: APIError.testingError).eraseToAnyPublisher()
        }

        guard let fileURL = Bundle(for: type(of: self)).url(forResource: "coinsListJson", withExtension: "json") else {
               print("File not found")
            return Fail(error: APIError.testingError).eraseToAnyPublisher()
           }
           do {
               let data = try Data(contentsOf: fileURL)
               let coins = try self.decoder.decode(Coins.self, from: data)
               return Just(coins).setFailureType(to: APIError.self).eraseToAnyPublisher()

           } catch {
               print("Error reading or decoding JSON: \(error)")
               return Fail(error: APIError.parsingError).eraseToAnyPublisher()

           }
    }
    
    override func getCoinImage(imageUrl: URL) -> AnyPublisher<Data, APIError> {
        guard isSuccessful else  {
            return Fail(error: APIError.testingError).eraseToAnyPublisher()
        }
        
        let base64Image = """
        iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/wcAAgMBA0gtX6QAAAAASUVORK5CYII=
        """
        
        if let imageData = Data(base64Encoded: base64Image) {
            return Just(imageData).setFailureType(to: APIError.self).eraseToAnyPublisher()
        } else {
            return Fail(error: APIError.parsingError).eraseToAnyPublisher()
            
        }
        
    }
}
