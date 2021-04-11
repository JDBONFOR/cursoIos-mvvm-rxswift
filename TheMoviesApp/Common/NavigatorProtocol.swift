import UIKit

protocol NavigatorProtocol {
    associatedtype Routes
    
    func open(route: Routes)
}
