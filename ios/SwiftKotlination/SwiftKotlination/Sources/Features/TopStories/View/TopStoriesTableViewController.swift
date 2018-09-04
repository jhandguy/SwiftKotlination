import UIKit

final class TopStoriesTableViewController: UITableViewController {

    // MARK: - Internal Properties

    weak var coordinator: CoordinatorProtocol?
    var viewModel: TopStoriesViewModel!
    let disposeBag = DisposeBag()

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Top Stories"

        tableView.registerNib(TopStoriesTableViewCell.self)

        refreshControl = UIRefreshControl()
        refreshControl?.on(.valueChanged) { [weak self] in
            self?.viewModel.refresh()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel
            .stories { [weak self] result in
                switch result {
                case .success:
                    runOnMainThread {
                        self?.tableView.reloadData()
                        self?.refreshControl?.endRefreshing()
                    }
                case .failure(let error):
                    self?.presentAlertController(with: error, animated: true) {
                        runOnMainThread {
                            self?.refreshControl?.endRefreshing()
                        }
                    }
                }
            }.disposed(by: disposeBag)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        disposeBag.dispose()
    }

    // MARK: - UITableView Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = viewModel.stories[indexPath.row]
        coordinator?.open(story)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.stories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(TopStoriesTableViewCell.self, for: indexPath) else {
            return UITableViewCell()
        }

        guard indexPath.row < viewModel.stories.count else {
            return cell
        }

        let story = viewModel.stories[indexPath.row]
        return bind(cell, with: story)
    }

    // MARK: - Private Methods

    private func bind(_ cell: TopStoriesTableViewCell, with story: Story) -> TopStoriesTableViewCell {
        cell.titleLabel.text = story.title
        cell.bylineLabel.text = story.byline

        guard let url = story.imageUrl(.small) else {
            cell.multimediaImageView.isHidden = true
            return cell
        }

        viewModel
            .image(with: url) { result in
                switch result {
                case .success(let image):
                    runOnMainThread {
                        cell.multimediaImageView.image = image
                        cell.multimediaImageView.isHidden = false
                    }

                case .failure:
                    runOnMainThread {
                        cell.multimediaImageView.isHidden = true
                    }
                }
            }?.disposed(by: disposeBag)

        return cell
    }
}
