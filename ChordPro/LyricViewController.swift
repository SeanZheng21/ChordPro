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
    var timer: Timer = Timer()
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
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(checkLyric), userInfo: nil, repeats: true)
        timer.tolerance = 0.2
        timer.invalidate()
    }

    @IBOutlet weak var nowPlayingLabel: UILabel!
    @IBOutlet weak var chordLabel: UILabel!
    @IBOutlet weak var lyricLabel: UILabel!

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet var restartButton: [UIButton]!
    
    @IBAction func play(_ sender: UIButton) {
        audioPlayer.play()
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(checkLyric), userInfo: nil, repeats: true)
    }
    @IBAction func pause(_ sender: UIButton) {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            timer.invalidate()
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
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(checkLyric), userInfo: nil, repeats: true)
    }
    
    @objc func checkLyric () {
        let current = audioPlayer.currentTime
        var previousI = 0, previousJ = 0
        for i in 0..<song.lyric.count {
            for j in 0..<song.lyric[i].words.count {
                let (timeStamp, _, chord) = song.lyric[i].words[j]
                if let tS = timeStamp {
                    if tS > current {
                        lyricLabel.text = song.lyric[previousI].text
                        if let _ = chord {
                            previousJ = j
                        }
                        let (_, _, ch) = song.lyric[previousI].words[previousJ]
                        chordLabel.text = ch?.name
                        return
                    } else {
                        previousI = i
                        previousJ = j
                    }
                }
            }
        }

    }
    
}

