//
//  ViewController.swift
//  Egg Timer
//
//  Created by Negin Zahedi on 2022-06-10.
//

import UIKit
import AVFAudio

class ViewController: UIViewController {
    
    // a dictionary to store enough minutes for each hardness
    let eggTime: [String:Int] = ["softEgg": 4, "mediumEgg": 6, "hardEgg": 8]
    
    // a variable that stores total egg time and is used in progress bar
    var totalTime = 0
    
    // a variable to store passed seconds in progress bar
    var secondsPassed = 0
    
    // Countdown Timer
    var timer = Timer()
    
    // a UILable to display default question and result
    @IBOutlet weak var resultUILabel: UILabel!
    
    // Progress Bar
    @IBOutlet weak var timerUIProgressview: UIProgressView!
    
    // Egg labels
    @IBOutlet weak var softUILabel: UILabel!
    @IBOutlet weak var mediumUILabel: UILabel!
    @IBOutlet weak var hardUILabel: UILabel!
    
    // player used to play alarm when egg is ready
    var player: AVAudioPlayer?
    // the url of the alarm.wav file
    let url = Bundle.main.url(forResource: "alarm", withExtension: "wav")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func EggSelected(_ sender: UIButton) {
        
        // title of the selected button
        let selectedEgg = sender.accessibilityLabel!
        
        // label of selected egg changed to orange, by default is black
        switch selectedEgg {
        case "softEgg":
            softUILabel.textColor = UIColor.orange
            mediumUILabel.textColor = UIColor.black
            hardUILabel.textColor = UIColor.black
        case "mediumEgg":
            mediumUILabel.textColor = UIColor.orange
            softUILabel.textColor = UIColor.black
            hardUILabel.textColor = UIColor.black
        case "hardEgg":
            hardUILabel.textColor = UIColor.orange
            softUILabel.textColor = UIColor.black
            mediumUILabel.textColor = UIColor.black
        default:
            softUILabel.textColor = UIColor.black
            mediumUILabel.textColor = UIColor.black
            hardUILabel.textColor = UIColor.black
        }
        
        // total time of the selectedEgg
        totalTime = eggTime[selectedEgg]!
        
        // set label to default question instead of "YOUR EGG IS READY!"
        resultUILabel.text = "How do you like your Eggs?"
        
        // Cancel previous progress bar and set it to zero
        timerUIProgressview.progress = 0.0
        secondsPassed = 0
        
        // Cancel previous timer if a new button is selected
        timer.invalidate()
        
        // Create a new timer
        /* Parameters:
         - timeInterval: updates every 1 second
         - repeats: timer repeats after each seconds (true or false)
         - selector: is a function that is called every seconds)
         */
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        pauseAlarm()
        
    }
    
    func playAlarm(){
        do{
            player = try AVAudioPlayer(contentsOf: self.url!)
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func pauseAlarm(){
        do{
            player = try AVAudioPlayer(contentsOf: self.url!)
            player?.pause()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // Print each secondsRemaining
    @objc func updateTimer(){
        if secondsPassed < totalTime {
            secondsPassed += 1
            timerUIProgressview.progress = Float(secondsPassed) / Float(totalTime)
            
        }else{
            timer.invalidate()
            resultUILabel.text = "YOUR EGG IS READY!"
            playAlarm()
        }
    }
}

