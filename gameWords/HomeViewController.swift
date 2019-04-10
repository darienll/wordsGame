//
//  HomeViewController.swift
//  gameWords
//
//  Created by Daryn on 3/27/19.
//  Copyright © 2019 example. All rights reserved.
//

import Foundation
import Firebase

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func handleLogout(_ sender: UIButton) {
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
        
    }
    
}
