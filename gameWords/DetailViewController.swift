//
//  DetailViewController.swift
//  gameWords
//
//  Created by Alikhan Tuxubayev on 6/4/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var getName = String()
    var getImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgImage.image = getImage
        titleName.text! = getName
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
