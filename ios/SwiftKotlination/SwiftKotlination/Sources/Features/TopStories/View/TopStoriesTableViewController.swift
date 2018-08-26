import UIKit

final class TopStoriesTableViewController: UITableViewController {
    internal weak var coordinator: CoordinatorProtocol?
    internal var viewModel: TopStoriesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Top Stories"
        
        tableView.registerNib(TopStoriesTableViewCell.self)
        
        viewModel
            .stories { [weak self] result in
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.stories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(TopStoriesTableViewCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        let story = viewModel.stories[indexPath.row]
        cell.titleLabel.text = story.title
        cell.bylineLabel.text = story.byline
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = viewModel.stories[indexPath.row]
        coordinator?.open(story)
    }
}
