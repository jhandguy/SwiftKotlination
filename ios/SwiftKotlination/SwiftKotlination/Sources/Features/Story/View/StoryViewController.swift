import UIKit

final class StoryViewController: UIViewController {

    // MARK: - IBOutlet Properties

    @IBOutlet private(set) weak var multimediaImageView: UIImageView!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var abstractLabel: UILabel!
    @IBOutlet private(set) weak var bylineLabel: UILabel!
    @IBOutlet private(set) weak var urlButton: UIButton!

    // MARK: - Internal Properties

    weak var coordinator: CoordinatorProtocol?
    var viewModel: StoryViewModel!
    let disposeBag = DisposeBag()

    // MARK: - Lifecycle Methods

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

        titleLabel.text = story.title
        abstractLabel.text = story.abstract
        bylineLabel.text = story.byline
        urlButton.on(.touchUpInside) { [weak self] in
            guard let url = URL(string: story.url) else {
                return
            }
            self?.coordinator?.open(url)
        }

        guard let url = story.imageUrl(.large) else {
            multimediaImageView.isHidden = true
            return
        }

        viewModel
            .image(with: url) { [weak self] result in
                switch result {
                case .success(let image):
                    runOnMainThread {
                        self?.multimediaImageView.image = image
                        self?.multimediaImageView.isHidden = false
                    }

                case .failure:
                    runOnMainThread {
                        self?.multimediaImageView.isHidden = true
                    }
                }
            }?.disposed(by: disposeBag)
    }

    private func present(_ error: Error) {
        let presenter = ErrorPresenter(error: error)
        presenter.present(in: self, animated: true)
    }
}
