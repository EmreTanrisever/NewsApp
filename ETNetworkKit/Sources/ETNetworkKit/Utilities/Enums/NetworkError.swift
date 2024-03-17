//
//  File.swift
//  
//
//  Created by Emre Tanrısever on 4.02.2024.
//

import Foundation

public enum NetworkError: Error {
    case noData
    case unExpectedError
    case decodeError
    case badRequest
    case unAuthorized
    case tooManyRequest
    case serverError
    case unknownError
}
