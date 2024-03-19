//
//  File.swift
//  
//
//  Created by Emre Tanrısever on 4.02.2024.
//

import Foundation

protocol NewsAPIProtocol {
    
    func getTopHeadLines(completion: @escaping((Result<NewsResponse<NewsModel>, NetworkError>) -> Void))
}

public final class NewsAPI: NewsAPIProtocol {
    
    public init() {  }
    
    public func getTopHeadLines(completion: @escaping((Result<NewsResponse<NewsModel>, NetworkError>) -> Void)) {
        BaseAPI.shared.request(with: NewsEndPoint.getTopHeadLines) { result in
            completion(result)
        }
    }
}
