//
//  PasswordTextField.swift
//  PasswordReset
//
//  Created by Edwin Cardenas on 7/17/25.
//

import UIKit

protocol PasswordTextFieldDelegate: AnyObject {

    func editingChanged(_ sender: PasswordTextField)
    func editingDidEnd(_ sender: PasswordTextField)

}

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
        _textField.autocorrectionType = .no
        _textField.autocapitalizationType = .none
        _textField.attributedPlaceholder = NSAttributedString(
            string: placeHolderText,
            attributes: [
                .foregroundColor: UIColor.secondaryLabel
            ]
        )

        _textField.addTarget(
            self,
            action: #selector(textFieldEditingChanged),
            for: .editingChanged
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
    let dividerView: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .separator

        return view
    }()
    let errorLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .systemRed
        label.text = "Your password must meet the requirements below."
        //        label.adjustsFontSizeToFitWidth = true
        //        label.minimumScaleFactor = 0.8
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.isHidden = true

        return label
    }()

    weak var delegate: PasswordTextFieldDelegate?

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
        CGSize(width: 200, height: 50)
    }

}

// MARK: - Helpers

extension PasswordTextField {

    private func setupViews() {
        addSubview(lockImageView)
        addSubview(textField)
        addSubview(eyeButton)
        addSubview(dividerView)
        addSubview(errorLabel)

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

        // dividerView
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(
                equalTo: textField.bottomAnchor,
                constant: 8
            ),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
        ])

        // errorLabel
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(
                equalTo: dividerView.bottomAnchor,
                constant: 4
            ),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

}

// MARK: - UITextFieldDelegate

extension PasswordTextField: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.editingDidEnd(self)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }

}

// MARK: - Actions

extension PasswordTextField {

    @objc private func togglePasswordView(_ sender: UIButton) {
        textField.isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }

    @objc func textFieldEditingChanged(_ sender: UITextField) {
        delegate?.editingChanged(self)
    }

}
