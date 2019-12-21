import ExtensionKit
import NetworkKit
import StoryKit
import UIKit

protocol TopStoriesTableViewControllerDelegate: AnyObject {
    func topStoriesTableViewController(
        _ topStoriesTableViewController: TopStoriesTableViewController,
        didSelectStory story: Story
    )
}

public final class TopStoriesTableViewController: UITableViewController, ErrorPresentable {
    weak var delegate: TopStoriesTableViewControllerDelegate?

    public var viewModel: TopStoriesViewModel!

    let disposeBag = DisposeBag()
}

public extension TopStoriesTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Top Stories"

        tableView.register(TopStoriesTableViewCell.self)

        refreshControl = UIRefreshControl().with {
            $0.on(.valueChanged) { [weak self] in
                self?.viewModel.refresh()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel
            .stories { [weak self] result in
                switch result {
                case .success:
                    self?.apply(onMainThread: true) {
                        $0.tableView.reloadData()
                        $0.refreshControl?.endRefreshing()
                    }
                case let .failure(error):
                    self?.present(error)
                }
            }.disposed(by: disposeBag)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        disposeBag.dispose()
    }

    override func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        150
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = viewModel.stories[indexPath.row]
        delegate?.topStoriesTableViewController(self, didSelectStory: story)
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        viewModel.stories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(TopStoriesTableViewCell.self, for: indexPath) else {
            return TopStoriesTableViewCell()
        }

        guard indexPath.row < viewModel.stories.count else {
            return cell
        }

        let story = viewModel.stories[indexPath.row]
        return bind(story, with: cell)
    }
}

private extension TopStoriesTableViewController {
    func bind(_ story: Story, with cell: TopStoriesTableViewCell) -> TopStoriesTableViewCell {
        cell.apply {
            $0.titleLabel.text = story.title
            $0.bylineLabel.text = story.byline
        }

        guard let url = story.imageUrl(.small) else {
            cell.multimediaImageView.isHidden = true
            return cell
        }

        viewModel
            .image(with: url) { result in
                switch result {
                case let .success(image):
                    cell.apply(onMainThread: true) {
                        $0.multimediaImageView.image = image
                        $0.multimediaImageView.isHidden = false
                    }

                case .failure:
                    cell.apply(onMainThread: true) {
                        $0.multimediaImageView.isHidden = true
                    }
                }
            }?.disposed(by: disposeBag)

        return cell
    }

    func present(_ error: Error) {
        apply(onMainThread: true) {
            $0.present(error, animated: true) { [weak self] in
                self?.refreshControl?.endRefreshing()
            }
        }
    }
}
