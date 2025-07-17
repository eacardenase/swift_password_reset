//
//  ViewController.swift
//  PasswordReset
//
//  Created by Edwin Cardenas on 7/17/25.
//

import UIKit

class ViewController: UIViewController {

    let passwordTextField: PasswordTextField = {
        let view = PasswordTextField(placeHolderText: "New Password")

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

}

// MARK: - Helpers

extension ViewController {

    private func setupViews() {
        view.addSubview(passwordTextField)

        NSLayoutConstraint.activate([
            passwordTextField.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
            passwordTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16
            ),
            passwordTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16
            ),
        ])
    }

}
