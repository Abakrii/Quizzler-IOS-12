//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
   let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNo : Int = 0
    var score : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextQuestion()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        }
        else if sender.tag == 2 {
            pickedAnswer = false
        }
            checkAnswer()
        questionNo = questionNo + 1
        nextQuestion()
    }
    
    
    func updateUI() {
        // we do that "\()" because we need to skaping the string , because the text ui is string
        scoreLabel.text = " Your Score : \(score)"
        progressLabel.text = "\(questionNo + 1) / 13"
        // CGFloat , we wanna down cast int to float,progressBar attributes is float and questionNo is int we need to down cast
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNo + 1 )
     
    }
    

    func nextQuestion() {
        if questionNo <= 12 {
             questionLabel.text = allQuestions.list[questionNo].questionText
            updateUI()
        }
        else{
            let alert = UIAlertController(title: "Awesome", message: "You Have Finsihed All the Questions , Do You Wanna Start Over ?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            
            alert.addAction(restartAction)
            present(alert , animated: true ,completion: nil)
        }
        
    }
    
    
    func checkAnswer() {
      
        let correctAnswer = allQuestions.list[questionNo].answer
        
        if correctAnswer == pickedAnswer{
           ProgressHUD.showSuccess("Correct")
            score += 1
        }
        else{
              ProgressHUD.showError("Wrong!")
        }
    }
    
    
    func startOver() {
       questionNo = 0
        nextQuestion()
    }
    

    
}
