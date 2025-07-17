//
//  PasswordTextField.swift
//  PasswordReset
//
//  Created by Edwin Cardenas on 7/17/25.
//

import UIKit

class PasswordTextField: UIView {

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

extension PasswordTextField {

    private func setupViews() {
        backgroundColor = .systemGreen
    }

}
