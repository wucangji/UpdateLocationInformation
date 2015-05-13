//
//  ViewController.swift
//  ClosestBeacon
//
//  Created by Cangji Wu on 5/5/15.
//  Copyright (c) 2015 Cangji Wu. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{

    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D"), identifier: "Estimotes")
    
    @IBOutlet weak var ibeaconView: UIView!
    let uuid = "PhoneID1"
    var ibeaconMinIDS = [Int]()
    var colors = [Int:UIColor]()
    var ibeaconColorMap = [Int:String]()
    
    @IBOutlet weak var ChangeLabel: UILabel!
      //Lionel's beacons + Cangji's beacons
//    let colors = [
//        55134 : UIColor(red: 84/255, green: 77/255, blue: 160/255, alpha: 1),
//        51091: UIColor(red: 142/255, green: 212/255, blue: 220/255, alpha: 1),
//        47794: UIColor(red: 162/255, green: 213/255, blue: 181/255, alpha: 1),
//        
//        6857 : UIColor(red: 84/255, green: 77/255, blue: 160/255, alpha: 1),
//        44858: UIColor(red: 142/255, green: 212/255, blue: 220/255, alpha: 1),
//        12611: UIColor(red: 162/255, green: 213/255, blue: 181/255, alpha: 1)
//    ]
//
//    let ibeaconColorMap = [
//        55134:"Location01",
//        51091:"Location02",
//        47794:"Location03",
//        
//        6857:"Location01",
//        44858:"Location02",
//        12611:"Location03"
//    ]
    
    
    //Cangji's Beacons
//        let colors = [
//            6857 : UIColor(red: 84/255, green: 77/255, blue: 160/255, alpha: 1),
//            44858: UIColor(red: 142/255, green: 212/255, blue: 220/255, alpha: 1),
//            12611: UIColor(red: 162/255, green: 213/255, blue: 181/255, alpha: 1)
//        ]
//    
//        let ibeaconColorMap = [
//            6857:"Location01",
//            44858:"Location02",
//            12611:"Location03"
//        ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        
            // may need to modify later
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse{
            locationManager.requestWhenInUseAuthorization()
        }
        SwiftPostman().createUUIDLocBeaconContainer(self.uuid)
        locationManager.startRangingBeaconsInRegion(region)
        print(ibeaconMinIDS)
        initbeacons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func initbeacons(){
        //set the minor value of each beacons blueberry-> ice->mint

        colors[ibeaconMinIDS[0]] = UIColor(red: 84/255, green: 77/255, blue: 160/255, alpha: 1)
        colors[ibeaconMinIDS[1]] = UIColor(red: 142/255, green: 212/255, blue: 220/255, alpha: 1)
        colors[ibeaconMinIDS[2]] = UIColor(red: 162/255, green: 213/255, blue: 181/255, alpha: 1)

        ibeaconColorMap[ibeaconMinIDS[0]] = "Location01"
        ibeaconColorMap[ibeaconMinIDS[1]] = "Location02"
        ibeaconColorMap[ibeaconMinIDS[2]] = "Location03"
    
    }
    
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        //This will print becons information near
        //println(beacons)
        // $0 means each
        let knowBeacons = beacons.filter{$0.proximity != CLProximity.Unknown}
        if knowBeacons.count > 0 {
            let closestBeacon = knowBeacons[0] as! CLBeacon
            // wait 2 seconds
            delay(2){
                let closestBeacon2 = knowBeacons[0] as! CLBeacon
            
                if closestBeacon == closestBeacon2 {
                    self.ibeaconView.backgroundColor = self.colors[closestBeacon.minor.integerValue]
                    if let serverID:String = self.ibeaconColorMap[closestBeacon.minor.integerValue] {
                        if self.ChangeLabel.text != serverID{
                            self.ChangeLabel.text = serverID
                            SwiftPostman().createLocGPSContentInstance(self.uuid,info:serverID)
                            // SwiftPostman().createLocGPSContentInstance(self.uuid,info:serverID)
                        }
                    }
                    else{
                        let myAlert = UIAlertController(title: "Error", message: "ibeacon id is not correct", preferredStyle: UIAlertControllerStyle.Alert)
                        myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                        //show the alert
                        self.presentViewController(myAlert, animated: true, completion: nil)
                    }
                }
            }
        }
    
    }
    
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    
}

