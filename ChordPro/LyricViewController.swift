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
    
    static let START_TIME: Double = 270.0
    var song: Song = Song("All Too Well", "Red", "Taylor Swift", "C G Am F")
    var timer: Timer = Timer()
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        do {
            if let path = Bundle.main.path(forResource: song.name, ofType: song.format) {
                let songURL = URL.init(fileURLWithPath: path)
                audioPlayer = try AVAudioPlayer(contentsOf: songURL)
                audioPlayer.prepareToPlay()
                song.duration = audioPlayer.duration
                //            audioPlayer.currentTime = LyricViewController.START_TIME
                // Make the audio available
                let audioSession = AVAudioSession.sharedInstance()
                try audioSession.setCategory(.playback, mode: .default, options: [.allowAirPlay, .allowBluetooth, .defaultToSpeaker])
            } else {
                let alertController = UIAlertController(title: "Fail to load song", message: "The song \(song.name) can't be found in your library", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Go Back", style: .default, handler: { alertAction in
                    self.navigationController?.popViewController(animated: true)
                    }))
                present(alertController, animated: true, completion: nil)
            }
        } catch {
            print("Error in audio player init: \(error)")
        }
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(checkLyric), userInfo: nil, repeats: true)
        timer.tolerance = 0.1
        timer.invalidate()
        
        navigationItem.title = song.name
        artworkImageView.image = song.artwork
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        playPauseButton.setImage(UIImage(named: "play"), for: .normal)
        audioPlayer.pause()
        timer.invalidate()
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
                .replacingOccurrences(of: "DF", with: "⬇")
                .replacingOccurrences(of: "UF", with: "⬆")
                .replacingOccurrences(of: "UD", with: "⇅")
                .replacingOccurrences(of: "D", with: "↓")
                .replacingOccurrences(of: "U", with: "↑")
            self.strummingLabel.textColor = (self.strummingLabel.textColor == #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1) ? #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1) : #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1))
            isStrumming = true
        }
        if let cT = chordText, !isStrumming, chordLabel.text != cT {
            if !isStrumming {
                chordLabel.text = cT
            }
            self.chordLabel.textColor = (self.chordLabel.textColor == #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1) ? #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1))
            chordImage.image = UIImage(named: "chord_" + cT)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lyricLine", for: indexPath) as! LyricTableViewCell
        // Configure the cell...
        let chordAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.blue,
                            NSAttributedString.Key.backgroundColor: UIColor.yellow,
                            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(17.0))]
        let textAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(17.0))]
        
        var wordString = ""
        let chordString = NSMutableAttributedString(string: "")
        if song.lyric[indexPath.row].isStrumming {
            wordString = song.lyric[indexPath.row].text
        } else {
            for (_, word, chord) in song.lyric[indexPath.row].words {
                wordString.append(contentsOf: word + " ")
                if let c = chord {
                    chordString.append(NSAttributedString(string: c.name, attributes: chordAttribute))
                    chordString.append( NSAttributedString(string: String(repeating: " ",
                            count: Int(Double(word.count) * 1.7) - c.name.count + 2), attributes: textAttribute))
                } else {
                    chordString.append(NSAttributedString(string: String(repeating: " ",
                            count: Int(Double(word.count) * 1.7) + 2), attributes: textAttribute))
                }
            }
        }
//        let attributedText = NSAttributedString(string: chordString, attributes: chordAttribute)
//        cell.textView.isEditable = false
//        cell.textView.attributedText = attributedText
        cell.chordLabel?.attributedText = chordString
        cell.lyricLabel.text = wordString
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
    
    
    @IBAction func handleTableSwipeUp(_ sender: UISwipeGestureRecognizer) {
        print("Swiping")
    }
    
    
     // MARK: - Navigation
    
    @IBAction func handleChordTap(recognizer:UITapGestureRecognizer) {
        playPauseButton.setImage(UIImage(named: "play"), for: .normal)
        audioPlayer.pause()
        timer.invalidate()
        performSegue(withIdentifier: "chordSegue", sender: self)
    }
    
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch identifier {
            case "chordSegue":
                if let chordVC = segue.destination as? ChordViewController {
                    chordVC.chord = Chord(chordLabel.text ?? "")
                    chordVC.strumming = strummingLabel.text
                    chordVC.song = self.song
                }
            default:
                print("Unknown segue identifier: \(identifier)")
            }
        }
     }
    
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
