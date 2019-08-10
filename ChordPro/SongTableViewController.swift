//
//  SongTableViewController.swift
//  ChordPro
//
//  Created by Carlistle ZHENG on 8/6/19.
//  Copyright © 2019 Carlistle ZHENG. All rights reserved.
//

import UIKit

class SongTableViewController: UITableViewController {
    
    static let CELL_HEIGHT = 160
    var songs: [Song] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        songs.append(Song("Perfect", "Divide", "Ed Sheeran", "G Em C D", 1, .easy, "m4a"))
        songs.append(Song("All Too Well", "Red", "Taylor Swift", "C G Am F"))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return songs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as! SongTableViewCell
        // Configure the cell...
        let song = songs[indexPath.row]
        cell.artworkImageView.image = song.artwork
        cell.songNameLabel.text = song.name
        cell.artistLabel.text = song.artist
        cell.albumLabel.text = song.album
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
            default:
                print("Unknown segue identifier: \(identifier)")
            }
        }
    }

}
