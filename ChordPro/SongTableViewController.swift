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
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        let ordinalStr = formatter.string(from: NSNumber(integerLiteral: song.capo))
        cell.capoLabel.text = song.capo == 0 ? "No capo" : "Capo \(ordinalStr ?? "0") fr."
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(SongTableViewController.CELL_HEIGHT)
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
