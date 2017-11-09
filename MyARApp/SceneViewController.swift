//
//  SceneViewController.swift
//  MyARApp
//
//  Created by Quentin on 9/21/17.
//  Copyright © 2017 Quentin Fasquel. All rights reserved.
//

import Foundation
import ARKit

func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}

extension Int {
    var degreeToRadians : CGFloat {
        return CGFloat(self) * CGFloat(Double.pi / 180)
    }
}

class SceneViewController: ARSceneBaseViewController {
    
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView = createSceneView()
        self.view.addSubview(self.sceneView)
        
        self.setupAR()
        self.sceneView.session.run(configuration)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.sceneView.session.pause()
        super.viewWillDisappear(animated)
    }
    
    override func setupTrackables() {
        if let imagePath = Bundle.main.path(forResource: "doritos-logo-big", ofType: "jpg"), let image = UIImage(named: imagePath) {
            addTrackable(imagePath, width: image.size.width, height: image.size.height)
        }
    }
    
    override func draw3DRelevant(of trackableID: Int) {
        print("It is working")
    }
}

/*class SceneViewController: ARSceneViewController, ARSCNViewDelegate {
    
    var animations = [String: CAAnimation]()
    var modelFound: Bool = false
    var objectAdded: Bool = false
    
    override func createScene() -> SCNScene {
        let scene = super.createScene()
        return scene
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupTrackables() {
        
        if let imagePath = Bundle.main.path(forResource: "doritos-logo-big", ofType: "jpg"), let image = UIImage(named: imagePath) {
            addTrackable(imagePath, width: image.size.width, height: image.size.height)
        }
    }
    
    override func draw3DRelevant(of trackableID: Int) {
        modelFound = true
    }
    
    func addNode(at position: SCNVector3) {
        
        if objectAdded == false {
            //Mickey_Mouse
            // Load the character in the idle animation
            guard let idleScene = SCNScene(named: "art.scnassets/Robbie.dae") else {
                print("Scene not available")
                return
            }
            
            // This node will be parent of all the animation models
            let node = SCNNode()
            
            // Add all the child nodes to the parent node
            for child in idleScene.rootNode.childNodes {
                node.addChildNode(child)
            }
            
            // Set up some properties
            node.position = position//SCNVector3(0.1, 0.1, 0)
            node.scale = SCNVector3(2, 2, 2)
            node.eulerAngles = SCNVector3(90.degreeToRadians, 180.degreeToRadians, 0)
            
            // Add the node to the scene
            if let viewScene = self.sceneView {
                if let scene = viewScene.scene {
                    print(position)
                    scene.rootNode.addChildNode(node)
                    objectAdded = true
                    if let material = scene.rootNode.geometry?.firstMaterial {
                        material.diffuse.contents = UIColor.red
                        print("color")
                    } else {
                        print("No color")
                    }
                } else {
                    print("node not added")
                }
            } else {
                print("node not added")
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        guard let sceneView = self.sceneView else {
            return
        }
        
        // check what nodes are tapped
        let p = touches.first!.location(in: sceneView)
        // get the camera
        guard let camera = sceneView.pointOfView?.camera else {
            return
        }
        // screenZ is percentage between z near and far
        let screenZ = Float((10 - camera.zNear) / (camera.zFar - camera.zNear))
        let scenePoint = sceneView.unprojectPoint(SCNVector3Make(Float(p.x), Float(p.y), screenZ))
        print("tapPoint: (\(p.x), \(p.y)) scenePoint: (\(scenePoint.x), \(scenePoint.y), \(scenePoint.z))")
        addNode(at: scenePoint)
    }
}*/
