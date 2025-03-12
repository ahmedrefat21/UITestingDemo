//
//  UITestingBootcampView_UITests.swift
//  UITestingDemo_UITests
//
//  Created by Ahmed Refat on 04/03/2025.
//

import XCTest

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[struct]_[ui component]_[expected result]
// Testing Structure: Given, When, Then


class UITestingBootcampView_UITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
    }

    func test_UITestingBootcampView_signUpButton_shouldNotSignIn() {
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: false)
        
        // When
        let navBar = app.navigationBars["Welcome"]
        
        // Then
        XCTAssertFalse(navBar.exists)
    }
    
    func test_UITestingBootcampView_signUpButton_shouldSignIn() {
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: true)
        
        // When
        let navBar = app.navigationBars["Welcome"]
        
        // Then
        XCTAssertTrue(navBar.exists)
    }
    
    func test_SignedInHomeView_showAlertButton_shouldDisplayAlert() {
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: true)
        
        // When
        tapAlertButton(shouldDismissAlert: false)

        // Then
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.exists)
    }
    
    func test_SignedInHomeView_showAlertButton_shouldDisplayAndDismissAlert() {
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: true)
        
        // When
        tapAlertButton(shouldDismissAlert: true)
        
        // Then
        let alertExists = app.alerts.firstMatch.waitForExistence(timeout: 5)
        XCTAssertFalse(alertExists)
    }
    
    func test_SignedInHomeView_navigationLinkToDestination_shouldNavigateToDestination() {
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: true)
        
        // When
        tapNavigationLink(shouldDismissDestination: false)
        
        // Then
        let destinationText = app.staticTexts["Destination"]
        XCTAssertTrue(destinationText.exists)
    }
    
    func test_SignedInHomeView_navigationLinkToDestination_shouldNavigateToDestinationAndGoBack() {
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: true)
        
        // When
        tapNavigationLink(shouldDismissDestination: true)
        
        // Then
        let navBar = app.navigationBars["Welcome"]
        XCTAssertTrue(navBar.exists)
    }
    
    func test_UITestingBootcampView_invalidEmail_shouldShowError() {
        // Given
        //signUpAndSignIn(shouldTypeOnKeyboard: true, email: "invalid-email")
        typeEmail("invalid-email")
        
        // Then
        let errorText = app.staticTexts["EmailErrorText"]
        XCTAssertTrue(errorText.exists)
        
        let signUpButton = app.buttons["SignUpButton"]
        XCTAssertFalse(signUpButton.isEnabled)
    }
    
    func test_UITestingBootcampView_validEmail_shouldNotShowError() {
        // Given
        //signUpAndSignIn(shouldTypeOnKeyboard: true)
        typeEmail()

        // Then
        let errorText = app.staticTexts["EmailErrorText"]
        XCTAssertFalse(errorText.exists)
        
        let signUpButton = app.buttons["SignUpButton"]
        XCTAssertTrue(signUpButton.isEnabled)
    }

}

// MARK: FUNCTIONS

extension UITestingBootcampView_UITests {
    
    func signUpAndSignIn(shouldTypeOnKeyboard: Bool, email: String = "test@example.com") {
        let textfield = app.textFields["SignUpTextField"]
        textfield.tap()
        
        if shouldTypeOnKeyboard {
            textfield.typeText(email)
        }

        let returnButton = app.buttons["Return"]
        returnButton.tap()
        
        let signUpButton = app.buttons["SignUpButton"]
        signUpButton.tap()
    }
    
    func tapAlertButton(shouldDismissAlert: Bool) {
        let showAlertButton = app.buttons["ShowAlertButton"]
        showAlertButton.tap()
        
        if shouldDismissAlert {
            let alert = app.alerts.firstMatch
            let alertOKButton = alert.buttons["OK"]
            
            //sleep(1)
            let alertOKButtonexists = alertOKButton.waitForExistence(timeout: 5)
            XCTAssertTrue(alertOKButtonexists)
            
            alertOKButton.tap()
        }
    }
    
    func tapNavigationLink(shouldDismissDestination: Bool) {
        let navLinkButton = app.buttons["NavigationLinkToDestination"]
        navLinkButton.tap()
        
        if shouldDismissDestination {
            let backButton = app.navigationBars.buttons["Welcome"]
            backButton.tap()
        }
    }
    
    func typeEmail(_ email: String = "test@example.com") {
        let textfield = app.textFields["SignUpTextField"]
        textfield.tap()
        textfield.typeText(email)
        
        let returnButton = app.buttons["Return"]
        returnButton.tap()
    }
    
}
