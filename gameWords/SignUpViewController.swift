//
//  SignUpViewController.swift
//  gameWords
//
//  Created by Daryn on 3/17/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit
import Firebase


class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var rePassword: UITextField!
    
    @IBOutlet weak var signUp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setDesign()
    
        // Do any additional setup after loading the view.
    }
    
    func setDesign() {
        signUp.layer.cornerRadius = 10
        signUp.clipsToBounds = true
        
        username.layer.cornerRadius = 10
        username.layer.masksToBounds = false
        username.borderStyle = UITextField.BorderStyle.roundedRect
        
        
        username.layer.shadowRadius = 3.0
        username.layer.shadowColor = UIColor.black.cgColor
        username.layer.shadowOffset = CGSize(width: 1, height: 1)
        username.layer.shadowOpacity = 0.5
        
        
        
        email.layer.cornerRadius = 10
        email.layer.masksToBounds = false
        email.borderStyle = UITextField.BorderStyle.roundedRect
        email.layer.shadowRadius = 3.0
        email.layer.shadowColor = UIColor.black.cgColor
        email.layer.shadowOffset = CGSize(width: 1, height: 1)
        email.layer.shadowOpacity = 0.5
        
        password.layer.cornerRadius = 10
        password.layer.masksToBounds = false
        password.borderStyle = UITextField.BorderStyle.roundedRect
        password.layer.shadowRadius = 3.0
        password.layer.shadowColor = UIColor.black.cgColor
        password.layer.shadowOffset = CGSize(width: 1, height: 1)
        password.layer.shadowOpacity = 0.5
        
        
        
        rePassword.layer.cornerRadius = 10
        rePassword.layer.masksToBounds = false
        rePassword.borderStyle = UITextField.BorderStyle.roundedRect
        rePassword.layer.shadowRadius = 3.0
        rePassword.layer.shadowColor = UIColor.black.cgColor
        rePassword.layer.shadowOffset = CGSize(width: 1, height: 1)
        rePassword.layer.shadowOpacity = 0.5
    }
    
    
    
    @IBAction func handleSignUp(_ sender: Any) {
        guard let username = username.text else { return }
        guard let password = password.text else { return }
        guard let email = email.text else { return }
        
        var button = sender as? UIButton
        button?.isEnabled = false
        
        Auth.auth().createUser(withEmail: email, password: password){ user, error in
            if error == nil && user != nil {
                print("user created")
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges { error in
                    if error == nil {
                        print("User display name changed!")
                        self.dismiss(animated: false, completion: nil)
                    }
                }
            }
            else {
                print("Error creating user: \(error!.localizedDescription)")
            }
            
        }
        
        

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
