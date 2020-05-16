//
//  AddEmployeeViewModelTests.swift
//  EmployeeAppTests
//
//  Created by Nikhil Wagh on 5/16/20.
//  Copyright © 2020 Tech Mahindra. All rights reserved.
//

import XCTest
@testable import EmployeeApp

class AddEmployeeViewModelTests: XCTestCase {
    
    var addEmployeeVM = AddEmployeeViewModel()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testViewModelInitialProperties() {
        XCTAssertEqual(addEmployeeVM.employeeName, "")
        XCTAssertEqual(addEmployeeVM.employeeAge, "")
        XCTAssertEqual(addEmployeeVM.employeeSalary, "")
    }
    
    func testValidationAfterEnteringTextFieldValueOneByOne() {
        let validateBeforeNewEmployeeNameEntered = addEmployeeVM.validateEmployeeDetails()
        XCTAssertFalse(validateBeforeNewEmployeeNameEntered.0)
        XCTAssertEqual(validateBeforeNewEmployeeNameEntered.1, Constants.employeeNameError)
        addEmployeeVM.employeeName = "Patrick willson"
        let validateAfterNewEmployeeNameEntered = addEmployeeVM.validateEmployeeDetails()
        XCTAssertFalse(validateAfterNewEmployeeNameEntered.0)
        XCTAssertEqual(validateAfterNewEmployeeNameEntered.1, Constants.employeeAgeEmptyError)
        addEmployeeVM.employeeAge = "28"
        let validateAfterNewEmployeeAgeEntered = addEmployeeVM.validateEmployeeDetails()
        XCTAssertFalse(validateAfterNewEmployeeAgeEntered.0)
        XCTAssertEqual(validateAfterNewEmployeeAgeEntered.1, Constants.employeeSalaryEmptyError)
        addEmployeeVM.employeeSalary = "20000"
        let validateAfterNewEmployeeSalaryEntered = addEmployeeVM.validateEmployeeDetails()
        XCTAssertTrue(validateAfterNewEmployeeSalaryEntered.0)
        XCTAssertEqual(validateAfterNewEmployeeSalaryEntered.1, "")
    }
    
    func testValidationAfterEnteringAllTextFieldValue() {
        addEmployeeVM.employeeName = "Patrick willson"
        addEmployeeVM.employeeAge = "28"
        addEmployeeVM.employeeSalary = "20000"
        let validateAfterNewEmployeeSalaryEntered = addEmployeeVM.validateEmployeeDetails()
        XCTAssertTrue(validateAfterNewEmployeeSalaryEntered.0)
        XCTAssertEqual(validateAfterNewEmployeeSalaryEntered.1, "")
    }
    
    func testPropertiesValuesAfterResetModel() {
        addEmployeeVM.resetModel()
        XCTAssertEqual(addEmployeeVM.employeeName, "")
        XCTAssertEqual(addEmployeeVM.employeeAge, "")
        XCTAssertEqual(addEmployeeVM.employeeSalary, "")
    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
}
