import UIKit

public extension UITableView {
    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass.self, forCellReuseIdentifier: T.tag)
    }

    func dequeueReusableCell<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T? {
        dequeueReusableCell(withIdentifier: T.tag, for: indexPath) as? T
    }
}
