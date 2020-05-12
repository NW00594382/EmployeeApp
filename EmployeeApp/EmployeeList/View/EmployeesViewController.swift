//
//  EmployeesViewController.swift
//  EmployeeApp
//
//  Created by Nikhil Wagh on 12/05/20.
//  Copyright © 2020 Tech Mahindra. All rights reserved.
//

import UIKit

class EmployeesViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var employeeTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.themeColor
        self.employeeTableView.backgroundColor = UIColor.themeColor

    }
    
    //MARK: - Private methods
    
    
}

//MARK: - UITableView Delegate
extension EmployeesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let employeeCell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath) as? EmployeesCell else { return EmployeesCell() }
        
        employeeCell.employeeNameLabel.text = "Nikhil Wagh"
        employeeCell.employeeAgeLabel.text = "29 years"
        employeeCell.employeeSalaryLabel.text = "10,000"
        
        return employeeCell
    }
    
    
}

//MARK: - UISearchBar Delegate

extension EmployeesViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}
