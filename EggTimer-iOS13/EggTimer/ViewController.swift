import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player: AVAudioPlayer!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    
    @objc func updateCounter() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress =  Float(secondsPassed) / Float(totalTime)
        } else{
            timer.invalidate()
            titleLabel.text = "DONE!"
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            return
        }
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progressBar.progress = 0.0
        secondsPassed = 0
       
        let hardness = sender.currentTitle!
        progressBar.progress = 1.0
        titleLabel.text = hardness
        totalTime = eggTimes[hardness]!
        print(totalTime)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
//    @objc func alarm() {
//        if titleLabel.text == "DONE!" {
//            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "wav")
//            player = try! AVAudioPlayer(contentsOf: url!)
//            player.play()
//            return
//        }
//    }
}
