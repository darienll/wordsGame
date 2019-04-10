//
//  ViewController.swift
//  gameWords
//
//  Created by Daryn on 3/17/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var signUp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let user = Auth.auth().currentUser
        {
            presentLoggedInScreen()
        }
        else {
            setDesign()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
   
    }
    
    func presentLoggedInScreen(){
        performSegue(withIdentifier: "toHome", sender: self)
//        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let loggedInVC: HomeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//        self.present(loggedInVC, animated: false, completion: nil)
    }
    
    func setDesign() {
    
        signIn.layer.cornerRadius = 10
        signIn.clipsToBounds = true

        signUp.layer.cornerRadius = 10
        signUp.clipsToBounds = true
    }
}


