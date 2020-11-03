//
//  HomeView.swift
//  TheMoviesApp
//
//  Created by Juan Bonforti on 03/11/2020.
//

import UIKit

class HomeView: UIViewController {
    
    private var router = HomeRouter()
    private var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.bind(view: self, router: router)
    }

}
