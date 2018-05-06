//
//  MainViewController.swift
//  ARWave
//
//  Created by Leon Lee on 3/3/18.
//  Copyright © 2018 Leon Lee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var beforeButton: UIButton!
    @IBOutlet weak var duringButton: UIButton!
    @IBOutlet weak var afterButton: UIButton!
    
    override func viewDidLoad() {
        beforeButton.layer.cornerRadius = 10
        duringButton.layer.cornerRadius = 10
        afterButton.layer.cornerRadius = 10
        super.viewDidLoad()
    }
    
    @IBAction func unwindSegue(_ sender: UIStoryboardSegue) {
        
    }
}
