//
//  ChordLibraryCollectionViewController.swift
//  ChordPro
//
//  Created by Carlistle ZHENG on 8/11/19.
//  Copyright © 2019 Carlistle ZHENG. All rights reserved.
//

import UIKit

private let reuseIdentifier = "chordLibraryCell"

class ChordLibraryCollectionViewController: UICollectionViewController {
    
    // MARK: - Model
    var chords = [[Chord]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
        self.chords = ChordFactory.getChords()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch identifier {
            case "chordPopoverSegue":
                if let vc = segue.destination as? ChordPopoverViewController {
//                    if let ppc = vc.popoverPresentationController {
//                        ppc.permittedArrowDirections = .any
////                        ppc.delegate = self
//                    }
                    if let chordCell = sender as? ChordLibraryCollectionViewCell {
                        vc.chord = Chord(chordCell.nameLabel.text ?? "")
                    }
                }
            default: break
            }
        }
    }
 

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.chords.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return chords[section].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard
                let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "chordSectionHeader",
                    for: indexPath) as? ChordCollectionReusableView
                else {
                    fatalError("Invalid view type")
            }
            
            let titleDictionary = [0: "C", 1: "D", 2: "E", 3: "F", 4: "G", 5: "A", 6: "B"]
            headerView.sectionTitleLabel.text = "\(titleDictionary[indexPath.section] ?? "") chords"
            return headerView
        default:
            assert(false, "Invalid element type")
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChordLibraryCollectionViewCell
    
        // Configure the cell
        let chordName = self.chords[indexPath.section][indexPath.row].name
        cell.nameLabel.text = chordName
        cell.chordImage.image = UIImage(named: "chord_" + chordName)
        cell.sizeThatFits(CGSize(width: 80, height: 80))
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "chordPopoverSegue", sender: collectionView.cellForItem(at: indexPath))
    }

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

// MARK: - Collection View Flow Layout Delegate
extension ChordLibraryCollectionViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 100)
    }
}
