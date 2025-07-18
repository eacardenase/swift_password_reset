//
//  ViewController.swift
//  PasswordReset
//
//  Created by Edwin Cardenas on 7/17/25.
//

import UIKit

class ViewController: UIViewController {

    let newPasswordTextField = PasswordTextField(placeHolderText: "New Password")
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

        newPasswordTextField.delegate = self

        setupViews()
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

}

// MARK: - Actions

extension ViewController {

    @objc func resetPasswordButtonTapped(_ sender: UIButton) {
        print(#function)
    }

}

// MARK: - PasswordTextFieldDelegate

extension ViewController: PasswordTextFieldDelegate {

    func editingChanged(_ sender: PasswordTextField) {
        if sender === newPasswordTextField {
            statusView.updateDisplay(sender.textField.text ?? "")
        }
    }

}
