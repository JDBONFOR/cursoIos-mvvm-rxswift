import UIKit

class DetailRouter {
    private var sourceView: UIViewController?
    var movieId: String?
    
    var viewController: UIViewController {
        return createViewController()
    }
    
    init(movieId: String? = "") {
        self.movieId = movieId
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { fatalError("Error desconocido") }
        self.sourceView = view
    }
    
    private func createViewController() -> UIViewController {
        let view = DetailView(nibName: "DetailView", bundle: Bundle.main)
        view.movieId = self.movieId
        return view
    }
}
