import UIKit
import SnapKit

final class TopStoriesTableViewCell: UITableViewCell {
    private(set) lazy var titleLabel: UILabel = {
        let view = UILabel()
        contentView.addSubview(view)
        view.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(16)
            make.right.equalTo(seeButton.snp.left).offset(-16)
            make.top.equalTo(contentView).inset(8)
            make.bottom.equalTo(bylineLabel.snp.top).offset(-8)
        }
        view.textColor = .white
        view.numberOfLines = 0
        view.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return view
    }()
    
    private(set) lazy var bylineLabel: UILabel = {
        let view = UILabel()
        contentView.addSubview(view)
        view.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(16)
            make.right.equalTo(seeButton.snp.left).offset(-16)
            make.bottom.equalTo(contentView).inset(8)
        }
        view.textColor = .white
        view.numberOfLines = 1
        view.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
        return view
    }()
    
    private(set) lazy var seeButton: UIButton = {
        let view = UIButton()
        contentView.addSubview(view)
        view.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.right.equalTo(contentView).inset(16)
            make.centerY.equalTo(contentView)
        }
        view.setTitle("see".uppercased(), for: .normal)
        view.setTitleColor(.red, for: .normal)
        
        return view
    }()
}
