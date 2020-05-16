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
    
    //MARK:- API's calls
    
    /// This method is to get Employees
    func getEmployeeAPIData(completion: @escaping (Result<EmployeeModel, Error>) -> Void) {
        let urlString = "\(Constants.BaseURL.url)\(Constants.API.getEmployees)"
        getRequest(requestUrl: URL(string: urlString)!, resultType: EmployeeModel.self) { result in
            switch(result) {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// This method is to Create New Employee
    func createEployeeAPI(employee: NewEmployee, completion: @escaping (Result<CreateEmployeeModel, Error>) -> Void) {
        let urlString = "\(Constants.BaseURL.url)\(Constants.API.createEmployee)"
        guard let body = try? JSONEncoder().encode(employee) else { return }
        postRequest(requestUrl: URL(string: urlString)!, requestBody: body, resultType: CreateEmployeeModel.self) { result in
            switch(result) {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// This method is to delete Employee
    func deleteEmployeeAPI(employeeID: Int, completion: @escaping (Result<DeleteEmployeeModel, Error>) -> Void) {
        let urlString = "\(Constants.BaseURL.url)\(Constants.API.deleteEmployee)/\(employeeID)"
        getRequest(requestUrl: URL(string: urlString)!, resultType: DeleteEmployeeModel.self) { result in
            switch(result) {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - API CLIENT
    
    private func getRequest<T: Decodable>(requestUrl: URL, resultType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
            if let err = error {
                completion(.failure(err))
                print(err.localizedDescription)
            } else {
                guard let data = data else { return }
                let jsonString = String(decoding: data, as: UTF8.self)
                do {
                    let results = try JSONDecoder().decode(T.self, from: jsonString.data(using: .utf8)!)
                    completion(.success(results))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            }.resume()
    }
    
    private func postRequest<T: Decodable>(requestUrl: URL, requestBody: Data, resultType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = RequestType.post.rawValue
        urlRequest.httpBody = requestBody
        urlRequest.addValue(Constants.applicationJson, forHTTPHeaderField: Constants.contentType)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let err = error {
                completion(.failure(err))
                print(err.localizedDescription)
            } else {
                guard let data = data else { return }
                let jsonString = String(decoding: data, as: UTF8.self)
                do {
                    let results = try JSONDecoder().decode(T.self, from: jsonString.data(using: .utf8)!)
                    completion(.success(results))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            }.resume()
    }
}
