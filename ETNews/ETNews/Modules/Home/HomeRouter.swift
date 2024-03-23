//
//  HomeRouter.swift
//  ETNews
//
//  Created by Emre Tanrısever on 4.02.2024.
//

import Foundation
import UIKit.UIViewController

protocol HomeRouterProtocol {
    func navigateToDetail(url: String)
}

final class HomeRouter {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController? = nil) {
        self.view = view
    }
    
    static func createHomeModule() -> UIViewController {
        let view = HomeViewController()
        let interactor = HomeInteractor()
        let router = HomeRouter(view: view)
        
        let presenter = HomePresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}

extension HomeRouter: HomeRouterProtocol {
    
    func navigateToDetail(url: String) {
        let detailViewController = DetailRouter.goToDetailController(url: url)
        self.view?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
