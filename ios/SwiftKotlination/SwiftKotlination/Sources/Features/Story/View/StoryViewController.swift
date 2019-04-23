import UIKit

final class StoryViewController: UIViewController {

    private(set) lazy var storyView = StoryView()

    weak var coordinator: CoordinatorProtocol?
    var viewModel: StoryViewModel!
    let disposeBag = DisposeBag()

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

    private func bind(_ story: Story) {
        title = [story.section, story.subsection]
            .filter { !$0.isEmpty }
            .joined(separator: " - ")

        storyView.apply {
            $0.titleLabel.text = story.title
            $0.abstractLabel.text = story.abstract
            $0.bylineLabel.text = story.byline
            $0.urlButton.on(.touchUpInside) { [weak self] in
                self?.coordinator?.open(story.url)
            }
        }

        guard let url = story.imageUrl(.large) else {
            storyView.multimediaImageView.isHidden = true
            return
        }

        viewModel
            .image(with: url) { [weak self] result in
                switch result {
                case .success(let image):
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

    private func present(_ error: Error) {
        let presenter = ErrorPresenter(error: error)
        presenter.present(in: self, animated: true)
    }
}
