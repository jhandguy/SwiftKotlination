import UIKit

final class StoryView: UIView, Accessible {

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        _ = multimediaImageView
        _ = titleLabel
        _ = abstractLabel
        _ = bylineLabel
        _ = urlButton

        generateAccessibilityIdentifiers()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private lazy var scrollView = UIScrollView().with {
        addSubview($0)
        $0.activate(constraints: [
            $0.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            $0.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            $0.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        $0.showsVerticalScrollIndicator = true
    }

    private lazy var stackView = UIStackView().with {
        scrollView.addSubview($0)
        $0.activate(constraints: [
            $0.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8),
            $0.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8),
            $0.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            $0.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 8),
            $0.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -16)
        ])
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 28
    }

    lazy var multimediaImageView = UIImageView().with {
        stackView.addArrangedSubview($0)
        $0.activate(constraints: [
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor, multiplier: 2/3)
        ])
        $0.isHidden = true
    }

    lazy var titleLabel = UILabel().with {
        stackView.addArrangedSubview($0)
        $0.textAlignment = .center
        $0.font = UIFont.preferredFont(forTextStyle: .title1)
        $0.numberOfLines = 0
    }

    lazy var abstractLabel = UILabel().with {
        stackView.addArrangedSubview($0)
        $0.textAlignment = .justified
        $0.font = UIFont.preferredFont(forTextStyle: .body)
        $0.numberOfLines = 0
    }

    lazy var bylineLabel = UILabel().with {
        stackView.addArrangedSubview($0)
        $0.textAlignment = .justified
        $0.font = UIFont.preferredFont(forTextStyle: .footnote)
        $0.numberOfLines = 0
    }

    lazy var urlButton = UIButton().with {
        stackView.addArrangedSubview($0)
        $0.setTitleColor(tintColor, for: .normal)
        $0.contentHorizontalAlignment = .right
        $0.setTitle("Read more...", for: .normal)
    }
}
