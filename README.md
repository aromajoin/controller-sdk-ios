# Controller SDK for iOS

[//]: # (Add other badges such as version, build bagdges here)

[//]: # (Use Apache License as the default option)
[![License](https://img.shields.io/badge/license-Apache%202-4EB1BA.svg?style=flat-square)](https://www.apache.org/licenses/LICENSE-2.0.html)


**The iOS version of AromaShooterController SDK which is used to communicate with [Aroma Shooter devices](https://aromajoin.com/hardware/shooters/aroma-shooter-1)**    

# Table of Contents
1. [Supported devices](https://github.com/aromajoin/controller-sdk-ios#supported-devices)  
2. [Prerequisites](https://github.com/aromajoin/controller-sdk-ios#prerequisites)
3. [Installation](https://github.com/aromajoin/controller-sdk-ios#installation)
4. [Usage](#usage)
    * [First function](https://github.com/aromajoin/controller-sdk-ios#connect-devices)
    * [Second function](https://github.com/aromajoin/controller-sdk-ios#diffuse-scents)
5. [License](https://github.com/aromajoin/controller-sdk-ios#license)

## Supported devices
* Aroma Shooter Bluetooth version 


## Prerequisites
* iOS version: >= 8.0
* Swift version: >= 3.0

## Installation  
* Download the [framework file at the release page](https://github.com/aromajoin/controller-sdk-ios/releases).  
* Drag and drop it into your project. (Make sure that it is added in *Embedded Binaries section* in your project's target page).

## Usage  

### Connect devices  
There are 2 options at the moment.  
* Use the existing connection screen (ConnectionViewController) inside `sample` app. This is easy and recommended. 
   * Please check out this repository, grab `ConnectionViewController.swift` file to put in your project. 
   * For further detail, please take a look our `sample` applicaton.  
* Write your own connection screen using our API.  
   * Import Controller module  
   ```swift
   import AromaShooterControlerSwift
   ```
   * Get the Controller class reference  
   ```swift
   var aromashooterController = AromaShooterController.sharedInstance
   ```  
   * Scan AromaShooter devices  
   ```swift
   aromashooterController.startScanning()
   ```  
   * Make sure that scanning is stopped when the view controller dissapear  
   ```swift
    override func viewWillDisappear(_ animated: Bool) {
        // Stop searching
        aromashooterController.stopScanning()
        
    }
   ```  
   * Connect to a device  
   ```swift
   aromashooterController.connect(aromaShooters: devices)
   ```  
   * Disconnect to a device  
   ```swift
   aromashooterController.disconnect(aromaShooter: device)
   ```  
   * Get all current connected devices  
   ```swift
   aromashooterController.connectedDevices
   ```  
   
### Diffuse scents  
* Import Controller module  
```swift
import AromaShooterControlerSwift
```  
* Get the Controller class reference  
```swift
var aromashooterController = AromaShooterController.sharedInstance
```  
* Diffuse scents of all connected devices  
```swift
aromaShooterController.diffuseAll(duration: milliseconds, speed: 1, ports: ports)
```  
* Diffuse scents of specific devices  
```swift
aromaShooterController.diffuse(aromaShooters: devices, duration: milliseconds, speed: 1, ports: ports)
```  

**For more information, please checkout this repository and refer to the [sample project](https://github.com/aromajoin/controller-sdk-ios/tree/master/sample).**  
**If you get any issues or require any new features, please create a [new issue](https://github.com/aromajoin/controller-sdk-ios/issues).** 

## License  

The Apache License (Apache)

    Copyright (c) 2017 Aromajoin Corporation

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
