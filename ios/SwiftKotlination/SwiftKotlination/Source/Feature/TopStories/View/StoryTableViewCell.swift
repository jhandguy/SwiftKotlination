import UIKit
import SnapKit

class StoryTableViewCell: UITableViewCell {
    
    static let identifier = NSStringFromClass(StoryTableViewCell.self)
    
    var titleLabel = UILabel()
    var bylineLabel = UILabel()
    var seeButton = UIButton()
    
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
            make.leading.equalTo(contentView).inset(16)
            make.trailing.equalTo(seeButton.snp.leading).offset(-16)
            make.top.equalTo(contentView).inset(8)
            make.bottom.equalTo(bylineLabel.snp.top).offset(-8)
        }
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        bylineLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(16)
            make.trailing.equalTo(seeButton.snp.leading).offset(-16)
            make.bottom.equalTo(contentView).inset(8)
        }
        bylineLabel.backgroundColor = .clear
        bylineLabel.textColor = .white
        bylineLabel.numberOfLines = 1
        bylineLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
        seeButton.setTitle("see".uppercased(), for: .normal)
        seeButton.setTitleColor(.red, for: .normal)
        
        seeButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.trailing.equalTo(contentView).inset(16)
            make.centerY.equalTo(contentView)
        }
    }
}
