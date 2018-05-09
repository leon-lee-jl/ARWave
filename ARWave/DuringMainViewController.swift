//
//  DuringMainViewController.swift
//  ARWave
//
//  Created by Leon Lee on 5/7/18.
//  Copyright © 2018 Leon Lee. All rights reserved.
//

import UIKit

class DuringMainViewController: UIViewController {

    @IBOutlet weak var tableNearByButton: UIButton!
    @IBOutlet weak var noTableNearByButton: UIButton!
    @IBOutlet weak var everyoneRunningButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableNearByButton.layer.cornerRadius = 6
        tableNearByButton.titleLabel?.textAlignment = NSTextAlignment.center
        noTableNearByButton.layer.cornerRadius = 6
        noTableNearByButton.titleLabel?.textAlignment = NSTextAlignment.center
        everyoneRunningButton.layer.cornerRadius = 6
        everyoneRunningButton.titleLabel?.textAlignment = NSTextAlignment.center
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindSegueToDuringMain(_ sender: UIStoryboardSegue) {
        
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
