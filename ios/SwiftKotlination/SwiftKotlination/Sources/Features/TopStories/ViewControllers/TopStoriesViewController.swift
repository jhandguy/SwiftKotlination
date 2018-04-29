import UIKit

final class TopStoriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var coordinator: CoordinatorProtocol?
    private(set) var viewModel: TopStoriesViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    class func create(_ viewModel: TopStoriesViewModel) -> TopStoriesViewController {
        let viewController = TopStoriesViewController()
        viewController.viewModel = viewModel
        
        return viewController
    }
}

extension TopStoriesViewController: TopStoriesViewModelDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        view.backgroundColor = viewModel.backgroundColor
    }
}
