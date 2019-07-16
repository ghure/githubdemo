//
//  SearchScreenViewController.swift
//  PhonePeAssignment
//
//  Created by Mahadev on 10/07/19.
//  Copyright © 2019 Mahadev. All rights reserved.
//

import UIKit
import SKActivityIndicatorView

class SearchScreenViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBtnOutlet: UIButton!
    let viewModel = UserViewModel(dataService: UserApiViewModel())
    
    
    @IBAction func didSearchBtnPressed(_ sender: Any) {
        if self.searchTextField.text != "" {
            SKActivityIndicator.show("Loading...")
            self.viewModel.fetchUser(withName: self.searchTextField.text!, completion: { (userdetails, error, code)  in
                SKActivityIndicator.dismiss()
                if let err = error {
                    print("Error of user details api: " + err.localizedDescription)
                    
                    
                    return
                }
                if code != 200 {
                    DispatchQueue.main.async {
                        if code == 404 {
                            self.showAlert(alertText: "Valid", alertMessage: "No match found...")
                        } else {
                            self.showAlert(alertText: "Valid", alertMessage: "Something went wrong.")
                        }
                    }
                    
                    return
                }
                let controller = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                if let userdetails = userdetails {
                controller.UserDetails = userdetails
                    self.navigationItem.title = " "
                    DispatchQueue.main.async {
                        
                        self.navigationController?.pushViewController(controller, animated: true)
                    }
                
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    

    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150 // Move view 150 points upward
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchScreenViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
