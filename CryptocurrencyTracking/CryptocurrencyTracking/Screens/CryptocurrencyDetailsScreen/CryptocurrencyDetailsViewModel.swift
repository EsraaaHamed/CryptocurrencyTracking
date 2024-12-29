//
//  CryptocurrencyDetailsViewModel.swift
//  CryptocurrencyTracking
//
//  Created by Israa hamed on 27/12/2024.
//

import SwiftUI
import Combine
protocol CryptocurrencyDetailsViewModelProtocol: ObservableObject {
    var cryptocurrency : Cryptocurrency { get set }
    var loadedImage: UIImage? { get set }
    init (cryptocurrency: Cryptocurrency, networkManager: NetworkManager)
    func getCoinImage()
}

class CryptocurrencyDetailsViewModel: CryptocurrencyDetailsViewModelProtocol {
    @Published var loadedImage: UIImage? = UIImage(named: "placeholderImage")
    var cryptocurrency: Cryptocurrency
    private let networkManager: NetworkManager
    private var disposables = Set<AnyCancellable>()
    
    required init(cryptocurrency: Cryptocurrency, networkManager: NetworkManager) {
        self.cryptocurrency = cryptocurrency
        self.networkManager = networkManager
    }
    
    func getCoinImage() {
        networkManager.getCoinImage(imageUrl: cryptocurrency.image)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    self?.loadedImage = UIImage(named: "placeholderImage")
                }
            }, receiveValue: { [weak self] value in
                if let image = UIImage(data: value)  {
                    self?.loadedImage = image
                } else {
                    self?.loadedImage = UIImage(named: "placeholderImage")
                }
            }).store(in: &disposables)
    }
}
