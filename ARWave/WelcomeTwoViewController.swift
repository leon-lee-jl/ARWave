//
//  WelcomeTwoViewController.swift
//  ARWave
//
//  Created by Leon Lee on 5/5/18.
//  Copyright © 2018 Leon Lee. All rights reserved.
//

import UIKit

class WelcomeTwoViewController: UIViewController {

    @IBOutlet weak var firstLineText: UILabel!
    @IBOutlet weak var beforeLabel: UILabel!
    @IBOutlet weak var duringLabel: UILabel!
    @IBOutlet weak var afterLabel: UILabel!
    @IBOutlet weak var secondLineText: UILabel!
    
    override func viewDidLoad() {
        self.beforeLabel.isHidden = true
        self.duringLabel.isHidden = true
        self.afterLabel.isHidden = true
        self.secondLineText.isHidden = true
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            self.beforeLabel.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.6) {
            self.duringLabel.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.4) {
            self.afterLabel.isHidden = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.2) {
            self.secondLineText.isHidden = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "main") as UIViewController
            self.present(nextViewController, animated:true, completion:nil)        }
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
