//
//  PasswordCriteriaView.swift
//  PasswordReset
//
//  Created by Edwin Cardenas on 7/17/25.
//

import UIKit

class PasswordCriteriaView: UIView {

    private let checkmarkImage = UIImage(systemName: "checkmark.circle")?
        .withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
    private let xmarkImage = UIImage(systemName: "xmark.circle")?
        .withTintColor(.systemRed, renderingMode: .alwaysOriginal)
    private let circleImage = UIImage(systemName: "circle")?
        .withTintColor(.tertiaryLabel, renderingMode: .alwaysOriginal)

    var isCriteriaMet: Bool = false {
        didSet {
            if isCriteriaMet {
                imageView.image = checkmarkImage
            } else {
                imageView.image = xmarkImage
            }
        }
    }

    lazy var imageView: UIImageView = {
        let _imageView = UIImageView()

        _imageView.image = circleImage
        _imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        return _imageView
    }()

    let label: UILabel = {
        let _label = UILabel()

        _label.textColor = .secondaryLabel
        _label.font = .preferredFont(forTextStyle: .subheadline)

        return _label
    }()

    // MARK: - View Lifecycle

    init(text: String) {
        super.init(frame: .zero)

        label.text = text

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Helpers

extension PasswordCriteriaView {

    private func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [
            imageView, label,
        ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center

        addSubview(stackView)

        // stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    func reset() {
        isCriteriaMet = false
        imageView.image = circleImage
    }

}
