//
//  EmployeeModel.swift
//  EmployeeApp
//
//  Created by Nikhil Wagh on 13/05/20.
//  Copyright © 2020 Tech Mahindra. All rights reserved.
//

import Foundation

// MARK: - EmployeeModel
struct EmployeeModel: Decodable {
    let status: String
    let data: [Employee]
}

// MARK: - Datum
struct Employee: Decodable {
    let id, employeeName, employeeSalary, employeeAge: String
    let profileImage: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case employeeAge = "employee_age"
        case profileImage = "profile_image"
    }
}
