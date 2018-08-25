import UIKit

extension UIViewController: Identifiable {}

extension Identifiable where Self: UIViewController {
    static var storyBoardInstance: Self? {
        let storyBoard = UIStoryboard(name: identifier, bundle: Bundle.main)
        return storyBoard.instantiateInitialViewController() as? Self
    }
}
