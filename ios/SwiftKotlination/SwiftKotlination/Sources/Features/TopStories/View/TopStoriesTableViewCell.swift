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

    private lazy var contentStackView = UIStackView().with {
        contentView.addSubview($0)
        $0.activate(constraints: [
            $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8)
        ])
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 8
    }

    private lazy var descriptionStackView = UIStackView().with {
        contentStackView.addArrangedSubview($0)
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillProportionally
        $0.spacing = 0
    }

    // MARK: - Internal Attributes

    private(set) lazy var multimediaImageView = UIImageView().with {
        contentStackView.addArrangedSubview($0)
        $0.activate(constraints: [
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor, multiplier: 1/1)
        ])
        $0.isHidden = true
    }

    private(set) lazy var titleLabel = UILabel().with {
        descriptionStackView.addArrangedSubview($0)
        $0.font = UIFont.preferredFont(forTextStyle: .headline)
        $0.numberOfLines = 0
    }

    private(set) lazy var bylineLabel = UILabel().with {
        descriptionStackView.addArrangedSubview($0)
        $0.font = UIFont.preferredFont(forTextStyle: .footnote)
        $0.numberOfLines = 0
    }
}
