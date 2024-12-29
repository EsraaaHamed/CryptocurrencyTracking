//
//  APIError.swift
//  CryptocurrencyTracking
//
//  Created by Israa hamed on 22/12/2024.
//
import Foundation

enum APIError: String, Error  {
    
    case invalidResponseError = "Invalid response from server"
    case invalidUrlError = "The url used is invalid or not supported"
    case responseWithError = "The response contains an error"
    case parsingError = "Couldn't parse the response from server"
    case testingError = "Testing error occurred"
    case unKnownError = ""

}

struct ErrorAlert: Identifiable  {
    let id = UUID()
    let apiError: APIError
}
