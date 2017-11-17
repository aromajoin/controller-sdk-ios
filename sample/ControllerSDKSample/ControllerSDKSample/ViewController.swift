//
//  ViewController.swift
//  ControllerSDKSample
//
//  Created by Quang Nguyen on 2/20/17.
//  Copyright © 2017 Aromajoin. All rights reserved.
//

import UIKit
import AromaShooterControllerSwift

class ViewController: UIViewController {
    let aromaShooterController = AromaShooterController.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    @IBAction func diffuseAroma(_ sender: UIButton) {
      aromaShooterController.diffuseAll(duration: 2000, booster: true, ports: [sender.tag])
    }
}

