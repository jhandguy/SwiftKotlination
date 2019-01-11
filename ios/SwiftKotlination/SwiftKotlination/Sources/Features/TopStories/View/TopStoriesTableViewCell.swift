import UIKit

final class TopStoriesTableViewCell: UITableViewCell {

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .white

        _ = multimediaImageView
        _ = titleLabel
        _ = bylineLabel
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Private Attributes

    private lazy var contentStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8)
        ])
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 8

        return view
    }()

    private lazy var descriptionStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.addArrangedSubview(view)
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fillProportionally
        view.spacing = 0

        return view
    }()

    // MARK: - Internal Attributes

    private(set) lazy var multimediaImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.addArrangedSubview(view)
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/1)
        ])
        view.isHidden = true

        return view
    }()

    private(set) lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        descriptionStackView.addArrangedSubview(view)
        view.font = UIFont.preferredFont(forTextStyle: .headline)
        view.numberOfLines = 0

        return view
    }()

    private(set) lazy var bylineLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        descriptionStackView.addArrangedSubview(view)
        view.font = UIFont.preferredFont(forTextStyle: .footnote)
        view.numberOfLines = 0

        return view
    }()
}
