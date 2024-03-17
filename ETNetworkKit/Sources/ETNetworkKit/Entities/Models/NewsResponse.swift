//
//  File.swift
//  
//
//  Created by Emre Tanrısever on 4.02.2024.
//

import Foundation

public struct NewsResponse<T: Codable>: Codable {
    public let status: String
    public let totalResults: Int
    public let articles: [T]
}

public struct NewsModel: Codable {
    public let title: String?
    public let description: String?
    public let urlToImage: String?
    public let publishedAt: String?
    public let content: String?
}
