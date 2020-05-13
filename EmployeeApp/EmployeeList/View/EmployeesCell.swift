//
//  EmployeesCell.swift
//  EmployeeApp
//
//  Created by Nikhil Wagh on 12/05/20.
//  Copyright © 2020 Tech Mahindra. All rights reserved.
//

import UIKit

class EmployeesCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var employeeImageView: UIImageView!
    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var employeeAgeLabel: UILabel!
    @IBOutlet weak var employeeSalaryLabel: UILabel!
    
    //MARK: - Initializers
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = UIColor.themeColor
    }
    
    //MARK: - Private methods
    
    /// This method is to configure cell
    /// - Parameters:
    ///   - viewModel: This parameter is to access employeesArray from ViewModel
    ///   - indexPath: IndexPath of tableView to display perticular row info
    func configureCell(viewModel: EmployeesViewModel, indexPath: IndexPath) {
        let employee = viewModel.employeesArray[indexPath.row]
        employeeImageView.imageFromServerURL(employee.profileImage, placeHolder: #imageLiteral(resourceName: "placeholder"))
        employeeNameLabel.text = employee.employeeName
        employeeAgeLabel.text = "\(employee.employeeAge) years"
        employeeSalaryLabel.text = employee.employeeSalary
    }
}
