import UIKit
import Foundation

extension UIImageView {
    
    func imageFromServerURL(url: String, placeholder: UIImage) {
        
        if self.image == nil {
            self.image = placeholder
        }
        
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            
            if error != nil {
                return
            }
            
            DispatchQueue.main.async {
                guard let data = data else { return }
                let image = UIImage(data: data)
                self.image = image
            }
            
        }.resume()
        
    }
    
}
