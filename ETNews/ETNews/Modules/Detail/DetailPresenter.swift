//
//  DetailPresenter.swift
//  ETNews
//
//  Created by Emre Tanrısever on 23.03.2024.
//

import Foundation

protocol DetailPresenterProtocol {
    func viewDidLoad()
    func returnURL() -> String?
}

final class DetailPresenter {
    private weak var view: DetailViewProtocol?
    private var interactor: DetailInteractorProtocol?
    private var router: DetailRouterProtocol?
    
    private var newsURL: String?
    
    init(view: DetailViewProtocol, interactor: DetailInteractorProtocol, router: DetailRouterProtocol, url: String) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.newsURL = url
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    
    func viewDidLoad() {
        view?.configure()
        view?.loadWebView()
    }
    
    func returnURL() -> String? {
        return newsURL
    }
}

extension DetailPresenter: DetailInteractorOutput {
    
}
