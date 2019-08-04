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
    
    static let START_TIME: Double = 0.0
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
        timer.tolerance = 0.2
        timer.invalidate()
        
        song.lyric = SongFactory.getLyric(of: song.name)
        song.duration = audioPlayer.duration
        navigationItem.title = song.name
        artworkImageView.image = song.artwork
    }

    @IBOutlet weak var chordLabel: UILabel!
    
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
            timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(checkLyric), userInfo: nil, repeats: true)
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
        var lineNum: Int?
//        var wordNum: Int?
        (_, chordLabel.text, lineNum, _) = song.getLyrics(at: audioPlayer.currentTime)
        if let lN = lineNum {
            tableView.scrollToRow(at: IndexPath.init(row: lN, section: 0), at: .top, animated: true)
        }
        let current = audioPlayer.currentTime, duration = audioPlayer.duration
        progressBar.progress = Float(current / duration)
        progressLabel.text = formatTime(inSeconds: Int(current)) + " / " + formatTime(inSeconds: Int(duration))
    }
    
    private func formatTime(inSeconds time: Int) -> String {
        var minute = "00"
        var second = "00"
        if time > 599 {
            minute = "\(Int(time / 60))"
        } else {
            minute = "0\(Int(time / 60))"
        }
        if time % 60 < 10 {
            second = "0\(Int(time % 60))"
        } else {
            second = "\(Int(time % 60))"
        }
        return minute + ":" + second
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
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}

