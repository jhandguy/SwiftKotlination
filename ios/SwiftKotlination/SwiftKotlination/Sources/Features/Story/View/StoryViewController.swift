import UIKit
import RxSwift

final class StoryViewController: UIViewController {
    
    weak var coordinator: CoordinatorProtocol?
    var viewModel: StoryViewModel!
    
    internal let titleLabel = UILabel()
    internal let abstractLabel = UILabel()
    internal let byLineLabel = UILabel()
    internal let urlButton = UIButton()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(titleLabel)
        view.addSubview(abstractLabel)
        view.addSubview(byLineLabel)
        view.addSubview(urlButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(32)
            make.right.left.equalTo(view).inset(16)
        }
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.numberOfLines = 0
        
        abstractLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.right.left.equalTo(view).inset(16)
        }
        abstractLabel.textAlignment = .justified
        abstractLabel.textColor = .white
        abstractLabel.font = UIFont.preferredFont(forTextStyle: .body)
        abstractLabel.numberOfLines = 0
        
        byLineLabel.snp.makeConstraints { make in
            make.top.equalTo(abstractLabel.snp.bottom).offset(16)
            make.right.left.equalTo(view).inset(16)
        }
        byLineLabel.textAlignment = .justified
        byLineLabel.textColor = .white
        byLineLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        byLineLabel.numberOfLines = 0
        
        urlButton.snp.makeConstraints { make in
            make.top.equalTo(byLineLabel.snp.bottom).offset(16)
            make.right.left.equalTo(view).inset(16)
        }
        urlButton.contentHorizontalAlignment = .center
        urlButton.setTitleColor(.red, for: .normal)
        urlButton.setTitle("See More", for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel
            .story
            .subscribe(onNext: { story in
                self.title = [story.section, story.subsection]
                    .filter { !$0.isEmpty }
                    .joined(separator: " - ")
                self.titleLabel.text = story.title
                self.abstractLabel.text = story.abstract
                self.byLineLabel.text = story.byline
                self.urlButton.on(.touchUpInside) {
                    guard let url = URL(string: story.url) else {
                        return
                    }
                    UIApplication.shared.open(url)
                }
            })
            .disposed(by: disposeBag)
    }
}
