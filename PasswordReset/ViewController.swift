//
//  ViewController.swift
//  PasswordReset
//
//  Created by Edwin Cardenas on 7/17/25.
//

import UIKit

class ViewController: UIViewController {

    let newPasswordTextField = PasswordTextField(
        placeHolderText: "New Password"
    )
    let statusView = PasswordStatusView()
    let confirmPasswordTextField = PasswordTextField(
        placeHolderText: "Re-enter new Password"
    )
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

        setup()
        setupViews()
    }

}

// MARK: - Helpers

extension ViewController {

    private func setup() {
        newPasswordTextField.delegate = self

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )

        view.addGestureRecognizer(tapGesture)
    }

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

}

// MARK: - Actions

extension ViewController {

    @objc func resetPasswordButtonTapped(_ sender: UIButton) {
        print(#function)
    }

    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

}

// MARK: - PasswordTextFieldDelegate

extension ViewController: PasswordTextFieldDelegate {

    func editingChanged(_ sender: PasswordTextField) {
        if sender === newPasswordTextField {
            statusView.updateDisplay(sender.textField.text ?? "")
        }
    }

    func editingDidEnd(_ sender: PasswordTextField) {
        print(sender.textField.text ?? "")
    }

}
