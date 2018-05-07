//
//  BeforeDoneViewController.swift
//  ARWave
//
//  Created by Leon Lee on 5/7/18.
//  Copyright © 2018 Leon Lee. All rights reserved.
//

import UIKit

class BeforeDoneViewController: UIViewController {

    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        playAgainButton.layer.cornerRadius = 6
        homeButton.layer.cornerRadius = 6

        // Do any additional setup after loading the view.
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
