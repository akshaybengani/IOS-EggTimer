//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    let eggTimes:[String:Int] = ["Soft" : 3, "Medium" : 4,"Hard" : 7]
    var player: AVAudioPlayer?
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func eggPress(_ sender: UIButton) {
            
        timer.invalidate()
        progressBar.progress = 0.0
        totalTime = eggTimes[sender.currentTitle!]!
        secondsPassed = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            progressBar.progress = percentageProgress
            label.text = "Timer in progress \(percentageProgress)"
        } else {
            timer.invalidate()
            progressBar.progress = 0.0
            label.text = "Done"
            playSound()
        }
    }
    
    func playSound(){
        let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3")!
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            // couldn't load file :(
        }
    }
}
