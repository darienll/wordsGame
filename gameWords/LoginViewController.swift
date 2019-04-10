//
//  LoginViewController.swift
//  gameWords
//
//  Created by Daryn on 3/17/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    let sendValue = ViewController()

    
    @IBOutlet weak var signIn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDesign()

        // Do any additional setup after loading the view.
    }
    
    func setDesign() {
        
        
        signIn.layer.cornerRadius = 10
        signIn.clipsToBounds = true
        
        emailField.layer.cornerRadius = 10
        emailField.layer.masksToBounds = false
        emailField.borderStyle = UITextField.BorderStyle.roundedRect


        emailField.layer.shadowRadius = 3.0
        emailField.layer.shadowColor = UIColor.black.cgColor
        emailField.layer.shadowOffset = CGSize(width: 1, height: 1)
        emailField.layer.shadowOpacity = 0.5
        
    
        
        passwordField.layer.cornerRadius = 10
        passwordField.layer.masksToBounds = false
        passwordField.borderStyle = UITextField.BorderStyle.roundedRect

        passwordField.layer.shadowRadius = 3.0
        passwordField.layer.shadowColor = UIColor.black.cgColor
        passwordField.layer.shadowOffset = CGSize(width: 1, height: 1)
        passwordField.layer.shadowOpacity = 0.5
        
    }
    

    @IBAction func handleSignIn(_ sender: Any) {
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                self.dismiss(animated: false, completion: nil)
                self.presentLoggedInScreen()
                
            }
            else {
                print("Error logging in \(error!.localizedDescription )")
            }
            
        }
    }
    func presentLoggedInScreen(){
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loggedInVC: HomeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.present(loggedInVC, animated: true, completion: nil)
    }
   
    

}
