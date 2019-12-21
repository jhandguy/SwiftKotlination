import UIKit

public protocol ErrorPresentable: AnyObject {
    func present(_ error: Error, animated: Bool, completion: (() -> Void)?)
}

public extension ErrorPresentable where Self: UIViewController {
    func present(_ error: Error, animated: Bool, completion: (() -> Void)? = nil) {
        let presenter = ErrorPresenter(error: error)
        presenter.present(in: self, animated: animated, completion: completion)
    }
}

private struct ErrorPresenter {
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
