import UIKit
import RxSwift

final class StoryViewController: UIViewController {
    
    internal weak var coordinator: CoordinatorProtocol?
    internal var viewModel: StoryViewModel!
    internal var storyView = StoryView()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = storyView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel
            .story
            .subscribe(onNext: { story in
                self.title = [story.section, story.subsection]
                    .filter { !$0.isEmpty }
                    .joined(separator: " - ")
                
                self.storyView.titleLabel.text = story.title
                self.storyView.abstractLabel.text = story.abstract
                self.storyView.byLineLabel.text = story.byline
                self.storyView.urlButton.on(.touchUpInside) {
                    guard let url = URL(string: story.url) else {
                        return
                    }
                    UIApplication.shared.open(url)
                }
            })
            .disposed(by: disposeBag)
    }
}
