import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class TopStoriesViewController: UIViewController {
    
    weak var coordinator: CoordinatorProtocol?
    var viewModel: TopStoriesViewModel!
    
    private lazy var tableView = UITableView()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        
        view.backgroundColor = viewModel.backgroundColor
        view.addSubview(tableView)
        
        tableView.backgroundColor = viewModel.backgroundColor
        tableView.snp.makeConstraints { make in
            make.width.height.equalTo(self.view)
        }
        tableView.register(StoryTableViewCell.self, forCellReuseIdentifier: StoryTableViewCell.identifier)
        
        viewModel
            .stories
            .bind(to: tableView
                .rx
                .items(cellIdentifier: StoryTableViewCell.identifier, cellType: StoryTableViewCell.self)) { row, story, cell in
                    cell.titleLabel.text = story.title
                    cell.bylineLabel.text = story.byline
                }
            .disposed(by: disposeBag)
    }
}
