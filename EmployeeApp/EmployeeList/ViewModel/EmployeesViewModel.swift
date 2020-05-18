//
//  EmployeesViewModel.swift
//  EmployeeApp
//
//  Created by Nikhil Wagh on 12/05/20.
//  Copyright © 2020 Tech Mahindra. All rights reserved.
//

import Foundation

class EmployeesViewModel {
    
    //MARK: - Parameters
    
    var originalArray = [Employee]()
    var employeesArray = [Employee]()
    
    //MARK: - Private Methods
    
    func searchEmployee(with searchText: String, completion: @escaping () -> Void) {
        if !searchText.isEmpty {
            employeesArray = self.originalArray
            self.employeesArray = employeesArray.filter({ $0.employeeName.lowercased().contains(searchText.lowercased())})
        } else {
            self.employeesArray = self.originalArray
        }
        completion()
    }
    
    //MARK: - API
    
    func getEmployeeData(completion: @escaping (Result<Bool, Error>) -> Void) {
        Service.sharedInstance.getEmployeeAPIData { (result) in
            DispatchQueue.main.async {
                switch(result) {
                case .success(let result):
                    self.originalArray = result.data
                    self.employeesArray = self.originalArray
                    completion(.success(true))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func deleteEmployee(employeeID: Int, completion: @escaping (Result<DeleteEmployeeModel, Error>) -> Void) {
        Service.sharedInstance.deleteEmployeeAPI(employeeID: employeeID) { (result) in
            DispatchQueue.main.async {
                switch(result) {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
