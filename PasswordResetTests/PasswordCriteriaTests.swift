//
//  PasswordCriteriaTests.swift
//  PasswordResetTests
//
//  Created by Edwin Cardenas on 7/31/25.
//

import XCTest

@testable import PasswordReset

class PasswordCriteriaTests: XCTestCase {

    func testShort() throws {
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("1234567"))
    }

    func testLong() throws {
        XCTAssertFalse(
            PasswordCriteria.lengthCriteriaMet(
                "123456712345671234567123456712345"
            )
        )
    }

    func testValidShort() throws {
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12345678"))
    }

    func testValidLong() throws {
        XCTAssertTrue(
            PasswordCriteria.lengthCriteriaMet(
                "12345671234567123456712345671234"
            )
        )
    }

}
