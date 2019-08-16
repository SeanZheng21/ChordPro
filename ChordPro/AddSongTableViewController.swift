//
//  AddSongTableViewController.swift
//  ChordPro
//
//  Created by Carlistle ZHENG on 8/15/19.
//  Copyright © 2019 Carlistle ZHENG. All rights reserved.
//

import UIKit

class AddSongTableViewController: UITableViewController {
    
    static let DIFFICULTY_OPTIONS = [
        0: "easy",
        1: "medium",
        2: "hard"]
    static let CAPO_OPTIONS = [
        0: "No capo",
        1: "1st fret",
        2: "2nd fret",
        3: "3rd fret",
        4: "4th fret",
        5: "5th fret",
        6: "6th fret",
        7: "7th fret",
        8: "8th fret",
        9: "9th fret"]
    var selectedDifficulty = 0
    var selectedCapo = 0
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBAction func nameTextFieldEditingAction(_ sender: UITextField) {
        if sender.text?.count == 0 {
            self.artworkLabel.text = "Artwork"
            self.artworkImageView.image = UIImage(named: "No Image")
            return
        }
        if let img = UIImage(named: sender.text ?? "") {
            self.artworkImageView.image = img
            self.artworkLabel.text = "Artwork"
        } else {
            self.artworkImageView.image = UIImage(named: "No Image")
            self.artworkLabel.text = "Artwork not found"
        }

    }
    @IBOutlet weak var albumTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!

    @IBOutlet weak var capoLabel: UILabel!
    @IBOutlet weak var capoStepper: UIStepper!
    
    @IBOutlet weak var chordOneText: UITextField!
    @IBOutlet weak var chordTwoText: UITextField!
    @IBOutlet weak var chordThreeText: UITextField!
    @IBOutlet weak var chordFourText: UITextField!
    
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var diffilultyStepper: UIStepper!
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var artworkLabel: UILabel!
    

    var song = Song()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.capoLabel.text = AddSongTableViewController.CAPO_OPTIONS[0]
        self.difficultyLabel.text = AddSongTableViewController.DIFFICULTY_OPTIONS[0]
    }

    
    @IBAction func changeDifficulty(_ sender: UIStepper) {
        self.difficultyLabel.text = AddSongTableViewController.DIFFICULTY_OPTIONS[Int(sender.value)]
        self.selectedDifficulty = Int(sender.value)
    }
    
    @IBAction func changeCapo(_ sender: UIStepper) {
        self.capoLabel.text = AddSongTableViewController.CAPO_OPTIONS[Int(sender.value)]
        self.selectedCapo = Int(sender.value)
    }
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
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
        switch segue.identifier {
        case "unwindAddSong":
            if let songTableViewController = segue.destination as? SongTableViewController {
                self.song = Song(nameTextField.text ?? "", albumTextField.text ?? "", artistTextField.text ?? "",
                                 "\( chordOneText.text ?? "") \(chordTwoText.text ?? "") \(chordThreeText.text ?? "") \(chordFourText.text ?? "")", selectedCapo,
                                 Song.Difficulity(rawValue: AddSongTableViewController.DIFFICULTY_OPTIONS[selectedDifficulty]!) ?? Song.Difficulity.easy)
                songTableViewController.songs.append(self.song)
            }
        default:
            break
        }
    }
 
 

}
