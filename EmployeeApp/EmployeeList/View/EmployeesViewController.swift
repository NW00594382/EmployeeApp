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
    
    //MARK: - Parameters
    var employeeVM = EmployeesViewModel()
    var activityView: UIActivityIndicatorView?
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpInitialView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getEmployees()
        searchBar.text = ""
        dismissKeyboard()
    }
    
    //MARK: - Private Methods
    
    /// This method is to do initial setup
    func setUpInitialView() {
        self.view.backgroundColor = UIColor.themeColor
        addActivityIndicator()
    }
    
    /// This method is to setup Activity indicator
    func addActivityIndicator() {
        activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activityView?.center =  CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        activityView?.hidesWhenStopped = true
        view.addSubview(activityView!)
    }
    
    /// This method is to get Employees data from ViewModel
    func getEmployees() {
        activityView?.startAnimating()
        employeeVM.getEmployeeData { result in
            switch(result) {
            case .success:
                self.activityView?.stopAnimating()
                self.employeeTableView.reloadData()
            case .failure(let error):
                let alert = UIAlertController(title: Constants.errorTitle, message: error.localizedDescription , preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: Constants.ok, style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func dismissKeyboard() {
        DispatchQueue.main.async {
            self.searchBar.resignFirstResponder()
        }
    }
}

//MARK: - UITableView Delegate
extension EmployeesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeVM.employeesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let employeeCell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath) as? EmployeesCell else { return EmployeesCell() }
        employeeCell.configureCell(viewModel: employeeVM, indexPath: indexPath)
        return employeeCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.employeeTableView.beginUpdates()
            self.employeeVM.employeesArray.remove(at: indexPath.row)
            self.employeeTableView.deleteRows(at: [indexPath], with: .right)
            self.employeeTableView.endUpdates()
        }
    }
}

//MARK: - UISearchBar Delegate

extension EmployeesViewController: UISearchBarDelegate {
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        employeeVM.searchEmployee(with: searchText) {
            self.employeeTableView.reloadData()
            if searchText.isEmpty {
                self.dismissKeyboard()
            }
        }
    }
}
