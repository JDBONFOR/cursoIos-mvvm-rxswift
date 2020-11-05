//
//  ManagerConnector.swift
//  TheMoviesApp
//
//  Created by Juan Bonforti on 05/11/2020.
//

import Foundation
import RxSwift

class ManagerConnector {
    
    func getPopularMovies() -> Observable<[Movie]> {
        
        // Empaqueto todo el request en un Clousure de RxSwift
        return Observable.create { (observer) -> Disposable in
            
            let session = URLSession.shared
            var request = URLRequest(url: URL(string: Constant.URL.main+Constant.Endpoints.urlListPopularMovies)!)
            
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            session.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return }
                
                if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let movies = try decoder.decode(Movies.self, from: data)
                        
                        //RxSwift
                        observer.onNext(movies.listOfMovies)
                    } catch let error {
                        //RxSwift
                        observer.onError(error)
                        print("Ha ocurrido un error: \(error.localizedDescription)")
                    }
                } else if response.statusCode == 401 {
                    print("Error 401")
                }
                
                //RxSwift
                observer.onCompleted()
            }.resume()
            
            //RxSwift
            return Disposables.create {
                // Cuando no hay nada que hacer, invalidar todo.
                session.finishTasksAndInvalidate()
            }
            
        }
        
    }
    
    func getDetailMovie() {
        
    }
    
}
