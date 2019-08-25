//
//  LevelViewController.swift
//  ChordPro
//
//  Created by Carlistle ZHENG on 8/25/19.
//  Copyright © 2019 Carlistle ZHENG. All rights reserved.
//

import UIKit

class LevelViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentLevelLabel.text = "Your current level:\n\(UserDefaults.standard.string(forKey: "UserLevel") ?? "")"
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var currentLevelLabel: UILabel!
    
    @IBAction func beginnerButtonSelected(_ sender: UIButton) {
        selectLevel(.easy)
    }
    @IBAction func intermediateButtonSelected(_ sender: UIButton) {
        selectLevel(.medium)
    }
    @IBAction func expertButtonSelected(_ sender: UIButton) {
        selectLevel(.hard)
    }
    
    private func selectLevel(_ level: Song.Difficulity) {
        UserDefaults.standard.set(level.rawValue, forKey: "UserLevel")
        navigationController?.popViewController(animated: true)
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
