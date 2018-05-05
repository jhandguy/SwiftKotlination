import UIKit
import SnapKit

class StoryTableViewCell: UITableViewCell {
    
    var titleLabel = UILabel()
    var bylineLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .darkGray
        selectedBackgroundView = backgroundView
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(bylineLabel)
        contentView.backgroundColor = .black
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView).inset(16)
            make.top.equalTo(contentView).inset(8)
            make.bottom.equalTo(bylineLabel.snp.top).offset(-8)
        }
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        bylineLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView).inset(16)
            make.bottom.equalTo(contentView).inset(8)
        }
        bylineLabel.backgroundColor = .clear
        bylineLabel.textColor = .white
        bylineLabel.numberOfLines = 1
        bylineLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
    }
}
