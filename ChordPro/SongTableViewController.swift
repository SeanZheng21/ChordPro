//
//  SongTableViewController.swift
//  ChordPro
//
//  Created by Carlistle ZHENG on 8/6/19.
//  Copyright © 2019 Carlistle ZHENG. All rights reserved.
//

import UIKit
import SafariServices
import UserNotifications

class SongTableViewController: UITableViewController {
    
    static let CELL_HEIGHT = 160
    var songs: [Song] = []
    var suggestedSongs: [Song] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        songs.append(Song("Perfect", "Divide", "Ed Sheeran", "G Em C D", startChord: "G", startStrumming: "", 1, .easy, "m4a", videoURL: "https://www.youtube.com/watch?v=8NODy7CMzb0"))
        songs.append(Song("All Too Well", "Red", "Taylor Swift", "C G Am F", startChord: "C", startStrumming: "", like: true, videoURL: "https://www.youtube.com/watch?v=9d0CdE9KVrI"))
        songs.append(Song("Legends", "Unapologetically", "Kelsea Ballerini", "C Dm Am F", startChord: "Am", startStrumming: "", 4, .hard, "m4a", like: false, videoURL: "https://www.youtube.com/watch?v=60K-JbbLfc0"))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        UserDefaults.standard.set(Song.Difficulity.medium.rawValue, forKey: "UserLevel")
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        if let myLevel = Song.Difficulity.getLevel(from: UserDefaults.standard.string(forKey: "UserLevel") ?? "") {
            suggestedSongs = getSuggestedSongs(from: songs, with: myLevel)
        }
        prepareNotification()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return songs.count
        } else {
            return suggestedSongs.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as! SongTableViewCell
        // Configure the cell...
        let song = songs[indexPath.row]
        cell.artworkImageView.image = song.artwork
        cell.songNameLabel.text = song.name
        cell.artistLabel.text = song.artist
        cell.albumLabel.text = song.album
        cell.videoLink = song.videoURL
        cell.videoButton.titleLabel?.text = song.videoURL
        cell.chordLabel.text = "Chords: " + (song.progression ?? "")
        cell.difficultyImageView.image = UIImage(named: song.difficulty.rawValue)
        cell.likeButton.setImage(UIImage(named: (song.like ? "like" : "unlike")), for: .normal)
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        let ordinalStr = formatter.string(from: NSNumber(integerLiteral: song.capo))
        cell.capoLabel.text = song.capo == 0 ? "No capo" : "Capo \(ordinalStr ?? "0") fr."
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(SongTableViewController.CELL_HEIGHT)
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            songs.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    
    @available(iOS 11.0, *)
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            self.songs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        let likeAction = UIContextualAction(style: .normal, title: "Like") { (action, sourceView, completionHandler) in
            if self.songs[indexPath.row].like {
                self.songs[indexPath.row].like = false
                (self.tableView.cellForRow(at: indexPath) as! SongTableViewCell).likeButton.setImage(UIImage(named: "unlike"), for: .normal)
            } else {
                self.songs[indexPath.row].like = true
                (self.tableView.cellForRow(at: indexPath) as! SongTableViewCell).likeButton.setImage(UIImage(named: "like"), for: .normal)
            }
            completionHandler(true)
        }
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
            let defaultText = "I have been practicing the song " + self.songs[indexPath.row].name
            let activityController: UIActivityViewController
            if let imageToShare = self.songs[indexPath.row].artwork {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            } else {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }
            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }
        likeAction.backgroundColor = #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)
        shareAction.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        likeAction.image = UIImage(named: "like_small")
        shareAction.image = UIImage(named: "share")
        deleteAction.image = UIImage(named: "delete")
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, likeAction, shareAction])
        return swipeConfiguration
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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (section == 0) ? "My Songs" : " Suggested For Me"
    }
    
    func getSuggestedSongs(from songs: [Song], with userLevel: Song.Difficulity) -> [Song] {
        var resSongs = [Song]()
        for song in songs {
            if song.difficulty.compare(to: userLevel){
                resSongs.append(song)
            }
        }
        return resSongs
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch identifier {
            case "songChosenSegue":
                if let lyricVC = segue.destination as? LyricViewController {
                    lyricVC.song = songs[tableView.indexPathForSelectedRow!.row]
                }
            case "addSongSegue":
                if let _ = segue.destination as? AddSongTableViewController {
//                    let newSong = Song()
//                    addSongVC.song = newSong
//                    songs.append(newSong)
                }
            default:
                print("Unknown segue identifier: \(identifier)")
            }
        }
    }
    @IBAction func startVideo(_ sender: UIButton) {
        if let url = URL(string: sender.titleLabel?.text ?? "") {
            let safariController = SFSafariViewController(url: url)
            present(safariController, animated: true, completion: nil)
        }
    }
    
    @IBAction func unwindToSongTableView(_ sender: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - User Notifications
    
    func prepareNotification() {
        // Make sure the restaurant array is not empty
        if songs.count <= 0 {
            return
        }
        
        // Pick a song randomly
        let randomNum = Int(arc4random_uniform(UInt32(songs.count)))
        let suggestedSong = songs[randomNum]
        
        // Create the user notification
        let content = UNMutableNotificationContent()
        content.title = "Song Recommendation"
        content.subtitle = "Try new song today"
        content.body = "I recommend you to check out \(suggestedSong.name). Its difficulty level is \(suggestedSong.difficulty.rawValue). Pick up your guitar and play it now!"
        content.sound = UNNotificationSound.default
        
        // Preparing the image
        let tempDirURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let tempFileURL = tempDirURL.appendingPathComponent("legends.jpg")

        if let image = suggestedSong.artwork {

            try? image.jpegData(compressionQuality: 1.0)?.write(to: tempFileURL)
            if let restaurantImage = try? UNNotificationAttachment(identifier: "restaurantImage", url: tempFileURL, options: nil) {
                content.attachments = [restaurantImage]
            }
        }
        
//        // Set up interaction
//        let categoryIdentifer = "foodpin.restaurantaction"
//        let makeReservationAction = UNNotificationAction(identifier: "foodpin.makeReservation", title: "Reserve a table", options: [.foreground])
//        let cancelAction = UNNotificationAction(identifier: "foodpin.cancel", title: "Later", options: [])
//        let category = UNNotificationCategory(identifier: categoryIdentifer, actions: [makeReservationAction, cancelAction], intentIdentifiers: [], options: [])
//        UNUserNotificationCenter.current().setNotificationCategories([category])
//        content.categoryIdentifier = categoryIdentifer
        
        // Show the notification in 2 minutes to 10 minutes
        let triggerTimeInterval = 120 + 60 * Int(arc4random_uniform(UInt32(8)))
//        triggerTimeInterval = 10     // for test
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(triggerTimeInterval), repeats: false)
        let request = UNNotificationRequest(identifier: "chordpro.songSuggestion", content: content, trigger: trigger)
        
        // Schedule the notification
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
}
