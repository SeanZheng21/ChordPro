//
//  ChordDetailTableViewController.swift
//  ChordPro
//
//  Created by Carlistle ZHENG on 8/21/19.
//  Copyright © 2019 Carlistle ZHENG. All rights reserved.
//

import UIKit

class ChordDetailTableViewController: UITableViewController {
    
    // MARK: - Model
    var chord = Chord("C")
    
    // MARK: - Outlets
    @IBOutlet weak var chordImageView: UIImageView!
    @IBOutlet weak var chordNameLabel: UILabel!
    
    @IBOutlet weak var chordKeyLabel: UILabel!
    @IBOutlet weak var chordKeyDescriptionLabel: UILabel!
    @IBOutlet weak var basicChordKeyLabel: UILabel!
    @IBOutlet weak var chordKeyImageView: UIImageView!
    
    @IBOutlet weak var chordTypeLabel: UILabel!
    @IBOutlet weak var chordTypeDescriptionLabel: UILabel!
    @IBOutlet weak var basicTypeChordLabel: UILabel!
    @IBOutlet weak var chordTypeImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.allowsSelection = false
        chordImageView.image = UIImage(named: "chord_" + chord.name)
        chordNameLabel.text = chord.name
        chordTypeLabel.text = "Type: \(chord.type.typeName().localizedLowercase) chord"
        chordTypeDescriptionLabel.text = "Description: " + (chord.type.typeDescription() ?? " ")
        chordTypeDescriptionLabel.sizeToFit()
        chordKeyLabel.text = "Key: " + chord.key
        basicChordKeyLabel.text = "Basic chords of \(chord.key) key:"
        chordKeyImageView.image = UIImage(named: "key_" + chord.key)
        basicTypeChordLabel.text = "Basic \(chord.type.typeName().localizedLowercase) chords:"
        chordTypeImageView.image = UIImage(named: "type_" + chord.type.rawValue)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .all
        }
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
