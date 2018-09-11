import UIKit

struct ErrorPresenter {
    let error: Error

    func present(in viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        let description = (error as? ErrorStringConvertible)?.description ?? "Something went wrong."
        let alertController = UIAlertController(
            title: "Error",
            message: description,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(
            title: "Ok",
            style: .default
        )
        alertController.addAction(alertAction)

        viewController.present(alertController, animated: animated, completion: completion)
    }
}
