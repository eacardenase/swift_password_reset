//
//  PasswordCriteria.swift
//  PasswordReset
//
//  Created by Edwin Cardenas on 7/18/25.
//

import Foundation

struct PasswordCriteria {

    static func lengthCriteriaMet(_ text: String) -> Bool {
        text.count >= 8 && text.count <= 32
    }

    static func noSpaceCriteriaMet(_ text: String) -> Bool {
        text.rangeOfCharacter(from: NSCharacterSet.whitespaces) == nil
    }

    static func lengthAndNoSpaceMet(_ text: String) -> Bool {
        lengthCriteriaMet(text) && noSpaceCriteriaMet(text)
    }

    static func uppercaseMet(_ text: String) -> Bool {
        text.contains(/[A-Z]+/)
    }

    static func lowercaseMet(_ text: String) -> Bool {
        text.contains(/[a-z]+/)
    }

    static func digitMet(_ text: String) -> Bool {
        text.contains(/[0-9]+/)
    }

    static func specialCharacter(_ text: String) -> Bool {
        // text.range(of: "[!@#$%^&\\\\]", options: .regularExpression) != nil
        text.contains(/[!@#$%^&\\]/)
    }

}
