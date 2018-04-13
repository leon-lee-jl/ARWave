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

    var selectedModel = ""

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
        haveFunSceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]


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
    
    // Create a session configuration
    let standardConfiguration: ARWorldTrackingConfiguration = {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        return configuration
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Run the view's session
    AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
        haveFunSceneView.session.run(standardConfiguration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
    AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.landscapeRight, andRotateTo: UIInterfaceOrientation.landscapeRight)
        haveFunSceneView.session.pause()
    }
    
    
    @IBAction func restartSession(_ sender: Any) {
        haveFunSceneView.session.pause()
        haveFunSceneView.scene.rootNode.enumerateChildNodes {
            (node, stop) in node.removeFromParentNode()
        }
        haveFunSceneView.session.run(standardConfiguration, options: [.resetTracking, .removeExistingAnchors])
        selectedModel = ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Looking at the location where the user touched the screen */
        guard let touch = touches.first else {return}
        let result = haveFunSceneView.hitTest(touch.location(in: haveFunSceneView), types: [ARHitTestResult.ResultType.featurePoint])
        guard let hitResult = result.last else {return}
        
        /* transforms the result into a matrix_float 4x4 so the SCN Node can read the data */
        let hitTransform = hitResult.worldTransform
        
        /* Print the coordinates captured */
//        print("x: ", hitTransform[3].x, "\ny: ", hitTransform[3].y, "\nz: ", hitTransform[3].z)
        
        /* Look at Add Geometry Class in Controller Group */
        if selectedModel.isEmpty {
            let alert = UIAlertController(title: "No model selected.", message: "You need to select a model first.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        else {
            var path = "art.scnassets/" + selectedModel + ".dae"
            addObject(position: hitTransform, sceneView: haveFunSceneView, node: modelNode, objectPath: path)

        }
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
        modelNode.runAction(SCNAction.scale(by: pinch.scale, duration: 0.01))
    }
    
    @objc func panRecognized(pan: UIPanGestureRecognizer) {
        
        let xPan = pan.velocity(in: haveFunSceneView).x/1000
        /*
         y pan is a not tuned for user expereience
         let yPan = pan.velocity(in: sceneView).y/10000
         */
        
        modelNode.runAction(SCNAction.rotateBy(x: 0, y: xPan, z: 0, duration: 0.01))
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
    
    @IBAction func unwindSegueToFun(_ sender: UIStoryboardSegue) {
        if let senderVC = sender.source as? SelectModelViewController {
            selectedModel = senderVC.currentModel
            
        }
    }
    


}
