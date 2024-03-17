//
//  File.swift
//  
//
//  Created by Emre Tanrısever on 4.02.2024.
//

import Foundation

enum NewsEndPoint {
    case getTopHeadLines
}

extension NewsEndPoint: EndPointProtocol {
    var schema: String {
        "https"
    }
    
    var host: String {
        "newsapi.org"
    }
    
    var path: String {
        switch self {
        case .getTopHeadLines:
            return "/v2/top-headlines"
        }
    }
    
    var httpMethod: HttpMethods {
        switch self {
        case .getTopHeadLines:
                return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .getTopHeadLines:
            return nil
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getTopHeadLines:
            return [
                "country": "us",
                "apiKey": "654d66b12eb44788ae59a8c540512861"
            ]
        }
    }
}
