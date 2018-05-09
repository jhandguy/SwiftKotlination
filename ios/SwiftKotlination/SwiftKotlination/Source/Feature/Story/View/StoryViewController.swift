import UIKit
import RxSwift

final class StoryViewController: UIViewController {
    
    weak var coordinator: CoordinatorProtocol?
    var viewModel: StoryViewModel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel
            .story
            .subscribe(onNext: { story in
                self.title = story.subsection
            })
            .disposed(by: disposeBag)
        
        view.backgroundColor = viewModel.backgroundColor
    }
}
