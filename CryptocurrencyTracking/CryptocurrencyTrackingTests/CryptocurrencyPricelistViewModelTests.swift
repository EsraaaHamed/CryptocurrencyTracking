//
//  CryptocurrencyPricelistViewModelTests.swift
//  CryptocurrencyTracking
//
//  Created by Israa hamed on 29/12/2024.
//

import Testing
@testable import CryptocurrencyTracking
import XCTest
import Combine

class  CryptocurrencyPricelistViewModelTests: XCTestCase {
    var disposables = Set<AnyCancellable>()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetCryptocurrencyPricelist() throws {
        let viewModel = CryptocurrencyPricelistViewModel(networkManager: MockedNetworkManager(isSuccessful: true))
        let expectation = XCTestExpectation(description: "getPriceList")
        viewModel.getCryptocurrencyPricelist()
        
        viewModel.$cryptoCurrencyPricelist.dropFirst().sink { priceList in
            expectation.fulfill()
            XCTAssertEqual(priceList.count, 2)
        }.store(in: &disposables)
        wait(for: [expectation], timeout: 4)
    }
    
    func testGetCryptocurrencyPricelistWithFailure() throws {
        let viewModel = CryptocurrencyPricelistViewModel(networkManager: MockedNetworkManager(isSuccessful: false))
        let expectation = XCTestExpectation(description: "getPriceListWithFailure")
        viewModel.getCryptocurrencyPricelist()
        
        viewModel.$cryptoCurrencyPricelist.dropFirst().sink { priceList in
            expectation.fulfill()
            XCTAssertNotNil(viewModel.errorAlert)
            XCTAssertEqual(priceList.count, 0)
        }.store(in: &disposables)
        wait(for: [expectation], timeout: 4)
    }
    
    func testGetSearchCryptocurrency() throws {
        let viewModel = CryptocurrencyPricelistViewModel(networkManager: MockedNetworkManager(isSuccessful: true))
        viewModel.searchText = "BTC"
        let expectation = XCTestExpectation(description: "getSearchList")
        viewModel.getCryptocurrencyPricelist()
        
        viewModel.$cryptoCurrencyPricelist.dropFirst(2).sink { cryptoCurrencyPricelistAferFilter in
            expectation.fulfill()
            XCTAssertEqual(cryptoCurrencyPricelistAferFilter.count, 1)
        }.store(in: &disposables)
        wait(for: [expectation], timeout: 2)
    }
    
    func testGetSearchCryptocurrencyWith_EmptyStr() throws {
        let viewModel = CryptocurrencyPricelistViewModel(networkManager: MockedNetworkManager(isSuccessful: true))
        viewModel.searchText = ""
        viewModel.getCryptocurrencyPricelist()
        let expectation = XCTestExpectation(description: "getSearchList")
        
        viewModel.$cryptoCurrencyPricelist.dropFirst().sink { searchList in
            expectation.fulfill()
            //will return the two values in json file as search text is empty
            XCTAssertEqual(searchList.count, 2)
        }.store(in: &disposables)
        wait(for: [expectation], timeout: 2)
    }

}
