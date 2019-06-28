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

    func test_checkLoginScreen_hasCorrectText() {
        XCTAssert(app.staticTexts["iOSUITests"].exists)
        XCTAssert(app.staticTexts["2018"].exists)
    }

    func test_checkLoginScreen_hasCorrectFieldElements() {
        XCTAssert(app.textFields["EmailField"].exists)
        XCTAssert(app.textFields["PasswordField"].exists)
    }

    func test_checkLoginScreen_hasCorrectButtons() {
        XCTAssert(app.buttons["SignInButton"].exists)
    }

    func test_checkLoginScreen_displaysAnAlert_whenEnteringNoValues() {
        app.buttons["SignInButton"].tap()

        XCTAssert(app.alerts["Something went wrong!"].exists)
        XCTAssert(app.staticTexts["Invalid Email"].exists)
        XCTAssert(app.alerts["Something went wrong!"].buttons["OK"].exists)

        app.alerts["Something went wrong!"].buttons["OK"].tap()
        XCTAssertFalse(app.alerts["Something went wrong!"].exists)
    }

    func test_checkLoginScreen_displaysAnAlert_whenInvalidEmailEntered() {

        let emailField = app.textFields["EmailField"]
        emailField.tap()
        emailField.typeText("bar@foo.com")

        app.buttons["SignInButton"].tap()

        XCTAssert(app.alerts["Something went wrong!"].exists)
        XCTAssert(app.staticTexts["Invalid Email"].exists)
        XCTAssert(app.alerts["Something went wrong!"].buttons["OK"].exists)

        app.alerts["Something went wrong!"].buttons["OK"].tap()
        XCTAssertFalse(app.alerts["Something went wrong!"].exists)
    }

    func test_checkLoginScreen_displaysAnAlert_whenValidEmailEnteredNoPassword() {

        let emailField = app.textFields["EmailField"]
        emailField.tap()
        emailField.typeText("foo@bar.com")

        app.buttons["SignInButton"].tap()

        XCTAssert(app.alerts["Something went wrong!"].exists)
        XCTAssert(app.staticTexts["Invalid Password"].exists)
        XCTAssert(app.alerts["Something went wrong!"].buttons["OK"].exists)

        app.alerts["Something went wrong!"].buttons["OK"].tap()
        XCTAssertFalse(app.alerts["Something went wrong!"].exists)
    }

    func test_checkLoginScreen_displaysAnAlert_whenValidEmailEnteredInvalidPassword() {

        let emailField = app.textFields["EmailField"]
        emailField.tap()
        emailField.typeText("foo@bar.com")

        let passwordTextField = app.textFields["PasswordField"]
        passwordTextField.tap()
        passwordTextField.typeText("password")

        app.buttons["SignInButton"].tap()

        XCTAssert(app.alerts["Something went wrong!"].exists)
        XCTAssert(app.staticTexts["Invalid Password"].exists)
        XCTAssert(app.alerts["Something went wrong!"].buttons["OK"].exists)

        app.alerts["Something went wrong!"].buttons["OK"].tap()
        XCTAssertFalse(app.alerts["Something went wrong!"].exists)
    }

    func test_checkLoginScreen_succeeds_whenValidEmailAndPassword() {

        let emailField = app.textFields["EmailField"]
        emailField.tap()
        emailField.typeText("foo@bar.com")

        let passwordTextField = app.textFields["PasswordField"]
        passwordTextField.tap()
        passwordTextField.typeText("Pa$$w0rd")

        let shoppingBasket = app.navigationBars["Shopping Basket"]
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: shoppingBasket, handler: nil)

        app.buttons["SignInButton"].tap()
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(shoppingBasket.exists)
    }

    func test_defaultShoppingBasket_existsWhenLoggingIn() {
        login()
        XCTAssertEqual(app.tables.cells.count, 3)
        XCTAssert(app.tables.cells.staticTexts["Apple"].exists)
        XCTAssert(app.tables.cells.staticTexts["Orange"].exists)
        XCTAssert(app.tables.cells.staticTexts["Kiwi"].exists)
    }

    func test_addingBeerToShoppingBasket() {
        login()
        app.buttons["Add"].tap()

        let emailField = app.textFields["NameField"]
        emailField.tap()
        emailField.typeText("Beer")

        checkForShoppingBasket({
            self.app.buttons["Add"].tap()
            }())

        XCTAssert(app.tables.cells.staticTexts["Beer"].exists)
    }

    func test_addingBeerToShoppingBasket_decideAgainstThat_goToPub() {
        login()
        app.buttons["Add"].tap()

        let emailField = app.textFields["NameField"]
        emailField.tap()
        emailField.typeText("Beer")

        checkForShoppingBasket({
            self.app.buttons["Add"].tap()
            }())

        XCTAssert(app.tables.cells.staticTexts["Beer"].exists)

        swipeToDelete(row: 3)

        XCTAssertFalse(app.tables.cells.staticTexts["Beer"].exists)

        app.alerts["Shall we go to the pub?"].buttons["Yes"].tap()

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
