//
//  AddEmployeeViewController.swift
//  EmployeeApp
//
//  Created by Nikhil Wagh on 12/05/20.
//  Copyright © 2020 Tech Mahindra. All rights reserved.
//

import UIKit

class AddEmployeeViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var salaryTextField: UITextField!
    
    //MARK: - Parameters
    var addEmployeeVM = AddEmployeeViewModel()
    var activityView: UIActivityIndicatorView?
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpInitialView()
    }
    
    //MARK: - Private Methods
    
    /// This method is to do initial setup
    func setUpInitialView() {
        self.view.backgroundColor = UIColor.themeColor
        addActivityIndicator()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    /// This method is to setup Activity indicator
    func addActivityIndicator() {
        activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activityView?.center =  CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        activityView?.hidesWhenStopped = true
        view.addSubview(activityView!)
    }
    
    func showAlert(title: String, message: String, action: UIAlertAction) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func clearAll() {
        nameTextField.text = ""
        ageTextField.text = ""
        salaryTextField.text = ""
        addEmployeeVM.resetModel()
    }
    //MARK: - IBActions
    
    @IBAction func submitAction(_ sender: UIButton) {
        activityView?.startAnimating()
        addEmployeeVM.createEmployee { result in
            self.activityView?.stopAnimating()
            switch(result) {
            case .success:
                self.clearAll()
                self.showAlert(title: Constants.success, message: "Employee record added successfully.", action: UIAlertAction(title: Constants.ok, style: .default, handler: nil))
                
            case .failure(let error):
                self.showAlert(title: Constants.errorTitle, message: error.localizedDescription, action: UIAlertAction(title: Constants.ok, style: .default, handler: nil))
            }
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//MARK: - UITextfield Delegate

extension AddEmployeeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            ageTextField.becomeFirstResponder()
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField == nameTextField {
            addEmployeeVM.employeeName = nameTextField?.text ?? ""
        } else if (textField == ageTextField) {
            addEmployeeVM.employeeAge = Int(ageTextField?.text ?? "") ?? 0
        } else if (textField == salaryTextField) {
            addEmployeeVM.employeeSalary = Int(salaryTextField?.text ?? "") ?? 0
        }
        return true
    }
}
