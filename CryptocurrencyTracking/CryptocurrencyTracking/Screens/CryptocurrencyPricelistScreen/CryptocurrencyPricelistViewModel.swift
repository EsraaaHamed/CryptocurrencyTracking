//
//  CryptocurrencyPricelistViewModel.swift
//  CryptocurrencyTracking
//
//  Created by Israa hamed on 22/12/2024.
//

import SwiftUI
import Combine

protocol CryptocurrencyPricelistViewModelProtocol: ObservableObject {
    var cryptoCurrencyPricelist: [Cryptocurrency] { get }
    var errorAlert: ErrorAlert? { get set}
    var searchText: String { get set }
    var isloading: Bool { get set}
    func getCryptocurrencyPricelist()
    func startAutoRefresh()
    func stopAutoRefresh()
    init(networkManager: NetworkManager)
}

final class CryptocurrencyPricelistViewModel: CryptocurrencyPricelistViewModelProtocol {
    
    @Published var cryptoCurrencyPricelist: [Cryptocurrency] = []
    private var tempCyptoCurrencyPricelist: [Cryptocurrency] = []
    @Published var errorAlert: ErrorAlert?
    @Published var searchText: String = ""
    @Published var isloading: Bool = false
    private var timerSub: AnyCancellable?
    private var disposables = Set<AnyCancellable>()
    private let networkManager: NetworkManager
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        setupSearchTextSubscribe()
    }
    
    func getCryptocurrencyPricelist() {
        isloading = true
        networkManager.getCryptocurrencyPriceList().receive(on: DispatchQueue.main).sink {[weak self] completionValue in
            switch completionValue {
            case .finished:
                break
            case .failure(let error):
                print(error)
                self?.errorAlert = ErrorAlert(apiError: error)
                self?.cryptoCurrencyPricelist = []
                self?.tempCyptoCurrencyPricelist = []
            }
            self?.isloading = false
            
        } receiveValue: {[weak self] value in
            self?.cryptoCurrencyPricelist = value
            self?.tempCyptoCurrencyPricelist = value
            self?.isloading = false
        }.store(in: &disposables)
    }
    
    func startAutoRefresh() {
        timerSub = Timer.publish(every: 30, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: {[weak self] _ in
                self?.getCryptocurrencyPricelist()
            })
    }
    
    func stopAutoRefresh() {
        timerSub?.cancel()
    }
    
    func setupSearchTextSubscribe() {
        $searchText.debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink {[weak self] searchText in
                if (searchText.isEmpty) {
                    print("search closed")
                    self?.startAutoRefresh()
                    self?.cryptoCurrencyPricelist = self?.tempCyptoCurrencyPricelist ?? []
                    return
                }
                self?.stopAutoRefresh()
                self?.searchForCryptocurrency(searchText: searchText)
            }.store(in: &disposables)
    }
    
    func searchForCryptocurrency(searchText: String) {
        isloading = true
        networkManager.searchForCryptocurrency(serachText: searchText).receive(on: DispatchQueue.main).sink {[weak self] completionValue in
            switch completionValue {
            case .finished:
                break
            case .failure(let error):
                print(error)
                self?.errorAlert = ErrorAlert(apiError: error)
                self?.cryptoCurrencyPricelist = []
            }
            self?.isloading = false
        } receiveValue: {[weak self] value in
            let coinsIds = value.coins.map { $0.id }
            self?.cryptoCurrencyPricelist = self?.tempCyptoCurrencyPricelist.filter{ item in
                coinsIds.contains(item.id)
            } ?? []
            self?.isloading = false
        }.store(in: &disposables)
    }
    
}

