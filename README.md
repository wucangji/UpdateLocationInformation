# UpdateLocationInformation
send location(beaconID) to the server

Introduction
============
use beacons to represent locations, if a phone is close to each one, the beacons can tell where the phone is, in our example, the if the phone is close to beacon1, then we send Location01 to the certain place in the server, to let the server know that the user(phone) latest location.
We update the location information each second. 



### Usage

* Use Xcode 6.3 (latest version) to open the project file.
* The server information is stored in "SwiftPostman" at line 15~25
* Modify the "ViewController.swift" file at line 20~30, change the ibeacon minor information, use your own ibeacons' minor data for each ibeacon.
* Connect your iphone to your mac, make sure you use the developer account in the preference ->account settings. 
* According to your server setting, Make sure your phone is using Cisco's wifi and bluetooth is open.
 