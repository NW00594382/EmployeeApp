//
//  CreateEmployeeModel.swift
//  EmployeeApp
//
//  Created by Nikhil Wagh on 12/05/20.
//  Copyright © 2020 Tech Mahindra. All rights reserved.
//

import Foundation

// MARK: - CreateEmployeeModel
struct CreateEmployeeModel: Codable {
    let status: String
    let data: NewEmployee
}

// MARK: - DataClass
struct NewEmployee: Codable {
    let name, salary, age: String
    let id: Int
}
