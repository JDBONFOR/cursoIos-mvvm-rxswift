//
//  CustomMovieCell.swift
//  TheMoviesApp
//
//  Created by Juan Bonforti on 06/11/2020.
//

import UIKit

class CustomMovieCell: UITableViewCell {
    
    @IBOutlet weak var moviewImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieSubtitle: UILabel!
    @IBOutlet weak var descriptionMovieLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(movie: Movie) {
        self.imageView?.imageFromServerURL(url: "\(Constant.URL.urlImages+movie.posterPath)", placeholder: UIImage(named: "claqueta")!)
        self.movieTitle.text = movie.originalTitle
        self.descriptionMovieLabel.text = movie.overview
    }
    
}
