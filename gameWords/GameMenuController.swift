//
//  GameMenuController.swift
//  gameWords
//
//  Created by Daryn on 5/20/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit
import Firebase
protocol GameResult {
    func onGameFinished(humanScore: Int, botScore: Int )
}
class GameMenuController: UIViewController,UITableViewDelegate, UITableViewDataSource, GameDelegate {
    
    
    
    
    
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var scoreUser: UILabel!
    @IBOutlet weak var scoreBot: UILabel!
    
    var correctAnswers: [NSAttributedString] = []
    var correctAnswersBot: [NSAttributedString] = []
    var scoresBot : [Int] = []
    var scores: [Int] = []
    var randomIndexOfQuestion = 0
    var sum1 = 0
    var sum2 = 0
    var delegate : GameResult?

    var labels: [Question] = [
        Question(title: "Фильмы марвел", answers: ["Железный человек","Халк","Тор","Мстители", "Доктор Стрэндж", "Первый мститель Противостояние"], scores : [1,1,1,1,1,3]),
        Question(title: "Разновидности кофе", answers: ["Латте","Эспрессо","Макиато", "Американо", "Капучино", "Капучино", "Фраппе", "Флэт уайт", "Романо", "Мокко"], scores: [1,1,3,1,1,1,3,3,2,2]),
        Question(title: "Фильмы по мотивам книг", answers: ["Форрест Гамп","Бойцовский клуб","Молчание ягнят", "Игры разума", "Жизнь Пи", "Бегущий в лабиринте", "Гарри Поттер", "Оно", "Рэмбо", "Хроники Нарнии"], scores: [1,1,3,1,1,1,3,3,2,2]),
        Question(title: "Страны на букву И", answers: ["Израиль","Индия","Индонезия", "Иордания", "Ирак", "Иран", "Ирландия", "Исландия", "Испания", "Италия"], scores: [1,1,3,1,1,1,3,3,2,2]),
        Question(title: "Восточная Европа", answers: ["Беларусь","Болгария","Венгрия", "Молдавия", "Польша", "Россия", "Румыния", "Словакия", "Украина", "Чехия"], scores: [1,1,3,1,1,1,3,3,2,2])
        
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.randomIndexOfQuestion = Int(arc4random_uniform(UInt32(labels.count)))
        
        
        self.nameLabel.text = Auth.auth().currentUser?.displayName
        self.titleLabel.layer.zPosition = 1
        titleLabel.layer.masksToBounds = true
        titleLabel.layer.cornerRadius = 9
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
        titleLabel.text = self.labels[randomIndexOfQuestion].title
        

//        self.logoView.backgroundColor = UIColor(patternImage: UIImage(named:"boy")!)


        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (correctAnswers.count > correctAnswersBot.count) ? correctAnswers.count : correctAnswersBot.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomCell2 = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomCell2
        cell.myLabel1.attributedText = self.correctAnswers[indexPath.row]
        cell.myLabel2.text = String( self.scores[indexPath.row])
        cell.myLabel3.text = String(self.scoresBot[indexPath.row])
        cell.myLabel4.attributedText = self.correctAnswersBot[indexPath.row]

        return cell
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is GameController
        {
            let vc = segue.destination as? GameController
            vc?.randomIndexOfQuestion = self.randomIndexOfQuestion
        }
        if (segue.destination.isKind(of: GameController.self)) {
            let gameVC = segue.destination as! GameController
            gameVC.delegate = self
        }
    }
    
    func onAnswersReady(correctAnswers: [NSAttributedString], scores: [Int]) {
        self.correctAnswers = correctAnswers
        self.scores = scores
        self.updateBotData()
        self.sum1 = scores.reduce(0, +)
        self.sum2 = scoresBot.reduce(0, +)
        print("Sum1: \(sum1)")
        print("Sum2: \(sum2)")
        scoreUser.text = String(sum1)
        scoreBot.text = String(sum2)
        self.delegate?.onGameFinished(humanScore: sum1, botScore: sum2)
        tableView.reloadData()
        
    }
    func updateBotData(){
        
        let question = labels[randomIndexOfQuestion]
        var randomQuestionForBot =  arc4random_uniform(3) + 5;
        for randomInt in 0...randomQuestionForBot {
            let random = arc4random_uniform(UInt32(labels[randomIndexOfQuestion].answers.count))
            let attributedString = NSMutableAttributedString(string: labels[randomIndexOfQuestion].answers[Int(random)])
            self.correctAnswersBot.append(attributedString)
            self.scoresBot.append(labels[randomIndexOfQuestion].scores[Int(random)])
            
            
        }
        if correctAnswersBot.count > correctAnswers.count {
            var difference = correctAnswersBot.count - correctAnswers.count
            for  i in 1...difference {
                let attributedString = NSMutableAttributedString(string: "")
               self.correctAnswers.append(attributedString)
                self.scores.append(0)
            }
        }
        else {
            var difference = correctAnswers.count - correctAnswersBot.count
            for  i in 1...difference {
                let attributedString = NSMutableAttributedString(string: "")
                self.correctAnswersBot.append(attributedString)
                self.scoresBot.append(0)
            }
        }
        print(self.correctAnswersBot.count)
        print(self.correctAnswers.count)
       
        
        tableView.reloadData()
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
