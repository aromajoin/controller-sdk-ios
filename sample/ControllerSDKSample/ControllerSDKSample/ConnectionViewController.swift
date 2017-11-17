//
//  Copyright © 2017 Aromajoin. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth
import AromaShooterControllerSwift

class ConnectionViewController: UITableViewController{
  
  var aromashooterController = AromaShooterController.sharedInstance
  
  // height of sections
  let SECTION_HEIGHT: CGFloat = 40.0
  
  var discoveredDevices: [AromaShooter] = []
  var connectedDevices: [AromaShooter] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    aromashooterController.setDelegate(aromaShooterDelegate: self)
    
    tableView.tableFooterView = UIView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.aromashooterController.startScanning()
    self.connectedDevices = aromashooterController.connectedDevices
    discoveredDevices.removeAll()
    
    tableView.reloadData()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    // Stop searching
    aromashooterController.stopScanning()
  }
  
  // MARK: - UITableView Datasource
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  // Customize the section header
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: SECTION_HEIGHT))
    view.backgroundColor = UIColor.clear
    let label = UILabel(frame: CGRect(x: 10,y: (SECTION_HEIGHT - 30)/2,width: 200,height: 30))
    label.textColor =  UIColor.darkGray
    label.backgroundColor = UIColor.clear
    label.textAlignment = NSTextAlignment.left
    
    view.addSubview(label)
    
    switch section {
    case 0:
      label.text = "Connected"
      break
    case 1:
      label.text = "Available"
      // Add indicator
      let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
      indicator.frame = CGRect(x: 90,y: (SECTION_HEIGHT - indicator.frame.size.height)/2, width: indicator.frame.size.width, height: indicator.frame.height)
      indicator.color = UIColor.darkGray
      indicator.startAnimating()
      view.addSubview(indicator)
      break
    default:
      return view
    }
    
    return view
  }
  
  // number of rows in sections
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    var retVal = 0
    switch section {
    case 0:
      retVal = connectedDevices.count
      break
    case 1:
      retVal = discoveredDevices.count
    default:
      break
    }
    return retVal
  }
  
  // section height
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return SECTION_HEIGHT
  }
  
  // Contents for each cell
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "deviceViewCell") as? DeviceTableViewCell else {
      return UITableViewCell()
    }
    
    var device: AromaShooter?
    switch indexPath.section {
    case 0:
      if connectedDevices.count > 0 {
        device = connectedDevices[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.checkmark
      }
      break
    case 1:
      if discoveredDevices.count > 0 {
        device = discoveredDevices[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.none
      }
      break
    default:
      return cell
    }
    if let device = device {
      if device.getName() != nil {
        cell.deviceNameLabel.text = device.getName()
      }else {
        cell.deviceNameLabel.text = "Unknown Device"
      }
    }
    
    return cell
  }
}

// MARK: - AromashooterController Delegate
extension ConnectionViewController: AromaShooterDelegate{
  func aromaShooter(didDiscoverDevice device: AromaShooter) {
    for e in discoveredDevices {
      if e.getPeripheral().identifier.uuidString == device.getPeripheral().identifier.uuidString {
        return
      }
    }
    for e in connectedDevices {
      if e.getPeripheral().identifier.uuidString == device.getPeripheral().identifier.uuidString {
        return
      }
    }
    
    discoveredDevices.append(device)
    self.tableView.reloadData()
  }
  
  func aromaShooter(didConnectDevice device: AromaShooter) {
    connectedDevices.append(device)
    for i in 0 ..< discoveredDevices.count {
      if discoveredDevices[i].getPeripheral().identifier.uuidString == device.getPeripheral().identifier.uuidString{
        discoveredDevices.remove(at: i)
        break
      }
    }
    
    self.tableView.reloadData()
  }
  
  func aromaShooter(didDisconnectDevice device: AromaShooter) {
    for i in 0 ..< connectedDevices.count {
      if connectedDevices[i].getPeripheral().identifier.uuidString == device.getPeripheral().identifier.uuidString {
        connectedDevices.remove(at: i)
        break
      }
    }
    self.tableView.reloadData()
    aromashooterController.startScanning()
  }
}

// MARK: - UITableViewDelegate
extension ConnectionViewController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as! DeviceTableViewCell
    let deviceName = cell.deviceNameLabel.text
    
    switch indexPath.section {
    case 0:
      let uiAlertController = UIAlertController(title: deviceName, message: nil, preferredStyle: .actionSheet)
      uiAlertController.addAction(UIAlertAction(title: "Disconnect", style: UIAlertActionStyle.destructive, handler: { _ in
        self.aromashooterController.disconnect(aromaShooter: self.connectedDevices[indexPath.row])
      }))
      uiAlertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { _ in
      }))
      
      if let presenter = uiAlertController.popoverPresentationController {
        presenter.sourceView = cell
        presenter.sourceRect = cell.bounds
      }
      
      self.present(uiAlertController, animated: true, completion: nil)
      return
    case 1:
      cell.accessoryType = UITableViewCellAccessoryType.checkmark
      aromashooterController.connect(aromaShooters: [discoveredDevices[indexPath.row]])
      return
    default:
      return
    }
  }
}
