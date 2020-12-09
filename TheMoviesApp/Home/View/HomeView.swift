//
//  HomeView.swift
//  TheMoviesApp
//
//  Created by Juan Bonforti on 03/11/2020.
//

import UIKit
import RxSwift
import RxCocoa

class HomeView: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityView: UIActivityIndicatorView!
    
    private var router = HomeRouter()
    private var viewModel = HomeViewModel()
    private var disposeBag = DisposeBag()
    
    private var movies = [Movie]()
    private var filteredMovies = [Movie]()
    
    lazy var searchController: UISearchController = ({
        let controller = UISearchController(searchResultsController: nil)
        controller.hidesNavigationBarDuringPresentation = true
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.sizeToFit()
        controller.searchBar.barStyle = .black
        controller.searchBar.backgroundColor = .clear
        controller.searchBar.placeholder = "Buscar una pelicula..."
        
        return controller
    })()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "The movies App"
        viewModel.bind(view: self, router: router)
        tableView.delegate = self
        tableView.dataSource = self
        
        configureTableView()
        getListOfMovies()
        manageSearchBarController()
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
    
    private func manageSearchBarController() {
        let searchBar = searchController.searchBar
        searchController.delegate = self
        tableView.tableHeaderView = searchBar
        tableView.contentOffset = CGPoint(x: 0, y: searchBar.frame.size.height)
        
        searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: {(result) in
                self.filteredMovies = self.movies.filter({ movie in
                    self.reloadTableView()
                    return movie.title.contains(result)
                })
                
            })
            .disposed(by: disposeBag)
    }
    
}


// MARK: - Extensions
// UITableViewDelegate, UITableViewDataSource
extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return self.filteredMovies.count
        } else {
            return self.movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomMovieCell") as! CustomMovieCell
        
        if searchController.isActive && searchController.searchBar.text != "" {
            cell.setData(movie: self.filteredMovies[indexPath.row])
        } else {
            cell.setData(movie: self.movies[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.isActive && searchController.searchBar.text != "" {
            viewModel.routetoDetailView(movieId: String(self.filteredMovies[indexPath.row].id))
        } else {
            viewModel.routetoDetailView(movieId: String(self.movies[indexPath.row].id))
        }
    }
}

// UISearchControllerDelegate
extension HomeView: UISearchControllerDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        reloadTableView()
    }
}
