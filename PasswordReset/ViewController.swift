//
//  ViewController.swift
//  PasswordReset
//
//  Created by Edwin Cardenas on 7/17/25.
//

import UIKit

class ViewController: UIViewController {

    lazy var newPasswordTextField: PasswordTextField = {
        let textField = PasswordTextField(
            placeHolderText: "New Password"
        )

        let newPasswordValidator: PasswordTextField.CustomValidator = {
            (text: String?) -> (Bool, String) in

            guard let text = text, !text.isEmpty else {
                self.statusView.reset()
                return (false, "Enter your password")
            }

            let validChars =
                "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,@:?!()$\\/#"
            let invalidChars = CharacterSet(charactersIn: validChars).inverted

            guard text.rangeOfCharacter(from: invalidChars) == nil else {
                self.statusView.reset()

                return (
                    false,
                    "Enter valid special chars (!@#$%^&\\) with no spaces"
                )
            }

            self.statusView.updateDisplay(text)

            if !self.statusView.validate(text) {
                return (false, "Your password must meet the requirements below")
            }

            return (true, "")
        }

        textField.customValidator = newPasswordValidator
        textField.delegate = self

        return textField
    }()
    let statusView = PasswordStatusView()
    lazy var confirmPasswordTextField: PasswordTextField = {
        let textField = PasswordTextField(
            placeHolderText: "Re-enter new Password"
        )

        let passwordValidator: PasswordTextField.CustomValidator = {
            text in

            guard let text = text, !text.isEmpty else {
                return (false, "Enter your password")
            }

            guard text == self.newPasswordTextField.text else {
                return (false, "Passwords do not match")
            }

            return (true, "")
        }

        textField.customValidator = passwordValidator
        textField.delegate = self

        return textField
    }()
    lazy var resetButton: UIButton = {
        let button = UIButton(configuration: .filled())

        button.setTitle("Reset password", for: .normal)
        button.addTarget(
            self,
            action: #selector(resetPasswordButtonTapped),
            for: .touchUpInside
        )

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupKeyboardHiding()

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )

        view.addGestureRecognizer(tapGesture)
    }

}

// MARK: - Helpers

extension ViewController {

    private func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [
            newPasswordTextField,
            statusView,
            confirmPasswordTextField,
            resetButton,
        ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
            stackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16
            ),
            stackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16
            ),
        ])
    }

    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        alertController.addAction(UIAlertAction(title: "OK", style: .default))

        present(alertController, animated: true)
    }

}

// MARK: - Actions

extension ViewController {

    @objc func resetPasswordButtonTapped(_ sender: UIButton) {
        view.endEditing(true)

        let isValidNewPassword = newPasswordTextField.validate()
        let isValidConfirmPassword = confirmPasswordTextField.validate()

        if isValidNewPassword && isValidConfirmPassword {
            showAlert(
                title: "Success",
                message: "You have successfully changed your password."
            )
        }
    }

    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

}

// MARK: - PasswordTextFieldDelegate

extension ViewController: PasswordTextFieldDelegate {

    func editingDidBegin(_ sender: PasswordTextField) {
        statusView.shouldResetCriteria = true

        editingChanged(sender)
    }

    func editingChanged(_ sender: PasswordTextField) {
        if sender === newPasswordTextField {
            statusView.updateDisplay(sender.text ?? "")
        }
    }

    func editingDidEnd(_ sender: PasswordTextField) {
        statusView.shouldResetCriteria = false

        sender.validate()
    }

}

// MARK: - Keyboard

extension ViewController {

    @objc private func keyboardWillShow(_ sender: NSNotification) {
        guard let userInfo = sender.userInfo,
            let keyboardFrame = userInfo[
                UIResponder.keyboardFrameEndUserInfoKey
            ] as? CGRect,
            let currentTextField = UIResponder.currentFirst() as? UITextField
        else {
            return
        }

        let keyboardTopY = keyboardFrame.origin.y
        let convertedTextFieldFrame = view.convert(
            currentTextField.frame,
            from: currentTextField.superview
        )

        let textFieldBottomY =
            convertedTextFieldFrame.origin.y
            + convertedTextFieldFrame.size.height

        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1

            view.frame.origin.y = newFrameY
        }
    }

    @objc private func keyboardWillHide(_ sendeR: NSNotification) {
        view.frame.origin.y = 0
    }

}

// MARK: - Tests

extension ViewController {

    var newPasswordText: String? {
        get { newPasswordTextField.text }
        set { newPasswordTextField.text = newValue }
    }

    var confirmPasswordText: String? {
        get { confirmPasswordTextField.text }
        set { confirmPasswordTextField.text = newValue }
    }

}
