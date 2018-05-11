import UIKit
import SnapKit

class TopStoriesTableViewCell: UITableViewCell {
    
    static let identifier = NSStringFromClass(TopStoriesTableViewCell.self)
    
    internal let titleLabel = UILabel()
    internal let bylineLabel = UILabel()
    internal let seeButton = UIButton()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .darkGray
        selectedBackgroundView = backgroundView
        
        contentView.backgroundColor = .black
        contentView.addSubview(titleLabel)
        contentView.addSubview(bylineLabel)
        contentView.addSubview(seeButton)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(16)
            make.right.equalTo(seeButton.snp.left).offset(-16)
            make.top.equalTo(contentView).inset(8)
            make.bottom.equalTo(bylineLabel.snp.top).offset(-8)
        }
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        bylineLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(16)
            make.right.equalTo(seeButton.snp.left).offset(-16)
            make.bottom.equalTo(contentView).inset(8)
        }
        bylineLabel.textColor = .white
        bylineLabel.numberOfLines = 1
        bylineLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
        seeButton.setTitle("see".uppercased(), for: .normal)
        seeButton.setTitleColor(.red, for: .normal)
        
        seeButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.right.equalTo(contentView).inset(16)
            make.centerY.equalTo(contentView)
        }
    }
}
