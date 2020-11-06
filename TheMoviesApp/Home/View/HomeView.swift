//
//  HomeView.swift
//  TheMoviesApp
//
//  Created by Juan Bonforti on 03/11/2020.
//

import UIKit
import RxSwift

class HomeView: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    private var router = HomeRouter()
    private var viewModel = HomeViewModel()
    private var disposeBag = DisposeBag()
    
    private var movies = [Movie]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.bind(view: self, router: router)
        tableView.delegate = self
        tableView.dataSource = self
        
        configureTableView()
        getListOfMovies()
    }
}

// MARK: - Extensions
// UITableViewDelegate, UITableViewDataSource
extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomMovieCell") as! CustomMovieCell
        
        cell.movieTitle.text = movies[indexPath.row].originalTitle
        cell.descriptionMovieLabel.text = movies[indexPath.row].overview
               
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

// Private Methods
extension HomeView {
    
    private func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "CustomMovieCell", bundle: nil), forCellReuseIdentifier: "CustomMovieCell")
    }
    
    private func getListOfMovies() {
        return viewModel.getListOfMovies()
        // Manejar concurrencia o hilos en RxSwift
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
        // Suscribirme al observable
            .subscribe(onNext: { movies in
                self.movies = movies
                self.reloadTableView()
            }, onError: { error in
                print(error.localizedDescription)
            }, onCompleted: {
                //
            }).disposed(by: disposeBag)



        // Dar por completado el request RxSwift
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.activityView.stopAnimating()
            self.activityView.isHidden = true
            self.tableView.reloadData()
        }
    }
    
}
