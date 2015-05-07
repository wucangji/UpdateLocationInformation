
//
//  SwiftPostman.swift
//  ClosestBeacon
//
//  Created by Cangji Wu on 5/6/15.
//  Copyright (c) 2015 Cangji Wu. All rights reserved.
//

import Foundation


class SwiftPostman {
    
    let hostname = "10.194.104.186"
    //let fromHostname = "other"


    
    func createLocGPSContentInstance(info: String) {
        // set input method
        let httpMethod = "POST"
        let urlAsString = "http://"+hostname+":8282/InCSE1/LocationAE/Things/KVM/Location"
        
        /* use this json payload to create content instances */
        var params: [NSString : AnyObject] =
        [
            "from":"http:localhost:10000",
            "requestIdentifier":"12345",
            "resourceType":"contentInstance",
            "content": [
                "content":info
            ]
        ]
        
        // url request properties
        let url = NSURL(string: urlAsString)
        let cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
        var err: NSError?
        
        // config request with timeout
        let urlRequest = NSMutableURLRequest(URL: url!, cachePolicy: cachePolicy, timeoutInterval: 1.0)
        urlRequest.HTTPMethod = httpMethod
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("Basic YWRtaW46YWRtaW4=", forHTTPHeaderField: "Authorization")
        urlRequest.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        
        // init queue
        let queue = NSOperationQueue()
        
        // create connection on a new thread for request
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: queue) { (reponse: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            // deserialize json object
            let json = JSON(data: data)
            println("Received response! Created a new content instance in LocGPS!")
            println("\n-------------------------------\n")
            
        } // end url block
    }
}