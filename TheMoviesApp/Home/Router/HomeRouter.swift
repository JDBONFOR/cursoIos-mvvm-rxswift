//
//  HomeRouter.swift
//  TheMoviesApp
//
//  Created by Juan Bonforti on 03/11/2020.
//


// Esta clase creara objeto HOME, pero tambien servira de router para ir a otras vistas/pantallas
import Foundation
import UIKit

class HomeRouter {
    private var sourceView: UIViewController?
    
    var viewController: UIViewController {
        return createViewController()
    }
    
    private func createViewController() -> UIViewController {
        let view = HomeView(nibName: "HomeView", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { fatalError("Error desconocido") }
        self.sourceView = view
    }
    
    func navigateTo(movieId: String) {
        let detailView = DetailRouter(movieId: movieId).viewController
        sourceView?.navigationController?.pushViewController(detailView, animated: true)
    }
}
