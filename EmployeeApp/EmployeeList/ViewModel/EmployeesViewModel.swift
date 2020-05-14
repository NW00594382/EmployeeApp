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
    var searchedArray = [Employee]()
    
    //MARK: - Private Methods
    
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
    
    func searchEmployee(with searchText: String, completion: @escaping () -> Void) {
        if !searchText.isEmpty {
            searchedArray = self.originalArray
            self.employeesArray = searchedArray.filter({ $0.employeeName.lowercased().contains(searchText.lowercased())})
        } else {
            self.employeesArray = self.originalArray
        }
        completion()
    }
}
