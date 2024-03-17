//
//  HomeRouter.swift
//  ETNews
//
//  Created by Emre Tanrısever on 4.02.2024.
//

import Foundation
import UIKit

protocol HomeRouterProtocol {
    
}

final class HomeRouter {
    
    
    static func createHomeModule() -> UIViewController {
        let view = HomeViewController()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        
        let presenter = HomePresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}

extension HomeRouter: HomeRouterProtocol {
    
}
