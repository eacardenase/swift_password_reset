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

        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        return imageView
    }()
    let placeHolderText: String
    lazy var textField: UITextField = {
        let _textField = UITextField()

        _textField.translatesAutoresizingMaskIntoConstraints = false
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
    lazy var eyeButton: UIButton = {
        let button = UIButton(type: .custom)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "eye.circle"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash.circle"), for: .selected)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.addTarget(
            self,
            action: #selector(togglePasswordView),
            for: .touchUpInside
        )

        return button
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
        backgroundColor = .systemOrange

        addSubview(lockImageView)
        addSubview(textField)
        addSubview(eyeButton)

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

        // eyeButton
        NSLayoutConstraint.activate([
            eyeButton.leadingAnchor.constraint(
                equalTo: textField.trailingAnchor,
                constant: 8
            ),
            eyeButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            eyeButton.centerYAnchor.constraint(
                equalTo: textField.centerYAnchor
            ),
        ])
    }

}

// MARK: - UITextFieldDelegate

extension PasswordTextField: UITextFieldDelegate {

}

// MARK: - Actions

extension PasswordTextField {

    @objc private func togglePasswordView(_ sender: UIButton) {
        textField.isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }

}
