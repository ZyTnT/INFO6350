//
//  ViewController.swift
//  RollingDice
//
//  Created by 赵芷涵 on 9/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Below7Btn: UIButton!
    
    @IBOutlet weak var Lucky7Btn: UIButton!
    
    @IBOutlet weak var Above7Btn: UIButton!
    
    @IBOutlet weak var Dice1Image: UIImageView!
    
    @IBOutlet weak var Dice2Image: UIImageView!
    
    @IBOutlet weak var ScoreLabel: UILabel!
    
    var score = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func Below7Action(_ sender: Any) {
        let dice1 = Int.random(in: 1...6)
        let dice2 = Int.random(in: 1...6)
        
        let diceImage1 = "Dice\(dice1)"
        let diceImage2 = "Dice\(dice2)"
        
        Dice1Image.image = UIImage(named: diceImage1)
        Dice2Image.image = UIImage(named: diceImage2)
        
        if dice1 + dice2 < 7 {
            score += 1
        }else{
            score -= 1
        }
        
        ScoreLabel.text = "Score = \(score)"
    }
    
    @IBAction func Lucky7Action(_ sender: Any) {
        let dice1 = Int.random(in: 1...6)
        let dice2 = Int.random(in: 1...6)
        
        let diceImage1 = "Dice\(dice1)"
        let diceImage2 = "Dice\(dice2)"
        
        Dice1Image.image = UIImage(named: diceImage1)
        Dice2Image.image = UIImage(named: diceImage2)
        
        if dice1 + dice2 == 7 {
            score += 7
        }else{
            score -= 1
        }
        
        ScoreLabel.text = "Score = \(score)"
    }
    
    
    
    @IBAction func Above7Action(_ sender: Any) {
        let dice1 = Int.random(in: 1...6)
        let dice2 = Int.random(in: 1...6)
        
        let diceImage1 = "Dice\(dice1)"
        let diceImage2 = "Dice\(dice2)"
        
        Dice1Image.image = UIImage(named: diceImage1)
        Dice2Image.image = UIImage(named: diceImage2)
        
        if dice1 + dice2 > 7 {
            score += 1
        }else{
            score -= 1
        }
        
        ScoreLabel.text = "Score = \(score)"
    }
    

}

