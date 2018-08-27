import UIKit

final class TopStoriesTableViewCell: UITableViewCell {
    @IBOutlet private(set) weak var urlImageView: UIImageView!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var bylineLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        urlImageView.image = UIImage(named: "Empty Placeholder Image")
    }
}
