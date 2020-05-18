//
//  EmployeesViewControllerUITests.swift
//  EmployeeAppUITests
//
//  Created by Nikhil Wagh on 5/17/20.
//  Copyright © 2020 Tech Mahindra. All rights reserved.
//

import XCTest

class EmployeesViewControllerUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }
    
    func testEmployeesTableViewCellIsExist() {
        let employeeTableView = app.tables.matching(identifier: Constants.employeeTableViewIndentifier)
        let firstCell = employeeTableView.cells.element(matching: .cell, identifier: "CellIndentifier_0")
        let existencePredicate = NSPredicate(format: "exists == 1")
        let expectationEval = expectation(for: existencePredicate, evaluatedWith: firstCell, handler: nil)
        let mobWaiter = XCTWaiter.wait(for: [expectationEval], timeout: 5)
        XCTAssert(XCTWaiter.Result.completed == mobWaiter, "Test Case Failed.")
        firstCell.tap()
    }
    
    func testEmployeesTableViewInteraction() {
        let employeeTableView = app.tables[Constants.employeeTableViewIndentifier]
        XCTAssertTrue(employeeTableView.exists, "Employee TableView Exists")
        let employeeTableViewCells = employeeTableView.cells
        if employeeTableViewCells.count > 0 {
            let count: Int = (employeeTableViewCells.count - 1)
            let promise = expectation(description: "Wait for table cells")
            for i in stride(from: 0, to: count , by: 1) {
                let employeeCell = employeeTableViewCells.element(boundBy: i)
                XCTAssertTrue(employeeCell.exists, "\(i) cell exists")
                employeeCell.tap()
                if i == (count - 1) {
                    promise.fulfill()
                }
            }
            waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(true, "All Employee cells exists")
            
        } else {
            XCTAssert(false, "Employee Table View cells does noy exist.")
        }
    }
    
    func testSearchEmployee() {
        let searchTextField = app.searchFields["Enter employee name..."]
        XCTAssertTrue(searchTextField.exists)
        searchTextField.tap()
        searchTextField.typeText("Jen")
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards.buttons[\"Search\"]",".buttons[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    func testSearchEmployeeCancelAndReEnterText() {
        let searchTextField = app.searchFields["Enter employee name..."]
        XCTAssertTrue(searchTextField.exists)
        searchTextField.tap()
        searchTextField.typeText("Jen")
        searchTextField.buttons["Clear text"].tap()
        searchTextField.tap()
        searchTextField.typeText("Re")
        app.buttons["Search"].tap()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
