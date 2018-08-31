import UIKit

extension UIViewController {
    func presentAlertController(with error: Error, animated: Bool, completion: (() -> Void)? = nil) {
        let description = (error as? ErrorStringConvertible)?.description ?? "Something went wrong."
        let alertController = UIAlertController(
            title: "Error",
            message: description,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(
            title: "Ok",
            style: .default,
            handler: { _ in }
        )
        alertController.addAction(alertAction)
        
        present(alertController, animated: animated, completion: completion)
    }
}
