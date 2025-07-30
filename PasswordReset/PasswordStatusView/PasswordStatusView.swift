//
//  PasswordStatusView.swift
//  PasswordReset
//
//  Created by Edwin Cardenas on 7/18/25.
//

import UIKit

class PasswordStatusView: UIView {

    let stackView: UIStackView = {
        let _stackView = UIStackView()

        _stackView.translatesAutoresizingMaskIntoConstraints = false
        _stackView.axis = .vertical
        _stackView.spacing = 8
        _stackView.distribution = .equalCentering

        return _stackView
    }()

    let lengthCriteriaView = PasswordCriteriaView(
        text: "8-32 characters (no spaces)"
    )
    lazy var criteriaLabel: UILabel = {
        let label = UILabel()

        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = makeCriteriaAttributedString()

        return label
    }()
    let uppercaseCriteriaView = PasswordCriteriaView(
        text: "uppercase letter (A-Z)"
    )
    let lowercaseCriteriaView = PasswordCriteriaView(
        text: "lowercase letter (a-z)"
    )
    let digitCriteriaView = PasswordCriteriaView(
        text: "digit (0-9)"
    )
    let specialCharacterCriteriaView = PasswordCriteriaView(
        text: "special character (e.g. !@#$%^)"
    )

    private var shouldResetCriteria = true

    // MARK: - View Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: 200, height: 200)
    }

}

// MARK: - Helpers

extension PasswordStatusView {

    private func setupViews() {
        backgroundColor = .tertiarySystemFill
        layer.cornerRadius = 8

        stackView.addArrangedSubview(lengthCriteriaView)
        stackView.addArrangedSubview(criteriaLabel)
        stackView.addArrangedSubview(uppercaseCriteriaView)
        stackView.addArrangedSubview(lowercaseCriteriaView)
        stackView.addArrangedSubview(digitCriteriaView)
        stackView.addArrangedSubview(specialCharacterCriteriaView)

        addSubview(stackView)

        // stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            stackView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
            stackView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -16
            ),
        ])
    }

    private func makeCriteriaAttributedString() -> NSAttributedString {
        let plainTextAttributes: [NSAttributedString.Key: AnyObject] = [
            .font: UIFont.preferredFont(forTextStyle: .subheadline),
            .foregroundColor: UIColor.secondaryLabel,
        ]
        let boldTextAttributes: [NSAttributedString.Key: AnyObject] = [
            .font: UIFont.preferredFont(forTextStyle: .subheadline),
            .foregroundColor: UIColor.label,
        ]

        let attributedText = NSMutableAttributedString(
            string: "Use at least ",
            attributes: plainTextAttributes
        )

        attributedText.append(
            NSAttributedString(
                string: "3 of these 4 ",
                attributes: boldTextAttributes
            )
        )
        attributedText.append(
            NSAttributedString(
                string: "criteria when setting your password:",
                attributes: plainTextAttributes
            )
        )

        return attributedText
    }

    func updateDisplay(_ text: String) {
        let lengthAndNoSpaceMet = PasswordCriteria.lengthAndNoSpaceMet(text)
        let uppercaseMet = PasswordCriteria.uppercaseMet(text)
        let lowercaseMet = PasswordCriteria.lowercaseMet(text)
        let digitMet = PasswordCriteria.digitMet(text)
        let specialCharacterMet = PasswordCriteria.specialCharacter(text)

        if shouldResetCriteria {
            lengthAndNoSpaceMet
                ? lengthCriteriaView.isCriteriaMet = true
                : lengthCriteriaView.reset()

            uppercaseMet
                ? uppercaseCriteriaView.isCriteriaMet = true
                : uppercaseCriteriaView.reset()

            lowercaseMet
                ? lowercaseCriteriaView.isCriteriaMet = true
                : lowercaseCriteriaView.reset()

            digitMet
                ? digitCriteriaView.isCriteriaMet = true
                : digitCriteriaView.reset()

            specialCharacterMet
                ? specialCharacterCriteriaView.isCriteriaMet = true
                : specialCharacterCriteriaView.reset()
        }
    }

    func reset() {
        lengthCriteriaView.reset()
        uppercaseCriteriaView.reset()
        lowercaseCriteriaView.reset()
        digitCriteriaView.reset()
        specialCharacterCriteriaView.reset()
    }

}
