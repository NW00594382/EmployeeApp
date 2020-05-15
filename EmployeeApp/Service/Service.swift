//
//  Service.swift
//  EmployeeApp
//
//  Created by Nikhil Wagh on 12/05/20.
//  Copyright © 2020 Tech Mahindra. All rights reserved.
//

import Foundation

struct Service {
    
    static let sharedInstance = Service()
    
    //MARK:- GET
    /// This method is to GET facts data from API
    /// - Parameter completion: Result parameter is to return Success or Failure
    func getEmployeeAPIData(completion: @escaping (Result<EmployeeModel, Error>) -> Void) {
        let urlString = "\(Constants.BaseURL.url)\(Constants.API.getEmployees)"
        guard let serviceURL = URL.init(string: urlString) else { return }
        URLSession.shared.dataTask(with: serviceURL) { (data, response, error) in
            if let err = error {
                completion(.failure(err))
                print(err.localizedDescription)
            } else {
                guard let data = data else { return }
                let jsonString = String(decoding: data, as: UTF8.self)
                do {
                    let results = try JSONDecoder().decode(EmployeeModel.self, from: jsonString.data(using: .utf8)!)
                    print("employees count: \(results.data.count)")
                    completion(.success(results))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            }.resume()
    }
    
    //MARK: - POST
    func createEployeeAPI(employee: NewEmployee, completion: @escaping (Result<CreateEmployeeModel, Error>) -> Void) {
        let urlString = "\(Constants.BaseURL.url)\(Constants.API.createEmployee)"
        guard let serviceURL = URL.init(string: urlString) else { return }
        var request = URLRequest(url: serviceURL)
        request.httpMethod = Constants.post
        request.addValue(Constants.applicationJson, forHTTPHeaderField: Constants.contentType)
        guard let body = try? JSONEncoder().encode(employee) else { return }
        request.httpBody = body
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error {
                completion(.failure(err))
                print(err.localizedDescription)
            } else {
                guard let data = data else { return }
                let jsonString = String(decoding: data, as: UTF8.self)
                do {
                    let results = try JSONDecoder().decode(CreateEmployeeModel.self, from: jsonString.data(using: .utf8)!)
                    completion(.success(results))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            }.resume()
    }
    
    //MARK: - DELETE
    func deleteEmployeeAPI(employeeID: Int, completion: @escaping (Result<DeleteEmployeeModel, Error>) -> Void) {
        let urlString = "\(Constants.BaseURL.url)\(Constants.API.deleteEmployee)/\(employeeID)"
        guard let serviceURL = URL.init(string: urlString) else { return }
        var request = URLRequest(url: serviceURL)
        request.httpMethod = Constants.delete
        request.addValue(Constants.applicationJson, forHTTPHeaderField: Constants.contentType)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error {
                completion(.failure(err))
                print(err.localizedDescription)
            } else {
                guard let data = data else { return }
                let jsonString = String(decoding: data, as: UTF8.self)
                do {
                    let results = try JSONDecoder().decode(DeleteEmployeeModel.self, from: jsonString.data(using: .utf8)!)
                    completion(.success(results))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            }.resume()
    }
}
