//
//  OnboardingViewController.swift
//  ChordPro
//
//  Created by Carlistle ZHENG on 9/6/19.
//  Copyright © 2019 Carlistle ZHENG. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    let TOTAL_PAGE = 3
    var currentPage = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.currentPage = 0
        // Do any additional setup after loading the view.
        currentPage = 0
        updatePage()
    }
    
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func nextTouched(_ sender: UIButton) {
        currentPage += 1
        updatePage()
    }
    
    @IBOutlet weak var skipButton: UIButton!
    @IBAction func skipTouched(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    private func updatePage() {
        pageControl.currentPage = currentPage
        imageView.image = UIImage(named: "onboarding\(currentPage)")
        if currentPage >= TOTAL_PAGE - 1 {
            nextButton.isHidden = true
        } else if currentPage == 0 {
            previousButton.isHidden = true
        } else {
            nextButton.isHidden = false
            previousButton.isHidden = false
        }
    }
    
    @IBOutlet weak var previousButton: UIButton!
    @IBAction func previousTouched(_ sender: UIButton) {
        currentPage -= 1
        updatePage()
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
}
