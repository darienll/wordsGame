//
//  InfoViewController.swift
//  gameWords
//
//  Created by Alikhan Tuxubayev on 6/4/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
   
    var name:NSArray = []
    var imageArr:NSArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        
        name = ["Самые опасные блюда в мире","Разновидности кофе","Книги по мотивом фильмов","Страны на букву И","Восточная Европа"]
        
        imageArr = [UIImage(named: "Marvel")!,UIImage(named: "coffee_types")!,UIImage(named: "Films_Book")!,UIImage(named: "Itali")!,UIImage(named: "East_Europe")!]
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.name.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as! InfoTableViewCell
        
        cell.imgImage.image = imageArr[indexPath.row] as! UIImage
        cell.titleName.text! = name[indexPath.row] as! String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = Storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        dvc.getName = name[indexPath.row] as! String
        dvc.getImage = imageArr[indexPath.row] as! UIImage
        
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    

    

}
