import UIKit

final class StoryView: UIView {
    
    internal let titleLabel = UILabel()
    internal let abstractLabel = UILabel()
    internal let byLineLabel = UILabel()
    internal let urlButton = UIButton()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        
        addSubview(titleLabel)
        addSubview(abstractLabel)
        addSubview(byLineLabel)
        addSubview(urlButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).offset(32)
            make.right.left.equalTo(self).inset(16)
        }
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.numberOfLines = 0
        
        abstractLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.right.left.equalTo(self).inset(16)
        }
        abstractLabel.textAlignment = .justified
        abstractLabel.textColor = .white
        abstractLabel.font = UIFont.preferredFont(forTextStyle: .body)
        abstractLabel.numberOfLines = 0
        
        byLineLabel.snp.makeConstraints { make in
            make.top.equalTo(abstractLabel.snp.bottom).offset(16)
            make.right.left.equalTo(self).inset(16)
        }
        byLineLabel.textAlignment = .justified
        byLineLabel.textColor = .white
        byLineLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        byLineLabel.numberOfLines = 0
        
        urlButton.snp.makeConstraints { make in
            make.top.equalTo(byLineLabel.snp.bottom).offset(16)
            make.right.left.equalTo(self).inset(16)
        }
        urlButton.contentHorizontalAlignment = .center
        urlButton.setTitleColor(.red, for: .normal)
        urlButton.setTitle("See More", for: .normal)
    }
}
