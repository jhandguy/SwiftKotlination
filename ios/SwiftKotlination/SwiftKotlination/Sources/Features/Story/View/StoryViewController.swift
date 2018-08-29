import UIKit

final class StoryViewController: UIViewController {
    
    @IBOutlet private(set) weak var multimediaImageView: UIImageView!
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
                guard let `self` = self else { return }
                switch result {
                case .success(let story):
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
                    
                    guard let url = story.imageUrl(.large) else {
                        self.multimediaImageView.isHidden = true
                        return
                    }
                    
                    self.viewModel.image(with: url) { [weak self] result in
                        switch result {
                        case .success(let data):
                            DispatchQueue.main.async { [weak self] in
                                guard let image = UIImage(data: data) else {
                                    self?.multimediaImageView.isHidden = true
                                    return
                                }
                                
                                self?.multimediaImageView.image = image
                                self?.multimediaImageView.isHidden = false
                            }
                            
                        case .failure:
                            DispatchQueue.main.async { [weak self] in
                                self?.multimediaImageView.isHidden = true
                            }
                        }
                    }
                    
                case .failure(let error):
                    self.presentAlertController(with: error, animated: true)
                }
            }
    }
}
