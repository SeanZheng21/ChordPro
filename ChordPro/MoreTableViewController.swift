//
//  MoreTableViewController.swift
//  ChordPro
//
//  Created by Carlistle ZHENG on 8/24/19.
//  Copyright © 2019 Carlistle ZHENG. All rights reserved.
//

import UIKit
import SafariServices

class MoreTableViewController: UITableViewController {
    
    var sectionTitles = [NSLocalizedString("Feedback", comment: "Feedback"), NSLocalizedString("Follow Us", comment: "Follow Us")]
    var sectionContent = [[(image: "store", text: NSLocalizedString("Rate us on App Store", comment: "Rate us on App Store"), link: "https://www.apple.com/itunes/charts"),
                           (image: "chat", text: NSLocalizedString("Tell us your feedback", comment: "Tell us your feedback"), link: "http://www.apple.com")],
                          [(image: "twitter", text: NSLocalizedString("Twitter", comment: "Twitter"), link: "https://twitter.com"),
                           (image: "facebook", text: NSLocalizedString("Facebook", comment: "Facebook"), link: "https://facebook.com"),
                           (image: "instagram", text: NSLocalizedString("Instagram", comment: "Instagram"), link: "https://www.instagram.com")]]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.alwaysBounceVertical = false
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.notificationSwitch.isOn = UserDefaults.standard.bool(forKey: "notification")
        self.autoplaySwitch.isOn = UserDefaults.standard.bool(forKey: "autoplay")
        self.setTimePlayed()
        self.levelLabel.text = getLevelDescription(for: UserDefaults.standard.string(forKey: "UserLevel") ?? "")
    }
    
    func getLevelDescription(for key: String) -> String {
        switch key {
        case "easy":
            return "beginner"
        case "medium":
            return "intermediate"
        case "hard":
            return "expert"
        default:
            return "not set"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.levelLabel.text = getLevelDescription(for: UserDefaults.standard.string(forKey: "UserLevel") ?? "")
    }

    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var autoplaySwitch: UISwitch!
    @IBAction func toggleAutoplay(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "autoplay")
        print("Toggle autoplay to: \(sender.isOn)")
    }
    
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBAction func toggleNotification(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "notification")
    }
    
    @IBOutlet weak var timePlayedLabel: UILabel!
    @IBAction func resetTimePlayed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Reset Time Played", message: "Reset your time played, this action can't be undone.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        let confirmAction = UIAlertAction(title: "Reset", style: .destructive) { (action:UIAlertAction) in
            self.confirmedResetTimePlayed();
        }
        alert.addAction(confirmAction)
        self.present(alert, animated: true)
    }
    
    func confirmedResetTimePlayed() {
        UserDefaults.standard.set(0, forKey: "timePlayed")
        self.setTimePlayed()
    }
    
    private func setTimePlayed() {
        var time = UserDefaults.standard.integer(forKey: "timePlayed")
        let day = time / 86400
        time = time % 86400
        let hour = time / 3600
        time = time % 3600
        let minute = time / 60
        self.timePlayedLabel.text = "\(day)d \(hour)h \(minute)m"
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section > 0 {
            let link = sectionContent[indexPath.section - 1][indexPath.row].link
            if let url = URL(string: link) {
                let safariController = SFSafariViewController(url: url)
                present(safariController, animated: true, completion: nil)
            }
        } else {
            switch indexPath.row {
            case 0:
                // My level
                performSegue(withIdentifier: "myLevelSegue", sender: self)
            case 3:
                // Get more songs
                if let url = URL(string: "https://www.apple.com/itunes/") {
                    let safariController = SFSafariViewController(url: url)
                    present(safariController, animated: true, completion: nil)
                }
            case 4:
                performSegue(withIdentifier: "walkthroughSegue", sender: self)
            default:
                break
            }
            tableView.cellForRow(at: tableView.indexPathForSelectedRow!)?.isSelected = false
        }
    }

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return sectionTitles.count
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return sectionContent[section].count
//    }
//    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sectionTitles[section]
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
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch identifier {
            case "levelSelectorSegue":
                if let _ = segue.destination as? LevelViewController {
                    print("segue")
                }
            default:
                break
            }
        }
    }
    */

}
