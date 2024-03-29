//
//  ProgressionDetailTableViewController.swift
//  ChordPro
//
//  Created by Carlistle ZHENG on 8/17/19.
//  Copyright © 2019 Carlistle ZHENG. All rights reserved.
//

import UIKit

class ProgressionDetailTableViewController: UITableViewController {
    
    let formatter = NumberFormatter()
    var progression = Progression("")
    var pattern = ""
    var chords = [Chord]()

    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.numberStyle = .ordinal
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
        return progression.len
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "progressionDetailCell", for: indexPath) as! ProgressionDetailTableViewCell

        // Configure the cell...
        let chord = Chord(progression.chords[indexPath.row])
        self.chords.append(chord)
        cell.chordLabel.text = chord.name
        cell.imageView?.image = UIImage(named: "chord_" + progression.chords[indexPath.row])
        
        cell.chordNumberLabel.text = (formatter.string(from: NSNumber(integerLiteral: indexPath.row + 1)) ?? "") + " chord"
        cell.chordKeyLabel.text = "Key: " + chord.key
        cell.chordTypeLabel.text = "Type: " + chord.type.typeName()
        
        cell.patternLabel.text = "Pattern\n" + self.pattern
        cell.patternNoteLabel.text = "Note: " + String(self.pattern.split(separator: " ")[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100.0)
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "chordDetailSegue", sender: self)
    }

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
            case "chordDetailSegue":
                if let chordDetailVC = segue.destination as? ChordDetailTableViewController {
                    chordDetailVC.chord = chords[tableView.indexPathForSelectedRow?.row ?? 0]
                }
            default:
                break
            }
        }
    }
    

}
