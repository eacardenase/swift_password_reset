//
//  UIResponder+Utils.swift
//  PasswordReset
//
//  Created by Edwin Cardenas on 7/30/25.
//

import UIKit

extension UIResponder {

    private static weak var current: UIResponder?

    static func currentFirst() -> UIResponder? {
        UIResponder.current = nil

        UIApplication.shared.sendAction(
            #selector(UIResponder.trap),
            to: nil,
            from: nil,
            for: nil
        )

        return UIResponder.current
    }

    @objc private func trap() {
        UIResponder.current = self
    }

}
