//
//  NetworkManager.swift
//  CryptocurrencyTracking
//
//  Created by Israa hamed on 22/12/2024.
//
import Foundation
import Combine

class NetworkManager {
    
    init() {}
    
    func getCryptocurrencyPriceList() ->  AnyPublisher<[Cryptocurrency], APIError>  {
        let urlComponents = self.getPriceListURLComponents()
        guard let finalURL = urlComponents?.url else {
            print("Invalid URL")
            
            return Fail(error: APIError.invalidUrlError).eraseToAnyPublisher()
        }
        
        let priceListRequest = self.getURLRequest(url: finalURL)
        let decoder = JSONDecoder()
        
        return URLSession.shared.dataTaskPublisher(for: priceListRequest).mapError{ error in
            APIError.responseWithError
        }.tryMap { element -> Data in
            guard let response = element.response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                throw APIError.invalidResponseError
            }
            print("get list data received: \(element.data)")
            return element.data
        }.decode(type: [Cryptocurrency].self, decoder: decoder).mapError{
            error in
            APIError.parsingError
        }.eraseToAnyPublisher()
        
    }
    
    func getCoinImage(imageUrl: URL) -> AnyPublisher<Data, APIError> {
        
        if let imageData = CachingManager.shared.getcahedImage(forKey: imageUrl.absoluteString) {
            return Just(imageData).setFailureType(to: APIError.self).eraseToAnyPublisher()
        }
        let request = getURLRequest(url: imageUrl)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { element -> Data in
                guard let response = element.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw APIError.invalidResponseError
                }
//                print(element.data)
                CachingManager.shared.setCachedImage(element.data, forKey: imageUrl.absoluteString)
                return element.data
            }.mapError { error in
                APIError.responseWithError
            }.eraseToAnyPublisher()
    }
    
    func searchForCryptocurrency(serachText: String) -> AnyPublisher<Coins, APIError> {
        let urlComponents = self.getCryptocurrenciesSearchURLComponents(searchText: serachText)
        guard let finalURL = urlComponents?.url else {
            print("Invalid URL")
            
            return Fail(error: APIError.invalidUrlError).eraseToAnyPublisher()
        }
        
        let searchRequest = self.getURLRequest(url: finalURL)
        let decoder = JSONDecoder()
        
        return URLSession.shared.dataTaskPublisher(for: searchRequest).mapError{ error in
            APIError.responseWithError
        }.tryMap { element -> Data in
            guard let response = element.response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                throw APIError.invalidResponseError
            }
            return element.data
        }.decode(type: Coins.self, decoder: decoder).mapError{
            error in
            APIError.parsingError
        }.eraseToAnyPublisher()
        
    }
    
}

extension NetworkManager {
    func getURLRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Accept": "application/json"]
        
        return request
    }
    
    func getPriceListURLComponents() -> URLComponents? {
        let queryItem = [URLQueryItem(name: APIConstants.apiKeyHeaderKey, value: APIConstants.apiKeyValue), URLQueryItem(name: APIConstants.targetMarketQueryParamKey, value: APIConstants.targetMarketQueryParamValue)]
        var urlComponents = URLComponents(string: (APIConstants.baseURL + APIConstants.getAllCoinsEndPoint))
        urlComponents?.queryItems = queryItem
        
        return urlComponents
    }
    
    func getCryptocurrenciesSearchURLComponents(searchText: String) -> URLComponents? {
        let queryItem = [ URLQueryItem(name: "query", value: searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)?.lowercased() ?? "")]
        
        var urlComponents = URLComponents(string: (APIConstants.baseURL + APIConstants.searchCoinsEndPoint))
            urlComponents?.queryItems = queryItem
        
        return urlComponents
    }
}
