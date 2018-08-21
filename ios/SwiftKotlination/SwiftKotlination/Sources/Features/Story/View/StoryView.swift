import UIKit
import SnapKit

final class StoryView: UIView {
    private(set) lazy var titleLabel: UILabel = {
        let view = UILabel()
        addSubview(view)
        view.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).offset(32)
            make.right.left.equalTo(self).inset(16)
        }
        view.textAlignment = .center
        view.textColor = .white
        view.font = UIFont.preferredFont(forTextStyle: .title1)
        view.numberOfLines = 0
        
        return view
    }()
    
    private(set) lazy var abstractLabel: UILabel = {
        let view = UILabel()
        addSubview(view)
        view.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.right.left.equalTo(self).inset(16)
        }
        view.textAlignment = .justified
        view.textColor = .white
        view.font = UIFont.preferredFont(forTextStyle: .body)
        view.numberOfLines = 0
        
        return view
    }()
    
    private(set) lazy var byLineLabel: UILabel = {
        let view = UILabel()
        addSubview(view)
        view.snp.makeConstraints { make in
            make.top.equalTo(abstractLabel.snp.bottom).offset(16)
            make.right.left.equalTo(self).inset(16)
        }
        view.textAlignment = .justified
        view.textColor = .white
        view.font = UIFont.preferredFont(forTextStyle: .footnote)
        view.numberOfLines = 0
        
        return view
    }()
    
    private(set) lazy var urlButton: UIButton = {
        let view = UIButton()
        addSubview(view)
        view.snp.makeConstraints { make in
            make.top.equalTo(byLineLabel.snp.bottom).offset(16)
            make.right.left.equalTo(self).inset(16)
        }
        view.contentHorizontalAlignment = .center
        view.setTitleColor(.red, for: .normal)
        view.setTitle("See More", for: .normal)
        
        return view
    }()
}
