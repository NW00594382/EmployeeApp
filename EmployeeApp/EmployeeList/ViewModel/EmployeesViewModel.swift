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
    
    var employeesArray = [Employee]()
    var searchedArray = [Employee]()
    
    //MARK: - Private Methods
    
    func getEmployeeData(completion: @escaping (Result<Bool, Error>) -> Void) {
        Service.sharedInstance.getEmployeeAPIData { (result) in
            DispatchQueue.main.async {
                switch(result) {
                case .success(let result):
                    self.employeesArray = result.data
                    completion(.success(true))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
