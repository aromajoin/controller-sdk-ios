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
  
  @IBAction func diffuseAroma(_ sender: UIButton) {
    aromaShooterController.diffuseAll(duration: 2000, booster: true, ports: [sender.tag])
  }
}

