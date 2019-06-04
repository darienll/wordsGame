//
//  ListOpponentsViewController.swift
//  gameWords
//
//  Created by Максат Дилдаханов on 4/14/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit
import Firebase

class ListOpponentsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, GameResult {
    
    
    var scores : [String] = []

    @IBOutlet weak var tableView: UITableView!
    func onGameFinished(humanScore: Int, botScore: Int) {
        scores.append(String(humanScore) + ":" + String(botScore))
        print("here")
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.layer.masksToBounds = true
        tableView.clipsToBounds = false
        tableView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        tableView.layer.shadowRadius = 1
        let shadows = UIView()
        shadows.frame = view.frame
        shadows.clipsToBounds = false
        //        tableView.layer.shadowPath = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 0).cgPath
        tableView.layer.shadowOpacity = 1
        tableView.layer.shadowRadius = 4
        tableView.layer.shadowOffset = CGSize(width: 0, height: 4)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
    }
    

    @IBAction func findGamePressed(_ sender: UIButton) {
//        self.performSegue(withIdentifier: "toGame", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OpponentsCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! OpponentsCell
        cell.myLabel1.attributedText = NSAttributedString(string: "test")
        cell.myLabel2.text = "AIBot"
        cell.myScoreLabel.text = scores[indexPath.row]
        return cell
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if (segue.destination.isKind(of: GameMenuController.self)) {
            let gameVC = segue.destination as! GameMenuController
            gameVC.delegate = self
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
