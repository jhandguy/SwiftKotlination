import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class TopStoriesViewController: UIViewController {
    
    internal weak var coordinator: CoordinatorProtocol?
    internal var viewModel: TopStoriesViewModel!
    internal var topStoriesView = TopStoriesView()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Top Stories"
        view = topStoriesView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel
            .stories
            .bind(to: topStoriesView
                .tableView
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
