//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

/// <#Description#>
class ViewController: UIViewController {
    
    let eggTimes : [String: Int] = ["Soft": 3, "Medium": 4, "Hard": 7]
    var timer: Timer?
    var countdownTime: Int = 0
    var player: AVAudioPlayer!
    
    @IBOutlet weak var timerProgress: UIProgressView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        timerView.alpha = 0;
        timerLabel.text = "Starting a timer..."
    }
    
    @IBOutlet weak var timerView: UIView!
    
    // hardnessSelected
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness : String? = sender.currentTitle
        
        timerProgress.progress = 1.0;
        timer?.invalidate()
        timerView.alpha = 1.0;
        timerLabel.alpha = 1.0;
        
        if hardness != nil {
            if eggTimes[hardness!] != nil {
                print(eggTimes[hardness!]!)
                titleLabel.text = hardness
                startCountdown(seconds: eggTimes[hardness!]!)
            } else {
                print("The egg doesn't want to be cooked!")
            }
        }
    }
    
    @IBAction func stopTimer(_ sender: UIButton) {
        timerView.alpha = 0;
        timer?.invalidate()
        timerLabel.text = "Starting a timer..."
        timerProgress.progress = 0.0
        print("Clicked")
        titleLabel.text = "How do you like your eggs?"
    }
    
    func startCountdown(seconds: Int) {
        countdownTime = seconds;
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            if self.countdownTime > 0 {
                self.countdownTime -= 1
                timerProgress.progress = Float(self.countdownTime) / Float(seconds)
                timerLabel.text = "\(self.countdownTime)s"
                print("\(self.countdownTime) seconds remaining")
            } else {
                timer.invalidate()
                print("Countdown finished!")
                titleLabel.text = "Done!"
                timerView.alpha = 0;
                timerLabel.text = "Countdown finished!"
                playSound(alarmSound: "alarm_sound")
            }
        }
    }
    func playSound(alarmSound: String) {
        let url = Bundle.main.url(forResource: alarmSound, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
}

