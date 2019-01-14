import UIKit

final class StoryViewController: UIViewController {

    // MARK: - Private Properties

    private(set) lazy var storyView = StoryView()

    // MARK: - Internal Properties

    weak var coordinator: CoordinatorProtocol?
    var viewModel: StoryViewModel!
    let disposeBag = DisposeBag()

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        view = storyView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel
            .story { [weak self] result in
                switch result {
                case .success(let story):
                    self?.bind(story)

                case .failure(let error):
                    self?.present(error)
                }
            }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        disposeBag.dispose()
    }

    // MARK: - Private Methods

    private func bind(_ story: Story) {
        title = [story.section, story.subsection]
            .filter { !$0.isEmpty }
            .joined(separator: " - ")

        storyView.titleLabel.text = story.title
        storyView.abstractLabel.text = story.abstract
        storyView.bylineLabel.text = story.byline
        storyView.urlButton.on(.touchUpInside) { [weak self] in
            self?.coordinator?.open(story.url)
        }

        guard let url = story.imageUrl(.large) else {
            storyView.multimediaImageView.isHidden = true
            return
        }

        viewModel
            .image(with: url) { [weak self] result in
                switch result {
                case .success(let image):
                    self?.runOnMainThread {
                        $0.storyView.multimediaImageView.image = image
                        $0.storyView.multimediaImageView.isHidden = false
                    }

                case .failure:
                    self?.runOnMainThread {
                        $0.storyView.multimediaImageView.isHidden = true
                    }
                }
            }?.disposed(by: disposeBag)
    }

    private func present(_ error: Error) {
        let presenter = ErrorPresenter(error: error)
        presenter.present(in: self, animated: true)
    }
}
