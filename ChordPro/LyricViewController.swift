//
//  LyricViewController.swift
//  ChordPro
//
//  Created by Carlistle ZHENG on 8/3/19.
//  Copyright © 2019 Carlistle ZHENG. All rights reserved.
//

import UIKit
import AVFoundation

class LyricViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    static let START_TIME: Double = 15.0
    var song: Song = Song("All Too Well", "Red", "Taylor Swift")
    var timer: Timer = Timer()
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        do {
            let songURL = URL.init(fileURLWithPath: Bundle.main.path(forResource: song.name, ofType: "mp3")!)
            audioPlayer = try AVAudioPlayer(contentsOf: songURL)
            audioPlayer.prepareToPlay()
            audioPlayer.currentTime = LyricViewController.START_TIME
            // Make the audio available
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default, options: [.allowAirPlay, .allowBluetooth, .defaultToSpeaker])
        } catch {
            print("Error in audio player init: \(error)")
        }
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(checkLyric), userInfo: nil, repeats: true)
        timer.tolerance = 0.1
        timer.invalidate()
        
        song.lyric = SongFactory.getLyric(of: song.name)
        song.duration = audioPlayer.duration
        navigationItem.title = song.name
        artworkImageView.image = song.artwork
    }

    @IBOutlet weak var chordLabel: UILabel!
    @IBOutlet weak var strummingLabel: UILabel!
    @IBOutlet weak var chordImage: UIImageView!
    
    // MARK: - Player
    @IBOutlet weak var artworkImageView: UIImageView! {
        didSet {
            artworkImageView.layer.cornerRadius = 5
        }
    }
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet var restartButton: [UIButton]!
    
    @IBAction func playPause(_ sender: UIButton) {
        if !audioPlayer.isPlaying {
            // Play
            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
            audioPlayer.play()
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkLyric), userInfo: nil, repeats: true)
        } else {
            // Pause
            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
            audioPlayer.pause()
            timer.invalidate()
            print("Paused at: \(audioPlayer.currentTime)")
        }
    }
    @IBAction func restart(_ sender: UIButton) {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            audioPlayer.currentTime = 0
        }
        audioPlayer.play()
        playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(checkLyric), userInfo: nil, repeats: true)
    }
    
    @objc func checkLyric () {
        if !audioPlayer.isPlaying {
            return
        }
        let (lyricText, chordText, lineNum, _) = song.getLyrics(at: audioPlayer.currentTime)
        if let lN = lineNum {
            tableView.scrollToRow(at: IndexPath.init(row: lN, section: 0), at: .top, animated: true)
        }
        var isStrumming = false
        if let lT = lyricText, lT.starts(with: "Strumming:") {
            let plainText = String(lT.dropFirst(10))
            strummingLabel.text = plainText.replacingOccurrences(of: "DU", with: "⇵")
                                            .replacingOccurrences(of: "UD", with: "⇅")
                                            .replacingOccurrences(of: "D", with: "↓")
                                            .replacingOccurrences(of: "U", with: "↑")
            isStrumming = true
        }
        if let cT = chordText, !isStrumming {
            chordLabel.text = cT
            chordImage.image = UIImage(named: cT)
        }
        let current = audioPlayer.currentTime, duration = audioPlayer.duration
        progressBar.progress = Float(current / duration)
        progressLabel.text = Int(current).formatTime() + " / " + Int(duration).formatTime()
    }
    
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return song.lyric.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "lyricLine", for: indexPath) as! LyricTableViewCell
     // Configure the cell...
     cell.textLabel?.text = song.lyric[indexPath.row].text
     return cell
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let timeStamp = song.lyric[indexPath.row].words[0].0 {
            audioPlayer.currentTime = timeStamp
        }
        tableView.deselectRow(at: indexPath, animated: true)
        playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
        audioPlayer.play()
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(checkLyric), userInfo: nil, repeats: true)
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}

extension Int {
    func formatTime() -> String {
        // Formats the integer to format: mm:SS
        var minute = "00"
        var second = "00"
        if self > 599 {
            minute = "\(Int(self / 60))"
        } else {
            minute = "0\(Int(self / 60))"
        }
        if self % 60 < 10 {
            second = "0\(Int(self % 60))"
        } else {
            second = "\(Int(self % 60))"
        }
        return minute + ":" + second
    }
}
