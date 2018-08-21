import UIKit

extension UITableViewCell {
    static var identifier: String {
        return NSStringFromClass(self)
    }
}
