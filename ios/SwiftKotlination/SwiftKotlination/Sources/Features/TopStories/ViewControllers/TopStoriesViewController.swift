import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class TopStoriesViewController: UIViewController {
    
    weak var coordinator: CoordinatorProtocol?
    private(set) var viewModel: TopStoriesViewModel!
    
    private lazy var tableView = UITableView()
    private let disposeBag = DisposeBag()
    
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
        tableView.register(StoryTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        viewModel
            .stories
            .bind(to: tableView
                .rx
                .items(cellIdentifier: "Cell", cellType: StoryTableViewCell.self)) { row, story, cell in
                    cell.titleLabel.text = story.title
                    cell.bylineLabel.text = story.byline
                }
            .disposed(by: disposeBag)
    }
}
