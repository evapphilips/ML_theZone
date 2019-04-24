//
//  ViewController.swift
//  theZone
//
//  Created by Eva Philips on 4/20/19.
//  Copyright © 2019 evaphilips. All rights reserved.
//

import UIKit

//// set stuct for json
//struct workInProgress {
//    var project: String
//    var task: String
//}


// set variables for credentials in user defaults
var username = UserDefaults.standard.string(forKey: "username") ?? ""
var password = UserDefaults.standard.string(forKey: "password") ?? ""

class StartViewController: UIViewController {
    
    // connect start button
    @IBOutlet weak var startButton: UIButton!
    
    // connect logout button
    @IBOutlet weak var logoutButton: UIButton!
    
    // setup login alert
    var loginAlert: UIAlertController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // format start button appearance
        startButton.layer.cornerRadius = 30;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // show login alert if credentials are not in the user defaults
        if(username == "" || password == ""){
            displayLogin()
        }
    }
    
    // when start button is pressed, switch to PreWork View
    @IBAction func startButtonClicked(_ sender: Any) {
        // reference storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // reference the next view controller (ie. pre work collection view controller)
        let vc = storyboard.instantiateViewController(withIdentifier: "PreWorkCollectionViewController") as! PreWorkCollectionViewController
        self.present(vc, animated: false, completion: nil)
    }
    
    // when logout button is pressed, clear user defaults
    @IBAction func logoutButtonClicked(_ sender: Any) {
        UserDefaults.standard.set("", forKey: "username")
        UserDefaults.standard.set("", forKey: "password")
        displayLogin()
    }
    
    
    // make login alert
    func displayLogin(){
        // create login alert
        loginAlert = UIAlertController(title: nil , message: "Login", preferredStyle: .alert)
        
        // email text field
        loginAlert.addTextField { (textField) in
            textField.placeholder = "username"
            //textField.keyboardType = .emailAddress
        }
        
        // password text field
        loginAlert.addTextField { (textField) in
            textField.placeholder = "password"
            textField.isSecureTextEntry = true
            textField.addTarget(self, action: #selector(self.alertTextFieldDidChange(_:)), for: .editingChanged)
            
        }
        
        // add an action to the login alert
        let loginAction = UIAlertAction(title: "Login", style: .default) { (_) in
            let emailField = self.loginAlert.textFields![0]
            let passwordField = self.loginAlert.textFields![1]
            
            // set the inputs to the default username and password
            UserDefaults.standard.set(emailField.text!, forKey: "username")
            UserDefaults.standard.set(passwordField.text!, forKey: "password")
            // reset username and password
            username = UserDefaults.standard.string(forKey: "username") ?? ""
            password = UserDefaults.standard.string(forKey: "password") ?? ""
            
        }
        loginAction.isEnabled = false
        loginAlert.addAction(loginAction)
        
        
        // Show login alert
        self.present(loginAlert, animated: true)
    }
    // Disable login button when text field is empty.
    @objc func alertTextFieldDidChange(_ sender: UITextField) {
        loginAlert.actions[0].isEnabled = sender.text!.count > 0
    }
    // Dismisses keyboard when done is pressed.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }

}

