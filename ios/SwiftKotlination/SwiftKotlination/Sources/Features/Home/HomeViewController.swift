import UIKit

final class HomeViewController: UIViewController {
    weak var coordinator: CoordinatorProtocol?
    private(set) var viewModel: HomeViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    class func create(_ viewModel: HomeViewModel) -> HomeViewController {
        let viewController = HomeViewController()
        viewController.viewModel = viewModel
        viewController.view.backgroundColor = .red
        
        return viewController
    }
}

extension HomeViewController: HomeViewModelDelegate {
    
}
