import UIKit

extension UITableView {

    // MARK: - Internal Methods

    func registerNib<T: UITableViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.identifier, bundle: Bundle.main)
        register(nib, forCellReuseIdentifier: T.identifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T
    }
}
