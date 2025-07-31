//
//  PasswordStatusViewTests.swift
//  PasswordResetTests
//
//  Created by Edwin Cardenas on 7/31/25.
//

import XCTest

@testable import PasswordReset

class PasswordStatusViewTests_ShowCheckmarkOrReset_Inline_Validation: XCTestCase
{

    var statusView: PasswordStatusView!

    let validPassword = "12345678Aa!"
    let tooShortPassword = "123Aa!"

    override func setUp() {
        super.setUp()

        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = true  // inline validation
    }

    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)

        XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isCheckMarkImage)
    }

    func testTooShortPassword() throws {
        statusView.updateDisplay(tooShortPassword)

        XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isResetImage)
    }

}

class PasswordStatusViewTests_ShowCheckmarkOrRedX_Loss_Of_Focus_Validation:
    XCTestCase
{

    var statusView: PasswordStatusView!

    let validPassword = "12345678Aa!"
    let tooShortPassword = "123Aa!"

    override func setUp() {
        super.setUp()

        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = false  // loss of focus validation
    }

    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)

        XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isCheckMarkImage)
    }

    func testTooShortPassword() throws {
        statusView.updateDisplay(tooShortPassword)

        XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isXmarkImage)
    }

}

class PasswordStatusViewTests_Three_Of_Four_Criteria_Met_Validation: XCTestCase
{

    var statusView: PasswordStatusView!

    let twoOfFourPassword = "1234567a"
    let threeOfFourPassword = "123456Aa"
    let fourOfPassword = "12345678Aa!"

    override func setUp() {
        super.setUp()

        statusView = PasswordStatusView()
    }

    func testTwoOfFour() throws {
        XCTAssertFalse(statusView.validate(twoOfFourPassword))
    }

    func testThreeOfFour() throws {
        XCTAssertTrue(statusView.validate(threeOfFourPassword))
    }

    func testValidPassword() throws {
        XCTAssertTrue(statusView.validate(fourOfPassword))
    }

}
