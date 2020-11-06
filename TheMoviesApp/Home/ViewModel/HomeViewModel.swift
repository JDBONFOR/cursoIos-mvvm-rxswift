//
//  HomeViewModel.swift
//  TheMoviesApp
//
//  Created by Juan Bonforti on 03/11/2020.
//

import Foundation
import RxSwift

class HomeViewModel {
    private weak var view: HomeView? //Cuando usamos la vista, queremos q haga referencia debil, para ciclo de memoria
    private var router: HomeRouter?
    private var service = ManagerConnector()
    
    // Metodo de inicializacion
    func bind(view: HomeView, router: HomeRouter) {
        self.view = view
        self.router = router
        
        // binder router con vista
        self.router?.setSourceView(view)
    }
    
    func getListOfMovies() -> Observable<[Movie]> {
        return service.getPopularMovies()
    }
    
}
