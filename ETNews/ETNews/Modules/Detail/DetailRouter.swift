//
//  DetailRouter.swift
//  ETNews
//
//  Created by Emre Tanrısever on 23.03.2024.
//

import Foundation
import UIKit

protocol DetailRouterProtocol {
    
}

final class DetailRouter {
    
    static func goToDetailController(url: String) -> UIViewController {
        let view = DetailViewController()
        let interactor = DetailInteractor()
        let router = DetailRouter()
        
        let presenter = DetailPresenter(view: view, interactor: interactor, router: router, url: url)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}

extension DetailRouter: DetailRouterProtocol {
    
}
