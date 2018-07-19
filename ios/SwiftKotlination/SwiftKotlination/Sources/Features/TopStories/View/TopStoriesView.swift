import UIKit

final class TopStoriesView: UIView {
    
    internal let tableView = UITableView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.width.height.equalTo(self)
        }
        tableView.backgroundColor = .black
        tableView.register(TopStoriesTableViewCell.self, forCellReuseIdentifier: TopStoriesTableViewCell.identifier)
    }
}
