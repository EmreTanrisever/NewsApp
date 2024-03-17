//
//  HomePresenter.swift
//  ETNews
//
//  Created by Emre Tanrısever on 4.02.2024.
//

import Foundation
import struct ETNetworkKit.NewsResponse
import struct ETNetworkKit.NewsModel
import enum ETNetworkKit.NetworkError
import ETNetworkKit

protocol HomePresenterProtocol {
    func viewDidLoad()
    func returnNews() -> [NewsModel]
    func returnNewsCount() -> Int
}

final class HomePresenter {
    private weak var view: HomeViewProtocol?
    private var interactor: HomeInteractorProtocol?
    private var router: HomeRouterProtocol?
    
    private var news: [NewsModel] = []
    
    init(view: HomeViewProtocol, interactor: HomeInteractorProtocol, router: HomeRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension HomePresenter: HomePresenterProtocol {
    
    func viewDidLoad() {
        view?.configure()
        interactor?.getTopHeadLinesNews()
        view?.setBackgroundColor(color: .white)
        view?.setTitleToNavigationController(title: "News")
        view?.setRowHeight(set: 100.0)
    }
    
    func returnNews() -> [NewsModel] {
        return news
    }
    
    func returnNewsCount() -> Int {
        return news.count
    }
}

extension HomePresenter: HomeInteractorOutput {
    
    func handleFetchingTopHeadLinesNews(result: Result<NewsResponse<NewsModel>, NetworkError>) {
        
        view?.startLoading()
        switch result {
        case let .success(news):
            DispatchQueue.main.async {
                self.news = news.articles
                self.view?.stopLoading()
                self.view?.reloadData()
            }
        case let .failure(error):
            print(error)
        }
    }
}
