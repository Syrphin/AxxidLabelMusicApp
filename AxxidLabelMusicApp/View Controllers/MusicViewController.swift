//
//  MusicViewController.swift
//  Axxid Label
//
//  Created by Syrphin on 21.03.22.
//

import UIKit
import AVFoundation

class MusicViewController: UIViewController {

    
    var audioPlayer = AVAudioPlayer()
    
    @IBAction func playButton(_ sender: Any) {
        audioPlayer.play()
    }
    
    @IBAction func PauseButton(_ sender: Any) {
        audioPlayer.pause()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sound = Bundle.main.path(forResource: "Kraftwerk - Musique Non Stop", ofType:"mp3")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback,mode: AVAudioSession.Mode.default, options: [AVAudioSession.CategoryOptions.mixWithOthers])
        } catch {
            print(error)
        }
        
        
    }
    
    
}

