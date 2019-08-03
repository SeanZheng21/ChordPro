//
//  LyricViewController.swift
//  ChordPro
//
//  Created by Carlistle ZHENG on 8/3/19.
//  Copyright © 2019 Carlistle ZHENG. All rights reserved.
//

import UIKit
import AVFoundation

class LyricViewController: UIViewController {

    var song: Song = Song("All Too Well", "Red", "Taylor Swift")
    
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        do {
            let songURL = URL.init(fileURLWithPath: Bundle.main.path(forResource: song.name, ofType: "mp3")!)
            audioPlayer = try AVAudioPlayer(contentsOf: songURL)
            audioPlayer.prepareToPlay()
            // Make the audio available
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default, options: [.allowAirPlay, .allowBluetooth, .defaultToSpeaker])
            
        } catch {
            print("Error in audio player init: \(error)")
        }
        song.lyric = SongFactory.getLyric(of: song.name)
        nowPlayingLabel.text = "Now playing: \(song.name)"
    }

    @IBOutlet weak var nowPlayingLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet var restartButton: [UIButton]!
    
    @IBAction func play(_ sender: UIButton) {
        audioPlayer.play()
    }
    @IBAction func pause(_ sender: UIButton) {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            print("Paused at: \(audioPlayer.currentTime)")
        }
    }
    @IBAction func restart(_ sender: UIButton) {
        if audioPlayer.isPlaying {
            audioPlayer.currentTime = 0
            audioPlayer.play()
        } else {
            audioPlayer.play()
        }
    }
    
}

