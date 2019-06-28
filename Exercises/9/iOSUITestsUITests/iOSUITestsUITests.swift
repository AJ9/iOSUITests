//
//  iOSUITestsUITests.swift
//  iOSUITestsUITests
//
//  Created by Gask, Adam on 02/10/2018.
//  Copyright © 2018 AJ9. All rights reserved.
//

import XCTest

class iOSUITestsUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()

        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        app = XCUIApplication()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        super.tearDown()
    }

    // Tests

    func test_checkLoginScreen_hasCorrectElements() {
        XCTAssertEqual(app.staticTexts["GreetingLabel"].label, "Welcome")
        XCTAssertEqual(app.staticTexts["TitleLabel"].label, "iOSUITests")
        XCTAssertEqual(app.staticTexts["DateLabel"].label, "2019")
        XCTAssert(app.textFields["EmailField"].exists)
        XCTAssert(app.secureTextFields["PasswordField"].exists)
        XCTAssert(app.buttons["SignInButton"].exists)
    }

    func test_loginAndCheckForShoppingBasket() {
        login()
    }
}


private extension iOSUITestsUITests {
    func login() {
        let emailField = app.textFields["EmailField"]
        emailField.tap()
        emailField.typeText("user@example.com")

        let passwordTextField = app.secureTextFields["PasswordField"]
        passwordTextField.tap()
        passwordTextField.typeText("password")

        let shoppingBasket = app.otherElements["LoginView"]
        let exists = NSPredicate(format: "exists == 0")
        expectation(for: exists, evaluatedWith: shoppingBasket, handler: nil)

        app.buttons["SignInButton"].tap()

        waitForExpectations(timeout: 5, handler: nil)
    }
}
