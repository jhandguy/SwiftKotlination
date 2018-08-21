import UIKit
import SnapKit

final class TopStoriesView: UIView {
    private(set) lazy var tableView: UITableView = {
        let view = UITableView()
        addSubview(view)
        view.snp.makeConstraints { make in
            make.width.height.equalTo(self)
        }
        view.backgroundColor = .black
        view.register(TopStoriesTableViewCell.self)
        
        return view
    }()
}
