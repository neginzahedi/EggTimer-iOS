//
//  ViewController.swift
//  Egg Timer
//
//  Created by Negin Zahedi on 2022-06-10.
//

import UIKit

class ViewController: UIViewController {
    
    // Dictionary
    let eggTime: [String:Int] = ["softEgg": 5, "mediumEgg": 420, "hardEgg": 720]
    
    var secondsRemaining: Int = 60
    
    // Countdown Timer
    var timer = Timer()
    
    @IBOutlet weak var resultUILabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    
    @IBAction func EggSelected(_ sender: UIButton) {
        let selectedEgg = sender.accessibilityLabel!
        print(eggTime[selectedEgg]!)
        
        secondsRemaining = eggTime[selectedEgg]!
        // Cancel previous timer if a new button is selected
        timer.invalidate()
        
        // Create a new timer
        // Parameters (timerInterval: updates every 1 second, repeats: timer repeats after each seconds, selector: is a function that is called every seconds)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    // Print each secondsRemaining
    @objc func updateTimer(){
        if secondsRemaining > 0 {
            print ("\(secondsRemaining) seconds")
            secondsRemaining -= 1
        }else{
            timer.invalidate()
            resultUILabel.text = "Done"
        }
    }
}

