import Foundation
import UIKit

enum HomeRoutes {
    case home
    case movieDetail(movieId: String)
}

class HomeRouter: NavigatorProtocol {
    typealias routes = HomeRoutes
    
    private var sourceView: UIViewController?
    
    public func open(route: HomeRoutes) {
        switch route {
        case .home:
            sourceView?.navigationController?.pushViewController(HomeView(), animated: true)
        case .movieDetail(let movieId):
            sourceView?.navigationController?.pushViewController(DetailView(movieId: movieId), animated: true)
        }
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { fatalError("Error desconocido") }
        self.sourceView = view
    }
}
