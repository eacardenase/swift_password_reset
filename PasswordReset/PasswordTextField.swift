//
//  PasswordTextField.swift
//  PasswordReset
//
//  Created by Edwin Cardenas on 7/17/25.
//

import UIKit

class PasswordTextField: UIView {

    let lockImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "lock.fill")

        return imageView
    }()
    let placeHolderText: String
    lazy var textField: UITextField = {
        let _textField = UITextField()

        _textField.translatesAutoresizingMaskIntoConstraints = false
        _textField.textColor = .secondaryLabel
        _textField.isSecureTextEntry = false
        _textField.delegate = self
        _textField.keyboardType = .asciiCapable
        _textField.attributedPlaceholder = NSAttributedString(
            string: placeHolderText,
            attributes: [
                .foregroundColor: UIColor.secondaryLabel
            ]
        )

        return _textField
    }()

    // MARK: - View Lifecycle

    init(placeHolderText: String) {
        self.placeHolderText = placeHolderText

        super.init(frame: .zero)

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

extension PasswordTextField {

    private func setupViews() {
        backgroundColor = .systemGreen

        addSubview(lockImageView)
        addSubview(textField)

        // lockImageView
        NSLayoutConstraint.activate([
            lockImageView.centerYAnchor.constraint(
                equalTo: textField.centerYAnchor
            ),
            lockImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])

        // textField
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(
                equalTo: lockImageView.trailingAnchor,
                constant: 8
            ),
        ])
    }

}

// MARK: - UITextFieldDelegate

extension PasswordTextField: UITextFieldDelegate {

}
