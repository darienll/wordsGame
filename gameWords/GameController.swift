//
//  GameController.swift
//  gameWords
//
//  Created by Daryn on 5/19/19.
//  Copyright © 2019 example. All rights reserved.
//

import Foundation
import UIKit
import Firebase
protocol GameDelegate {
    func onAnswersReady(correctAnswers: [NSAttributedString], scores: [Int])
}
class GameController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var delegate : GameDelegate?
    let cellReuseIdentifier = "cell"
    var correctAnswers: [NSAttributedString] = []
    var scores: [Int] = []
    var testLabel: [UILabel] = []
    var totalScore : Int = 0
    var time = 10
    var width = 240
    var randomIndexOfQuestion = 0
    var timer1 = Timer()

    var labels: [Question] = [
        Question(title: "Фильмы марвел", answers: ["Железный человек","Халк","Тор","Мстители", "Доктор Стрэндж", "Первый мститель Противостояние"], scores : [1,1,1,1,1,3]),
        Question(title: "Разновидности кофе", answers: ["Латте","Эспрессо","Макиато", "Американо", "Капучино", "Капучино", "Фраппе", "Флэт уайт", "Романо", "Мокко"], scores: [1,1,3,1,1,1,3,3,2,2]),
        Question(title: "Фильмы по мотивам книг", answers: ["Форрест Гамп","Бойцовский клуб","Молчание ягнят", "Игры разума", "Жизнь Пи", "Бегущий в лабиринте", "Гарри Поттер", "Оно", "Рэмбо", "Хроники Нарнии"], scores: [1,1,3,1,1,1,3,3,2,2]),
         Question(title: "Страны на букву И", answers: ["Израиль","Индия","Индонезия", "Иордания", "Ирак", "Иран", "Ирландия", "Исландия", "Испания", "Италия"], scores: [1,1,3,1,1,1,3,3,2,2]),
         Question(title: "Восточная Европа", answers: ["Беларусь","Болгария","Венгрия", "Молдавия", "Польша", "Россия", "Румыния", "Словакия", "Украина", "Чехия"], scores: [1,1,3,1,1,1,3,3,2,2])
        
    ]

    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var answerInput: UITextField!
    @IBOutlet weak var timeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

      self.navigationItem.setHidesBackButton(true, animated:true);
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
//        tableView.layer.borderWidth = 1.0;
//        tableView.layer.borderColor = UIColor.red.cgColor
        titleLabel.text = self.labels[randomIndexOfQuestion].title
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
        
        self.titleLabel.layer.zPosition = 1
        titleLabel.layer.masksToBounds = true
        titleLabel.layer.cornerRadius = 9
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        timer1 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(setTimer), userInfo: nil, repeats: true)
       

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func sendAnswer(_ sender: Any) {
        print("in sendAnswer")
        var value = NSAttributedString(string: answerInput.text!)
        let value2 = NSAttributedString(string: answerInput.text!, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        let question = labels[randomIndexOfQuestion]
        if (answerInput.text != "" && !correctAnswers.contains(value)) && (answerInput.text != "" &&  !correctAnswers.contains(value2)) {
            if (question.answers.contains(self.answerInput.text ?? "")) {
                
                let attributedString = NSMutableAttributedString(string: answerInput.text!)
                let index = question.answers.index(of: answerInput.text!)!
                
                
                self.correctAnswers.append(attributedString)
                self.scores.append(question.scores[index])
                
            }
            else {
                let attrString = NSAttributedString(string: answerInput.text!, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
                self.correctAnswers.append(attrString)
                self.scores.append(0)
                
            }
            tableView.reloadData()
            self.answerInput.text = ""
            answerInput.text = ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.correctAnswers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomCell
        cell.myLabel1.attributedText = self.correctAnswers[indexPath.row]
        cell.myLabel2.text = String( self.scores[indexPath.row])
        
        
        
        
        return cell

    }
    
    @objc func updateTimer() {
        self.time = time - 1
        self.timeLabel.text = "\(time)"
    }
    
    @objc func setTimer() {
        if (self.width <= 0 || self.time <= 0 ) {
        print("in set timer ")
        timer1.invalidate()
    navigationController?.popViewController(animated: true)
        self.delegate?.onAnswersReady(correctAnswers: self.correctAnswers, scores: self.scores)
        self.dismiss(animated: false, completion: nil)


        }
        self.width = width - 2
        self.timerView.frame = CGRect(x: 0, y: 0, width: self.width, height: 50)

    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
}
