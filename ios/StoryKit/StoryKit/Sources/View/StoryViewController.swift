import ExtensionKit
import NetworkKit
import UIKit

protocol StoryViewControllerDelegate: AnyObject {
    func storyViewController(_ storyViewController: StoryViewController, didTouchUpInsideUrl url: String)
}

public final class StoryViewController: UIViewController, ErrorPresentable {
    private(set) lazy var storyView = StoryView()

    weak var delegate: StoryViewControllerDelegate?

    public var viewModel: StoryViewModel!

    let disposeBag = DisposeBag()
}

public extension StoryViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view = storyView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel
            .story { [weak self] result in
                switch result {
                case let .success(story):
                    self?.bind(story)

                case let .failure(error):
                    self?.present(error)
                }
            }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        disposeBag.dispose()
    }
}

extension StoryViewController {
    func didTouchUpInside(url: String) {
        delegate?.storyViewController(self, didTouchUpInsideUrl: url)
    }
}

private extension StoryViewController {
    func bind(_ story: Story) {
        title = [story.section, story.subsection]
            .filter { !$0.isEmpty }
            .joined(separator: " - ")

        storyView.apply {
            $0.titleLabel.text = story.title
            $0.abstractLabel.text = story.abstract
            $0.bylineLabel.text = story.byline
            $0.urlButton.on(.touchUpInside) { [weak self] in
                self?.didTouchUpInside(url: story.url)
            }
        }

        guard let url = story.imageUrl(.large) else {
            storyView.multimediaImageView.isHidden = true
            return
        }

        viewModel
            .image(with: url) { [weak self] result in
                switch result {
                case let .success(image):
                    self?.apply(onMainThread: true) {
                        $0.storyView.multimediaImageView.image = image
                        $0.storyView.multimediaImageView.isHidden = false
                    }

                case .failure:
                    self?.apply(onMainThread: true) {
                        $0.storyView.multimediaImageView.isHidden = true
                    }
                }
            }?.disposed(by: disposeBag)
    }

    func present(_ error: Error) {
        apply(onMainThread: true) {
            $0.present(error, animated: true)
        }
    }
}
