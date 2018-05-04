import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class TopStoriesViewController: UIViewController, UITableViewDelegate {
    
    lazy var tableView = UITableView()
    let disposeBag = DisposeBag()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        
        view.backgroundColor = viewModel.backgroundColor
        view.addSubview(tableView)
        
        tableView.backgroundColor = viewModel.backgroundColor
        tableView.snp.makeConstraints { make in
            make.width.height.equalTo(self.view)
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        viewModel
            .stories
            .bind(to: tableView
                .rx
                .items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { row, story, cell in
                    print(story)
                }
            .disposed(by: disposeBag)
    }
}

extension TopStoriesViewController: TopStoriesViewModelDelegate {
    
}
