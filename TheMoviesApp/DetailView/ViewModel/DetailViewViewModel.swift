import Foundation
import RxSwift

class DetailViewViewModel {
    
    private var managerConnection = ManagerConnector()
    private weak var view: DetailView?
    private var router: DetailRouter?
    
    var headerTitleCell: [HeaderTitleCellViewModel] = []
    var movieImageCell: [MovieImageCellViewModel] = []
    var dataCell: [DataSectionCellViewModel] = []
        
    func bind(view: DetailView, router: DetailRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
}

// MARK: - Extension
extension DetailViewViewModel {
    
    func getDetailMovie(movieId: String) -> Observable<MovieDetail> {
        return managerConnection.getDetailMovie(movieId: movieId)
    }
    
    func setupUI(movie: MovieDetail) {
        
        // Title
        headerTitleCell.append(HeaderTitleCellViewModel(title: movie.title))
        
        // Movie Image
        movieImageCell.append(MovieImageCellViewModel(posterPath: movie.posterPath))
        
        // Movie Info
        dataCell.append(DataSectionCellViewModel(title: "Sinopsis", description: movie.overview))
        dataCell.append(DataSectionCellViewModel(title: "Fecha de lanzamiento", description: movie.releaseDate))
        dataCell.append(DataSectionCellViewModel(title: "Calificaciones", description: String(movie.voteAverage)))
        
    }    
}
