//
//  AddEmployeeViewModel.swift
//  EmployeeApp
//
//  Created by Nikhil Wagh on 12/05/20.
//  Copyright © 2020 Tech Mahindra. All rights reserved.
//

import Foundation

class AddEmployeeViewModel {
    
    //MARK: - Parameters
    
    var employeeName: String = ""
    var employeeAge: Int = 0
    var employeeSalary: Int = 0
    
    //MARK: - Private Methods
    
    func validateEmployeeDetails() -> (Bool, String) {
        if employeeName.isEmpty {
            return(false, Constants.employeeNameError)
        } else if (employeeAge == 0 || employeeAge <= 3) {
            return(false, Constants.employeeAgeError)
        } else if (employeeSalary == 0) {
            return(false, Constants.employeeSalaryError)
        }
        return (true, "")
    }
    
    func resetModel() {
        employeeName = ""
        employeeAge = 0
        employeeSalary = 0
    }
    
    //MARK: - API
    
    func createEmployee(completion: @escaping (Result<Bool, Error>) -> Void) {
        if validateEmployeeDetails().0 {
            let employee = NewEmployee(name: self.employeeName, salary: String(format: "%d", self.employeeSalary), age: String(format: "%d", self.employeeAge), id: 0)
            Service.sharedInstance.createEployeeAPI(employee: employee) { (result) in
                DispatchQueue.main.async {
                    switch(result) {
                    case .success:
                        completion(.success(true))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        } else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: validateEmployeeDetails().1])
            completion(.failure(error))
        }
    }
}
