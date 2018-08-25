import UIKit

final class StoryViewController: UIViewController {
    
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var abstractLabel: UILabel!
    @IBOutlet private(set) weak var bylineLabel: UILabel!
    @IBOutlet private(set) weak var urlButton: UIButton!
    
    internal weak var coordinator: CoordinatorProtocol?
    internal var viewModel: StoryViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel
            .story { [weak self] result in
                switch result {
                case .success(let story):
                    guard let `self` = self else { return }
                    
                    self.title = [story.section, story.subsection]
                        .filter { !$0.isEmpty }
                        .joined(separator: " - ")
                    
                    self.titleLabel.text = story.title
                    self.abstractLabel.text = story.abstract
                    self.bylineLabel.text = story.byline
                    self.urlButton.on(.touchUpInside) { [weak self] in
                        guard let url = URL(string: story.url) else {
                            return
                        }
                        self?.coordinator?.open(url)
                    }
                    
                case .failure(let error):
                    self?.presentAlertController(with: error, animated: true)
                }
            }
    }
}
