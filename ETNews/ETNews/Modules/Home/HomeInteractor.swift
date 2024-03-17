//
//  HomeInteractor.swift
//  ETNews
//
//  Created by Emre Tanrısever on 4.02.2024.
//

import Foundation
import ETNetworkKit

protocol HomeInteractorProtocol {
    func getTopHeadLinesNews()
}

protocol HomeInteractorOutput: AnyObject {
    func handleFetchingTopHeadLinesNews(result: Result<NewsResponse<NewsModel>, NetworkError>)
}

final class HomeInteractor {
    weak var presenter: HomeInteractorOutput?
    private var newsService = NewsAPI()
    
}

extension HomeInteractor: HomeInteractorProtocol {
    
    func getTopHeadLinesNews() {
        newsService.getTopHeadLines(completion: { [weak self] result in
            self?.presenter?.handleFetchingTopHeadLinesNews(result: result)
        })
    }
}
