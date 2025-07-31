//
//  ViewControllerTests.swift
//  PasswordResetTests
//
//  Created by Edwin Cardenas on 7/31/25.
//

import XCTest

@testable import PasswordReset

class ViewControllerTests_New_Password_Validation: XCTestCase {

    var vc: ViewController!

    let validPassword = "12345678Aa!"
    let invalidPassword = "1234Aa!"

    override func setUp() {
        super.setUp()

        vc = ViewController()
    }

    func testEmptyPassword() throws {
        vc.newPasswordText = ""

        vc.resetPasswordButtonTapped(UIButton())

        XCTAssertEqual(
            vc.newPasswordTextField.errorLabel.text,
            "Enter your password"
        )
    }

    func testInvalidPassword() throws {
        vc.newPasswordText = "*"

        vc.resetPasswordButtonTapped(UIButton())

        XCTAssertEqual(
            vc.newPasswordTextField.errorLabel.text,
            "Enter valid special chars (!@#$%^&\\) with no spaces"
        )

    }

    func testCriteriaNotMet() throws {
        vc.newPasswordText = invalidPassword

        vc.resetPasswordButtonTapped(UIButton())

        XCTAssertEqual(
            vc.newPasswordTextField.errorLabel.text,
            "Your password must meet the requirements below"
        )
    }

    func testValidPassword() throws {
        vc.newPasswordText = validPassword

        vc.resetPasswordButtonTapped(UIButton())

        XCTAssertEqual(vc.newPasswordTextField.errorLabel.text!, "")
    }
}

class ViewControllerTests_Confirm_Password_Validation: XCTestCase {

    var vc: ViewController!

    let validPassword = "12345678Aa!"
    let invalidPassword = "1234Aa!"

    override func setUp() {
        super.setUp()

        vc = ViewController()
    }

    func testEmptyPassword() throws {
        vc.confirmPasswordText = ""

        vc.resetPasswordButtonTapped(UIButton())

        XCTAssertEqual(
            vc.confirmPasswordTextField.errorLabel.text!,
            "Enter your password"
        )
    }

    func testPasswordsMatch() throws {
        vc.newPasswordText = validPassword
        vc.confirmPasswordText = validPassword

        vc.resetPasswordButtonTapped(UIButton())

        XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text, "")
    }

    func testPasswordsDoNotMatch() throws {
        vc.newPasswordText = validPassword
        vc.confirmPasswordText = invalidPassword

        vc.resetPasswordButtonTapped(UIButton())

        XCTAssertEqual(
            vc.confirmPasswordTextField.errorLabel.text,
            "Passwords do not match"
        )
    }

}

class ViewControllerTests_Show_Alert: XCTestCase {

    var vc: ViewController!

    let validPassword = "12345678Aa!"
    let invalidPassword = "1234Aa!"

    override func setUp() {
        super.setUp()

        vc = ViewController()
    }

    func testShowSuccess() throws {
        vc.newPasswordText = validPassword
        vc.confirmPasswordText = validPassword

        vc.resetPasswordButtonTapped(UIButton())

        XCTAssertNotNil(vc.alertController)

        // Optional
        XCTAssertEqual(vc.alertController!.title, "Success")
        XCTAssertEqual(
            vc.alertController!.message,
            "You have successfully changed your password."
        )
    }

    func testShowError() throws {
        vc.newPasswordText = validPassword
        vc.confirmPasswordText = invalidPassword

        vc.resetPasswordButtonTapped(UIButton())

        XCTAssertNil(vc.alertController)
    }

}
