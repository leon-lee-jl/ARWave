//
//  WelcomeViewController.swift
//  ARWave
//
//  Created by Leon Lee on 2/22/18.
//  Copyright © 2018 Leon Lee. All rights reserved.
//

import UIKit
import ImageSlideshow

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var firstLine: UILabel!
    @IBOutlet weak var secondLine: UILabel!
    @IBOutlet weak var thirdLine: UILabel!
    @IBOutlet weak var fourthLine: UILabel!
    
    @IBOutlet weak var beforeButton: UIButton!
    @IBOutlet weak var duringButton: UIButton!
    @IBOutlet weak var afterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Hide all lables and buttons and init positions
        self.firstLine.center = CGPoint(x: 368, y:-20)
        firstLine.isHidden = true

        self.secondLine.center = CGPoint(x: 368, y:-20)
        secondLine.isHidden = true

        self.thirdLine.center = CGPoint(x: 368, y:-20)
        thirdLine.isHidden = true
        
        self.fourthLine.center = CGPoint(x: 368, y:-20)
        fourthLine.isHidden = true
        
        self.beforeButton.center = CGPoint(x: -40, y:240)
        beforeButton.isHidden = true
        self.duringButton.center = CGPoint(x: -40, y:240)
        duringButton.isHidden = true
        self.afterButton.center = CGPoint(x: -40, y:240)
        afterButton.isHidden = true
        
        // Animate first line
        UIView.animate(withDuration: 1.5, delay: 1, options: [], animations: {
            self.firstLine.isHidden = false
            self.firstLine.center = CGPoint(x: 368, y:100)
        }, completion: nil)
        
        // Animate second line
        UIView.animate(withDuration: 2, delay: 3, options: [], animations: {
            self.secondLine.isHidden = false
            self.secondLine.center = CGPoint(x: 368, y:160)
        }, completion: nil)
        
        // Animate the third line
        UIView.animate(withDuration: 3, delay: 5.5, options: [], animations: {
            self.thirdLine.isHidden = false
            self.thirdLine.center = CGPoint(x: 368, y:220)
        }, completion: { (finished: Bool) in
            self.firstLine.isHidden = true
            self.secondLine.isHidden = true
            self.thirdLine.isHidden = true
        })
        
        // Animate the fourth line
        UIView.animate(withDuration: 2, delay: 9, options: [], animations: {
            self.fourthLine.isHidden = false
            self.fourthLine.center = CGPoint(x: 368, y:130)
        }, completion: nil)
        
        // Animate before button
        UIView.animate(withDuration: 1.5, delay: 12, options: [], animations: {
            self.beforeButton.isHidden = false
            self.beforeButton.center = CGPoint(x: 150, y:240)
        }, completion: nil)
        
        // Animate during button
        UIView.animate(withDuration: 2, delay: 14, options: [], animations: {
            self.duringButton.isHidden = false
            self.duringButton.center = CGPoint(x: 368, y:240)
        }, completion: nil)
        
        // Animate after button
        UIView.animate(withDuration: 2.5, delay: 16.5, options: [], animations: {
            self.afterButton.isHidden = false
            self.afterButton.center = CGPoint(x: 586, y:240)
        }, completion: nil)
        
    }
    
    @IBAction func unwindSegue(_ sender: UIStoryboardSegue) {
        
    }
}
