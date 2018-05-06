//
//  DuringWelcomeViewController.swift
//  ARWave
//
//  Created by Leon Lee on 5/5/18.
//  Copyright © 2018 Leon Lee. All rights reserved.
//

import UIKit

class DuringWelcomeViewController: UIViewController {

    @IBOutlet weak var firstLineText: UILabel!
    @IBOutlet weak var secondLineText: UILabel!
    @IBOutlet weak var thirdLineText: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var warningText: UILabel!
    @IBOutlet weak var warningImage: UIImageView!
    @IBOutlet weak var closeWarningButton: UIButton!
    
    override func viewDidLoad() {
        self.secondLineText.isHidden = true
        self.thirdLineText.isHidden = true
        self.startButton.isHidden = true
        self.warningText.isHidden = true
        self.warningImage.isHidden = true
        self.closeWarningButton.isHidden = true
        self.startButton.layer.cornerRadius = 6
        super.viewDidLoad()
        self.warningText.layer.borderWidth = 1.0
        self.warningText.layer.borderColor =  UIColor.red.cgColor
        self.warningText.layer.cornerRadius = 8

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            self.secondLineText.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.6) {
            self.thirdLineText.isHidden = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.4) {
            self.secondLineText.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.2) {
            self.warningText.isHidden = false
            self.warningImage.isHidden = false
            self.closeWarningButton.isHidden = false
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeWarning(_ sender: UIButton) {
        self.warningText.isHidden = true
        self.warningImage.isHidden = true
        self.closeWarningButton.isHidden = true
        self.startButton.isHidden = false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
