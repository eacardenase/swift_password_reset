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
            passwordTextField.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            passwordTextField.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
        ])
    }

}
