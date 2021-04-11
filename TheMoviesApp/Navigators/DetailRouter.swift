import UIKit

enum DetailRoutes {
    case detailMovie(movieId: String)
}

class DetailRouter: NavigatorProtocol {
    typealias routes = DetailRoutes
    
    private var sourceView: UIViewController?
    
    public func open(route: DetailRoutes) {
        switch route {
        case .detailMovie(let movieId):
            sourceView?.navigationController?.pushViewController(DetailView(movieId: movieId), animated: true)
        }
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { fatalError("Error desconocido") }
        self.sourceView = view
    }
}
