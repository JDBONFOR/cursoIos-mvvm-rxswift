import UIKit

class HeaderTitleCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

// MARK: - Extension
extension HeaderTitleCell {
    
    func setupCell(_ model: HeaderTitleCellViewModel) {
        
        self.titleLabel.text = model.title
        
    }
    
}
