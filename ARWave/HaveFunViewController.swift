//
//  HaveFunViewController.swift
//  ARWave
//
//  Created by Leon Lee on 3/8/18.
//  Copyright © 2018 Leon Lee. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import Photos
import JJFloatingActionButton
import Foundation


class HaveFunViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var screenshotButton: UIButton!
    // Init a scn object
    let modelNode = SCNNode()
    var node = SCNNode()

    
    // Init two buttons
    fileprivate let addButton = JJFloatingActionButton()
    fileprivate let selfieButton = JJFloatingActionButton()

    @IBOutlet weak var haveFunSceneView: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define two guestures detection, and add to current view.
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchRecognized(pinch:)))
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panRecognized(pan:)))
        self.view.addGestureRecognizer(pinchGesture)
        self.view.addGestureRecognizer(panGesture)
        
        
        haveFunSceneView.delegate = self
        let scene = SCNScene()
        haveFunSceneView.scene = scene
        haveFunSceneView.autoenablesDefaultLighting = true

        // Init add model button and selfie button
//        addButton.addItem(title: "Heart", image: #imageLiteral(resourceName: "add")) { item in
//            print("I am inside add Button")
//        }
//        selfieButton.addItem(title: "Heart", image: #imageLiteral(resourceName: "record")) { item in
//            print("I am inside Selfie Button")
//        }
//        addButton.display(inViewController: self)
//        selfieButton.display(inViewController: self)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let standardConfiguration: ARWorldTrackingConfiguration = {
            let configuration = ARWorldTrackingConfiguration()
            configuration.planeDetection = .horizontal
            return configuration
        }()
        
        // Run the view's session
        haveFunSceneView.session.run(standardConfiguration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        haveFunSceneView.session.pause()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Looking at the location where the user touched the screen */
        guard let touch = touches.first else {return}
        let result = haveFunSceneView.hitTest(touch.location(in: haveFunSceneView), types: [ARHitTestResult.ResultType.featurePoint])
        guard let hitResult = result.last else {return}
        
        /* transforms the result into a matrix_float 4x4 so the SCN Node can read the data */
        let hitTransform = hitResult.worldTransform
        
        /* Print the coordinates captured */
        print("x: ", hitTransform[3].x, "\ny: ", hitTransform[3].y, "\nz: ", hitTransform[3].z)
        
        /* Look at Add Geometry Class in Controller Group */
        addObject(position: hitTransform, sceneView: haveFunSceneView, node: modelNode, objectPath: "art.scnassets/cup/cup.scn")
    }
    

    func addObject(position: matrix_float4x4, sceneView: ARSCNView, node: SCNNode, objectPath: String){
        
        node.position = SCNVector3(position[3].x, position[3].y, position[3].z)
        
        // Create a new scene
        guard let virtualObjectScene = SCNScene(named: objectPath)
            else {
                print("Unable to Generate" + objectPath)
                return
        }
        
        let wrapperNode = SCNNode()
        for child in virtualObjectScene.rootNode.childNodes {
            child.geometry?.firstMaterial?.lightingModel = .physicallyBased
            wrapperNode.addChildNode(child)
        }
        
        node.addChildNode(wrapperNode)
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    @objc func pinchRecognized(pinch: UIPinchGestureRecognizer) {
        node.runAction(SCNAction.scale(by: pinch.scale, duration: 0.1))
    }
    
    @objc func panRecognized(pan: UIPanGestureRecognizer) {
        
        let xPan = pan.velocity(in: haveFunSceneView).x/10000
        /*
         y pan is a not tuned for user expereience
         let yPan = pan.velocity(in: sceneView).y/10000
         */
        
        node.runAction(SCNAction.rotateBy(x: 0, y: xPan, z: 0, duration: 0.1))
    }
    

    @IBAction func takeScreenshot(_ sender: Any) {
        print("Clicked")
        
        let takeScreenshotBlock = {
            UIImageWriteToSavedPhotosAlbum(self.haveFunSceneView.snapshot(), nil, nil, nil)
            DispatchQueue.main.async {
                // Briefly flash the screen.
                let flashOverlay = UIView(frame: self.haveFunSceneView.frame)
                flashOverlay.backgroundColor = UIColor.white
                self.haveFunSceneView.addSubview(flashOverlay)
                UIView.animate(withDuration: 0.25, animations: {
                    flashOverlay.alpha = 0.0
                }, completion: { _ in
                    flashOverlay.removeFromSuperview()
                })
            }
        }
        
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            takeScreenshotBlock()
        case .restricted, .denied:
            let title = "Photos access denied"
            let message = "Please enable Photos access for this application in Settings > Privacy to allow saving screenshots."
            print("Access Denied")
//            textManager.showAlert(title: title, message: message)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (authorizationStatus) in
                if authorizationStatus == .authorized {
                    takeScreenshotBlock()
                }
            })
        }
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
