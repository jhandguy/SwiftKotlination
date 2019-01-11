import UIKit

final class StoryView: UIView {

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        _ = multimediaImageView
        _ = titleLabel
        _ = abstractLabel
        _ = bylineLabel
        _ = urlButton
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Private Properties

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        view.showsVerticalScrollIndicator = true

        return view
    }()

    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8),
            view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8),
            view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 8),
            view.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -16)
        ])
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 28

        return view
    }()

    // MARK: - Internal Properties

    lazy var multimediaImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(view)
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3)
        ])
        view.isHidden = true

        return view
    }()

    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(view)
        view.textAlignment = .center
        view.font = UIFont.preferredFont(forTextStyle: .title1)
        view.numberOfLines = 0

        return view
    }()

    lazy var abstractLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(view)
        view.textAlignment = .justified
        view.font = UIFont.preferredFont(forTextStyle: .body)
        view.numberOfLines = 0

        return view
    }()

    lazy var bylineLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(view)
        view.textAlignment = .justified
        view.font = UIFont.preferredFont(forTextStyle: .footnote)
        view.numberOfLines = 0

        return view
    }()

    lazy var urlButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(view)
        view.setTitleColor(tintColor, for: .normal)
        view.contentHorizontalAlignment = .right
        view.setTitle("Read more...", for: .normal)

        return view
    }()
}
