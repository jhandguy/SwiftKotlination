import UIKit

final class TopStoriesTableViewCell: UITableViewCell {
    @IBOutlet private(set) weak var multimediaImageView: UIImageView!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var bylineLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        multimediaImageView.image = UIImage(named: "Empty Placeholder Image")
    }
}
