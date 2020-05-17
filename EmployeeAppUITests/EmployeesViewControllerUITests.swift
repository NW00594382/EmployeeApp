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
        print(app.debugDescription)
    }

    func testForCellExistence() {
        let employeeTableView = app.tables.matching(identifier: "EmployeeTableViewIndentifier")
        let firstCell = employeeTableView.cells.element(matching: .cell, identifier: "CellIndentifier_0")
        let existencePredicate = NSPredicate(format: "exists == 1")
        let expectationEval = expectation(for: existencePredicate, evaluatedWith: firstCell, handler: nil)
        let mobWaiter = XCTWaiter.wait(for: [expectationEval], timeout: 5)
        XCTAssert(XCTWaiter.Result.completed == mobWaiter, "Test Case Failed.")
        firstCell.tap()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
