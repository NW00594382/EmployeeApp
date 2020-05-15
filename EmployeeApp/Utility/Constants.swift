//
//  Constants.swift
//  EmployeeApp
//
//  Created by Nikhil Wagh on 12/05/20.
//  Copyright © 2020 Tech Mahindra. All rights reserved.
//

import Foundation

struct Constants {
    
    struct BaseURL {
        static let url = "http://dummy.restapiexample.com"
    }
    struct API {
        static let getEmployees = "/api/v1/employees"
        static let createEmployee = "/api/v1/create"
        static let deleteEmployee = "/api/v1/delete"
    }
    static let errorTitle = "Error"
    static let ok = "OK"
    static let applicationJson = "application/json"
    static let contentType = "Content-Type"
    static let post = "POST"
    static let delete = "DELETE"
    static let success = "success"
    static let employeeCell = "EmployeeCell"
    static let employeeNameError = "Please enter employee name."
    static let employeeAgeError = "Employee age is incorrect. Please enter valid value."
    static let employeeSalaryError = "Employee salary is incorrect. Please enter valid value."
}
