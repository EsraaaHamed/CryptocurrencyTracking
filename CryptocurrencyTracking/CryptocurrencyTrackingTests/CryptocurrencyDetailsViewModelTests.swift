//
//  CryptocurrencyDetailsViewModelTests.swift
//  CryptocurrencyTracking
//
//  Created by Israa hamed on 29/12/2024.
//

import Testing
@testable import CryptocurrencyTracking
import XCTest
import Combine

class CryptocurrencyDetailsViewModelTests: XCTestCase {
    var disposables = Set<AnyCancellable>()

    func testGetCoinImage() throws {
        let viewModel = CryptocurrencyDetailsViewModel(cryptocurrency: Cryptocurrency(id: "bitcoin", symbol: "btc", name: "Bitcoin", image: URL(string:"https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400")!, currentPrice: 70187, marketCap: 1381651251183, priceChange24h: 2126.88, priceChangePercentage24h: 3.12502), networkManager: MockedNetworkManager(isSuccessful: true))
        let expectation = XCTestExpectation(description: "getCoinImage")
        viewModel.getCoinImage()
        
        viewModel.$loadedImage.dropFirst().sink { image in
            expectation.fulfill()
            XCTAssertNotNil(image)
        }.store(in: &disposables)
        wait(for: [expectation], timeout: 4)
    }
    
    func testGetCoinImage_WithFailure() throws {
        let viewModel = CryptocurrencyDetailsViewModel(cryptocurrency: Cryptocurrency(id: "bitcoin", symbol: "btc", name: "Bitcoin", image: URL(string:"https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400")!, currentPrice: 70187, marketCap: 1381651251183, priceChange24h: 2126.88, priceChangePercentage24h: 3.12502), networkManager: MockedNetworkManager(isSuccessful: false))
        let expectation = XCTestExpectation(description: "getCoinImage")
        viewModel.getCoinImage()
        
        viewModel.$loadedImage.dropFirst().sink { image in
            expectation.fulfill()
            XCTAssertEqual(viewModel.loadedImage, UIImage(named: "placeholderImage"))
        }.store(in: &disposables)
        wait(for: [expectation], timeout: 4)
    }
}
