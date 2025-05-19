//
//  ErrorApp.swift
//  News
//
//  Created by Даша Волошина on 19.05.25.
//

import Foundation

enum ErrorApp:LocalizedError {
    case noConnetion
    case unexpectedError
    
    var errorMessage: String {
        switch self {
        case .noConnetion:
            return "No Internet connection"
        case .unexpectedError:
            return "Something Went Wrong"
        }
    }
    static func map(error: Error) -> ErrorApp {
        let nsError = error as NSError
        if nsError.domain == NSURLErrorDomain && nsError.code == NSURLErrorNotConnectedToInternet {
            return .noConnetion
        } else {
            return .unexpectedError
        }
    }
}

enum NetworkError: Error {
    case invalidUrl
    case invalidRequest
    case decodingError
}

enum DataError:Error {
    case failedSaved
    case failedRemove
    case failedFetch
}
