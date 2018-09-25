#Aroma Shooter Controller
**An iOS version of AromaShooterController library which is used to communicate with Aroma Shooter devices**  
There is an existing Object-C version of the library which can be found here.[**AromaShooterController-ObjectC**](https://bitbucket.org/aromajoin/aromashootercontroller)  
The reason to create Swift version instead of using the existing Object-C library: 
* Main reason: it is difficult to maintain the current library written by Object-C. We don't have Object-C developers at the time that Swift version is created.
* Second reason: Swift is clean and easy-to-understand. Also, it is well supported by Apple and the community.
* Third reason: It is fun to play with Swift :D 

##Table of Contents
1. Main parts
2. Library installation
3. Usage
4. References

---------
###Main parts

###Library installation  
* Add this framework as sub-project: 
    - Clone first: git clone git@bitbucket.org:aromajoin/aromashootercontrollerswift.git  
    - Go to your project in Xcode, right-click on the root of project => Click "Add Files to ...".
    - In the file chooser, navigate to and select **AromaShooterController.xcodeproj** from the just cloned repository.
    - Add framework to **Embedded Binaries**: Select the top level node of your project, click the target and go to General tab and scroll down to Embedded Binaries section and add AromaShooterControllerSwift framework there.
* Use cocoaPods: TODO: Integrate later....  
 
###Usage  
#####To discover, connect, and disconnect AromaShooter devices  
....
#####Diffuse scents 
....
###References
[Protocol Description Document](https://aromashooter.atlassian.net/wiki/display/AJ/Bluetooth+Aromashooter+Protocol)  
__Note__: For Android application, please refer to the existing library's [*Android version*](https://bitbucket.org/aromajoin/aromashootercontrollerandroid).
