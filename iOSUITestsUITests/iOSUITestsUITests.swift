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

    // Beginners

    func test_checkLoginScreen_hasCorrectText() {
        XCTAssert(app.staticTexts["iOSUITests"].exists)
        XCTAssert(app.staticTexts["2018"].exists)
    }

    func test_checkLoginScreen_hasCorrectFieldElements() {

    }

    func test_checkLoginScreen_hasCorrectButtons() {

    }

    // Intermediate

    func test_checkLoginScreen_displaysAnAlert_whenEnteringNoValues() {

    }

    // Valid Email is: 'foo@bar.com'
    func test_checkLoginScreen_displaysAnAlert_whenInvalidEmailEntered() {

    }

    // Valid Email is: 'foo@bar.com'
    func test_checkLoginScreen_displaysAnAlert_whenValidEmailEnteredNoPassword() {

    }

    // Valid Email is: 'foo@bar.com'
    // Valid Password is: 'Pa$$w0rd'
    func test_checkLoginScreen_displaysAnAlert_whenValidEmailEnteredInvalidPassword() {

    }

    // Valid Email is: 'foo@bar.com'
    // Valid Password is: 'Pa$$w0rd'
    func test_checkLoginScreen_succeeds_whenValidEmailAndPassword() {

    }

    // Advanced

    func test_defaultShoppingBasket_existsWhenLoggingIn() {

    }

    func test_addingBeerToShoppingBasket() {

    }

    func test_addingBeerToShoppingBasket_decideAgainstThat_goToPub() {

    }
}

private extension iOSUITestsUITests {
    func login() {
        let emailField = app.textFields["EmailField"]
        emailField.tap()
        emailField.typeText("foo@bar.com")

        let passwordTextField = app.textFields["PasswordField"]
        passwordTextField.tap()
        passwordTextField.typeText("Pa$$w0rd")

        app.buttons["SignInButton"].tap()

        sleep(3)
    }

    func checkForShoppingBasket(_ action: @autoclosure @escaping () -> Void) {
        let shoppingBasket = app.navigationBars["Shopping Basket"]
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: shoppingBasket, handler: nil)
        action()
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(shoppingBasket.exists)
    }

    func swipeToDelete(row: Int) {
        let tablesQuery = app.tables.cells
        tablesQuery.element(boundBy: row).swipeLeft()
        tablesQuery.element(boundBy: row).buttons["Delete"].tap()
    }
}
