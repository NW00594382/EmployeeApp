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
    }
    
    static let cellIdentifier = "FactsTableViewCell"
    static let errorTitle = "Error"
    static let ok = "OK"
    static let customFontBold = "Helvetica-bold"
    static let customFont = "Helvetica"
    static let titleFontSize = 18.0
    static let descFontSize = 16.0
    static let imageViewHeight = 90.0
    static let imageViewWidth = 90.0
    static let zero = 0.0
    static let heightConstant = 60.0
    
}
