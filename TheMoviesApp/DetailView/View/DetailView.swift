//
//  DetailView.swift
//  TheMoviesApp
//
//  Created by Juan Bonforti on 9/12/20.
//

import UIKit
import RxSwift

class DetailView: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var sinopsisLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var originalTitleLabel: UILabel!
    @IBOutlet private weak var valorizationLabel: UILabel!
    
    // MARK: - Private Vars
    private var router = DetailRouter()
    private var viewModel = DetailViewViewModel()
    private var disposeBag = DisposeBag()
    
    // MARK: - Vars
    var movieId: String?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        getDataAndShowDetailMovie()
        
        viewModel.bind(view: self, router: router)
    }

    func setupUI(movie: MovieDetail) {
        DispatchQueue.main.async {
            self.titleLabel.text = movie.title
            self.movieImage.imageFromServerURL(url: Constant.URL.urlImages+movie.posterPath, placeholder: UIImage(named: "claqueta")!)
            self.sinopsisLabel.text = movie.overview
            self.dateLabel.text = movie.releaseDate
            self.valorizationLabel.text = String(movie.voteAverage)
        }
    }
    
    func getDataAndShowDetailMovie() {
        guard let movieId = movieId else { return }
        
        return viewModel.getDetailMovie(movieId: movieId)
            .subscribe(onNext: { movie in
                self.setupUI(movie: movie)
            }
            ,onError: { error in
                print("Ha ocurrido un error \(error)")
            }, onCompleted: {
                
            }).disposed(by: disposeBag)
    }

}
