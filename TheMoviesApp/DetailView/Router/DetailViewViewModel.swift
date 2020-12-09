//
//  DetailViewViewModel.swift
//  TheMoviesApp
//
//  Created by Juan Bonforti on 9/12/20.
//

import Foundation
import RxSwift

class DetailViewViewModel {
    
    private var managerConnection = ManagerConnector()
    private weak var view: DetailView?
    private var router: DetailRouter?
    
    func bind(view: DetailView, router: DetailRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func getDetailMovie(movieId: String) -> Observable<MovieDetail> {
        return managerConnection.getDetailMovie(movieId: movieId)
    }
    
}
