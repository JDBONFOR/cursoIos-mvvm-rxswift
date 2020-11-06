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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
