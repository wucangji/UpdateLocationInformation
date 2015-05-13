//
//  SelectUserViewController.swift
//  ClosestBeacon
//
//  Created by Cangji Wu on 5/12/15.
//  Copyright (c) 2015 Cangji Wu. All rights reserved.
//

import UIKit

class SelectUserViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    // set the default data
    
    let ibeaconUsers = ["Lionel","John","Cangji"]
    let remoteServers = ["Server1","Server2"]

    var ibeaconMinIDS = [55134, 51091, 47794]
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return ibeaconUsers.count
        }
        else{
            return remoteServers.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if component == 0{
            return ibeaconUsers[row]
        }
        else{
            return remoteServers[row]
        }
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            switch row{
                case 0:
                    ibeaconMinIDS = [55134, 51091, 47794]
                case 2:
                    ibeaconMinIDS = [6857, 44858, 12611]
                default :
                    ibeaconMinIDS = [55134, 51091, 47794]
                
            }
        
        }
        else{
            // second colomn
            switch row{
            case 0:
                let ServerIP = "10.194.104.186"
            case 1:
                let ServerIP = "10.194.104.186"
            default:
                let ServerIP = "10.194.104.186"
            }
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        var secondScene = segue.destinationViewController as! ViewController
        
        // Pass the selected object to the new view controller.
        secondScene.ibeaconMinIDS = ibeaconMinIDS
        
    }
    

}
