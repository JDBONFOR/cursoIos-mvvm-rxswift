import UIKit

class DataSectionCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

// MARK: - Extension
extension DataSectionCell {
    
    func setupCell(_ model: DataSectionCellViewModel) {
        
        self.sectionTitle.text = model.title
        self.descriptionLabel.text = model.description
        
    }
    
}
