//
//  MainViewController.swift
//  ARWave
//
//  Created by Leon Lee on 3/3/18.
//  Copyright © 2018 Leon Lee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var fourthLine: UILabel!
    @IBOutlet weak var beforeButton: UIButton!
    @IBOutlet weak var duringButton: UIButton!
    @IBOutlet weak var afterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fourthLine.center = CGPoint(x: 368, y:130)
        self.beforeButton.center = CGPoint(x: 150, y:240)
        self.duringButton.center = CGPoint(x: 368, y:240)
        self.afterButton.center = CGPoint(x: 586, y:240)

    }
    
    @IBAction func unwindSegue(_ sender: UIStoryboardSegue) {
        
    }
}
