//
//  WelcomeOneViewController.swift
//  ARWave
//
//  Created by Leon Lee on 5/5/18.
//  Copyright © 2018 Leon Lee. All rights reserved.
//

import UIKit

class WelcomeOneViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var firstLineText: UILabel!
    @IBOutlet weak var secondLineText: UILabel!
    @IBOutlet weak var thirdLineText: UILabel!
    
    override func viewDidLoad() {
        self.nextButton.layer.cornerRadius = 6
        self.nextButton.isHidden = true
        self.secondLineText.isHidden = true
        self.thirdLineText.isHidden = true
        super.viewDidLoad()

        // Animations for second text field
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            self.secondLineText.isHidden = false
        }
        // Animations for third text field
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.6) {
            self.thirdLineText.isHidden = false
            self.nextButton.isHidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
