import UIKit
import SafariServices

final class StoryViewController: UIViewController {
    internal weak var coordinator: CoordinatorProtocol?
    internal var viewModel: StoryViewModel!
    
    private(set) lazy var storyView: StoryView = {
        let view = StoryView()
        view.backgroundColor = .black
        
        return view
    }()
    
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
                    self?.title = [story.section, story.subsection]
                        .filter { !$0.isEmpty }
                        .joined(separator: " - ")
                    
                    self?.storyView.titleLabel.text = story.title
                    self?.storyView.abstractLabel.text = story.abstract
                    self?.storyView.byLineLabel.text = story.byline
                    self?.storyView.urlButton.on(.touchUpInside) { [weak self] in
                        guard let url = URL(string: story.url) else {
                            return
                        }
                        self?.present(SFSafariViewController(url: url), animated: true)
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
}
