import UIKit
import SnapKit

final class TopStoriesViewController: UIViewController {
    internal weak var coordinator: CoordinatorProtocol?
    internal var viewModel: TopStoriesViewModel!
    
    private(set) lazy var topStoriesView: TopStoriesView = {
        let view = TopStoriesView()
        view.tableView.dataSource = self
        view.backgroundColor = .black
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Top Stories"
        view = topStoriesView
        
        viewModel
            .stories { [weak self] result in
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        self?.topStoriesView.tableView.reloadData()
                    }
                case .failure(let error):
                    self?.presentAlertController(with: error, animated: true)
                }
            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.reload()
    }
}

extension TopStoriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let story = viewModel.stories[indexPath.row]
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .darkGray
        
        let cell = tableView.dequeue(TopStoriesTableViewCell.self, for: indexPath)
        cell.selectedBackgroundView = backgroundView
        cell.contentView.backgroundColor = .black
        cell.titleLabel.text = story.title
        cell.bylineLabel.text = story.byline
        cell.seeButton.on(.touchUpInside) { [weak self] in
            self?.coordinator?.open(story)
        }
        
        return cell
    }
}
