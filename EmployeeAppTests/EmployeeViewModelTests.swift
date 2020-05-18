//
//  EmployeeViewModelTests.swift
//  EmployeeAppTests
//
//  Created by Nikhil Wagh on 5/16/20.
//  Copyright © 2020 Tech Mahindra. All rights reserved.
//

import XCTest
@testable import EmployeeApp

class EmployeeViewModelTests: XCTestCase {
    
    var employeeVM = EmployeesViewModel()
    let service = Service()
    
    override func setUp() {
        let bundle = Bundle.main.url(forResource: "Employees", withExtension: "json")
        let jsonData = try! Data.init(contentsOf: bundle!)
        let results = try! JSONDecoder().decode(EmployeeModel.self, from: jsonData)
        employeeVM.originalArray = results.data
        employeeVM.employeesArray = employeeVM.originalArray
    }
    
    func testGetEmployeesAPI() {
        let expectation = self.expectation(description: "Valid API response will received.")
        employeeVM.getEmployeeData { (result) in
            switch(result) {
            case .success(let result):
                XCTAssertNotNil(result)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 7, handler: nil)
    }
    
    func testEmployeeViewModelCheckOriginalAndEmployeeArrayIsEqual() {
        let originalArray = employeeVM.originalArray.count
        let employeeArray = employeeVM.employeesArray.count
        XCTAssertEqual(employeeArray, originalArray)
    }
    
    func testEmployeeDataNotNil() {
        let employee = employeeVM.employeesArray[0]
        XCTAssertNotNil(employee)
        XCTAssertEqual(employee.id, "1")
        XCTAssertEqual(employee.employeeName, "Tiger Nixon")
        XCTAssertEqual(employee.employeeAge, "61")
        XCTAssertEqual(employee.employeeSalary, "320800")
    }
    
    func testEmployeeDataNil() {
        let employee = employeeVM.employeesArray[0]
        XCTAssertNotEqual(employee.id, "")
        XCTAssertNotEqual(employee.employeeName, "")
        XCTAssertNotEqual(employee.employeeAge, "")
        XCTAssertNotEqual(employee.employeeSalary, "")
    }
    
    func testCheckIfAllEmployeesNameNotNil() {
        for employee in employeeVM.employeesArray {
            XCTAssertNotNil(employee.employeeName)
        }
    }
    
    func testEmployeePartialSearchResult() {
        employeeVM.searchEmployee(with: "Jen") {
            XCTAssertEqual(self.employeeVM.employeesArray.count, 2)
        }
        let firstSearchedResult = employeeVM.employeesArray[0]
        XCTAssertEqual(firstSearchedResult.id, "11")
        XCTAssertEqual(firstSearchedResult.employeeName, "Jena Gaines")
        XCTAssertEqual(firstSearchedResult.employeeAge, "30")
        XCTAssertEqual(firstSearchedResult.employeeSalary, "90560")
        
        let secondSearchedResult = employeeVM.employeesArray[1]
        XCTAssertEqual(secondSearchedResult.id, "21")
        XCTAssertEqual(secondSearchedResult.employeeName, "Jenette Caldwell")
        XCTAssertEqual(secondSearchedResult.employeeAge, "30")
        XCTAssertEqual(secondSearchedResult.employeeSalary, "345000")
    }
    
    func testEmployeeCompleteSearchResult() {
        employeeVM.searchEmployee(with: "Haley") {
            XCTAssertEqual(self.employeeVM.employeesArray.count, 1)
        }
        let searchedResult = employeeVM.employeesArray[0]
        XCTAssertEqual(searchedResult.id, "14")
        XCTAssertEqual(searchedResult.employeeName, "Haley Kennedy")
        XCTAssertEqual(searchedResult.employeeAge, "43")
        XCTAssertEqual(searchedResult.employeeSalary, "313500")
    }
    
    
    override func tearDown() {
        employeeVM.originalArray = []
        employeeVM.employeesArray = []
    }
}
