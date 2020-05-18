//
//  AddEmployeeViewControllerUITests.swift
//  EmployeeAppUITests
//
//  Created by Nikhil Wagh on 5/18/20.
//  Copyright © 2020 Tech Mahindra. All rights reserved.
//

import XCTest

class AddEmployeeViewControllerUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }
    
    func testAddEmployeesTextFieldsValidation() {
        
        let validName = "Sharon Orton"
        let validAge = "21"
        let validSalary = "21000"
        
        app.navigationBars["Employee List"].buttons["Add"].tap()
        
        let submitButton = app.buttons["Submit"]
        submitButton.tap()
        let okButton = app.alerts["Error"].buttons["OK"]
        okButton.tap()
        
        let enterNameTextField = app.textFields["Enter name..."]
        XCTAssertTrue(enterNameTextField.exists)
        enterNameTextField.tap()
        enterNameTextField.typeText(validName)
        submitButton.tap()
        okButton.tap()
        
        let enterAgeTextField = app.textFields["Enter age..."]
        XCTAssertTrue(enterAgeTextField.exists)
        enterAgeTextField.tap()
        enterAgeTextField.typeText(validAge)
        submitButton.tap()
        okButton.tap()
        
        let enterSalaryTextField = app.textFields["Enter salary..."]
        XCTAssertTrue(enterSalaryTextField.exists)
        enterSalaryTextField.tap()
        enterSalaryTextField.typeText(validSalary)
        submitButton.tap()
        app.alerts["success"].buttons["OK"].tap()
    }
    
    func testAddEmployeesTextFields() {
        
        let validName = "Reny Alex"
        let validAge = "21"
        let validSalary = "21000"
        
        app.navigationBars["Employee List"].buttons["Add"].tap()
        
        let enterNameTextField = app.textFields["Enter name..."]
        XCTAssertTrue(enterNameTextField.exists)
        enterNameTextField.tap()
        enterNameTextField.typeText(validName)
        
        let enterAgeTextField = app.textFields["Enter age..."]
        XCTAssertTrue(enterAgeTextField.exists)
        enterAgeTextField.tap()
        enterAgeTextField.typeText(validAge)
        
        let enterSalaryTextField = app.textFields["Enter salary..."]
        XCTAssertTrue(enterSalaryTextField.exists)
        enterSalaryTextField.tap()
        enterSalaryTextField.typeText(validSalary)
        
        let submitButton = app.buttons["Submit"]
        XCTAssertTrue(submitButton.exists)
        submitButton.tap()
        app.alerts["success"].buttons["OK"].tap()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
