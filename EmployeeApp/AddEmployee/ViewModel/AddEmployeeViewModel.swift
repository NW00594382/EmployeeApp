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
    var employeeAge: String = ""
    var employeeSalary: String = ""
    
    //MARK: - Private Methods
    
    func isInValidInput(nameString: String) -> Bool {
        let regex = try? NSRegularExpression(pattern: Constants.nameRegularExpression, options: [])
        if regex!.firstMatch(in: nameString, options: [], range: NSMakeRange(0, nameString.count)) != nil {
            return true
        }
        return false
    }
    
    func validateEmployeeDetails() -> (Bool, String) {
        if employeeName.isEmpty || isInValidInput(nameString: employeeName) {
            return(false, employeeName.isEmpty ? Constants.employeeNameError : Constants.employeeNameInValidError)
        } else if (employeeAge.isEmpty || employeeAge.count > 2) {
            return(false, employeeAge.isEmpty ? Constants.employeeAgeEmptyError : Constants.employeeAgeError)
        } else if (employeeSalary.isEmpty || employeeSalary.count > 8) {
            return(false, employeeSalary.isEmpty ? Constants.employeeSalaryEmptyError : Constants.employeeSalaryError)
        }
        return (true, "")
    }
    
    func resetModel() {
        employeeName = ""
        employeeAge = ""
        employeeSalary = ""
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
