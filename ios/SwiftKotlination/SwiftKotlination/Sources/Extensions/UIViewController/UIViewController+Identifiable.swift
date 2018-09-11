import UIKit

extension UIViewController: Identifiable {}

extension Identifiable where Self: UIViewController {
    static var storyBoardInstance: Self {
        let storyBoard = UIStoryboard(name: identifier, bundle: Bundle.main)
        guard let viewController = storyBoard.instantiateInitialViewController() as? Self else {
            fatalError("Could not instantiate \(identifier) from StoryBoard")
        }

        return viewController
    }
}
