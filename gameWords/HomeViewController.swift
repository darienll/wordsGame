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
    
    @IBOutlet weak var profileImage: UIView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var username: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true);
        username.text = Auth.auth().currentUser?.displayName

        let url = URL(string: "http://127.0.0.1:8000/userlists/")
        let task = URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            
            if error != nil {
                print(error!)
            }
            else {
                if let urlContent = data {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        print(jsonResult)
                        
                    }
                    catch {
                        print("JSON processing failed")
                    }
                }
            }
        }
        task.resume()
        setDesign()
        
    }

    func setDesign(){
        self.profileImage.backgroundColor = UIColor(patternImage: UIImage(named:"boy")!)
    }
    
    @IBAction func handleLogout(_ sender: UIButton) {
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
        
    }
    
}
