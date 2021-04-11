import UIKit

class MovieImageCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var movieImageView: UIImageView!
    
    // MARK: - Lyfe Cicle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

// MARK: - Extension
extension MovieImageCell {
    
    func setupCell(_ model: MovieImageCellViewModel) {
        
        self.movieImageView.imageFromServerURL(url: Constant.URL.urlImages+model.posterPath, placeholder: UIImage(named: "claqueta") ?? UIImage() )
        
    }
    
}
