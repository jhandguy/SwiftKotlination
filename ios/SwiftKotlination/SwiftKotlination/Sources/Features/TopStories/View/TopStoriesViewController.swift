import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class TopStoriesViewController: UIViewController {
    
    weak var coordinator: CoordinatorProtocol?
    var viewModel: TopStoriesViewModel!
    
    internal let tableView = UITableView()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Top Stories"
        
        view.backgroundColor = .black
        view.addSubview(tableView)
        
        tableView.backgroundColor = .black
        tableView.snp.makeConstraints { make in
            make.width.height.equalTo(view)
        }
        tableView.register(TopStoriesTableViewCell.self, forCellReuseIdentifier: TopStoriesTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel
            .stories
            .bind(to: tableView
                .rx
                .items(cellIdentifier: TopStoriesTableViewCell.identifier, cellType: TopStoriesTableViewCell.self)) { row, story, cell in
                    cell.titleLabel.text = story.title
                    cell.bylineLabel.text = story.byline
                    cell.seeButton.on(.touchUpInside) {
                        self.coordinator?.open(story)
                    }
            }
            .disposed(by: disposeBag)
    }
}
