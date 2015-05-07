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
    
    //set the minor value of each beacons blueberry-> ice->mint
    
//    let blueberry = 55134
//    let ice = 11111
//    let mint= 47794
    
//    let blueberry = 6857
//    let ice = 44858
//    let mint = 12611
    
    let colors = [
        55134 : UIColor(red: 84/255, green: 77/255, blue: 160/255, alpha: 1),
        44858: UIColor(red: 142/255, green: 212/255, blue: 220/255, alpha: 1),
        47794: UIColor(red: 162/255, green: 213/255, blue: 181/255, alpha: 1)
    ]
    
    let ibeaconColorMap = [
        6857:"Location01",
        44858:"Location02",
        12611:"Location03"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        
            // may need to modify later
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse{
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.startRangingBeaconsInRegion(region)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        //This will print becons information near
        //println(beacons)
        // $0 means each
        let knowBeacons = beacons.filter{$0.proximity != CLProximity.Unknown}
        if knowBeacons.count > 0 {
            let closestBeacon = knowBeacons[0] as! CLBeacon
            self.view.backgroundColor = self.colors[closestBeacon.minor.integerValue]
            let serverID:String = self.ibeaconColorMap[closestBeacon.minor.integerValue]!

            SwiftPostman().createLocGPSContentInstance(serverID)
        }
    
    }
}

