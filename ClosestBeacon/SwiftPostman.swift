
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


    
    func createNewUserContainer() {
        
        // set input method
        let httpMethod = "POST"
        
        let userID = PFUser.currentUser()?.username
        
        // use this url to create new user ID
        let urlAsString = "http://"+hostname+":8282/InCSE1/UserAE"
        // default JSON payload
        var params: [NSString : AnyObject] =
        [
            "from":"http:localhost:10000",
            "requestIdentifier":"12345",
            "resourceType":"container",
            "content":[
                "resourceName":userID!,
            ]
        ]
        
        // url request properties
        let url = NSURL(string: urlAsString)
        let cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
        var err: NSError?
        
        // config request with timeout
        let urlRequest = NSMutableURLRequest(URL: url!, cachePolicy: cachePolicy, timeoutInterval: 15.0)
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
            println("Setup \(userID) Container.")
            println("\n-------------------------------\n")
            
            self.createUUIDContainerUserAE()
            
        } // end url block
    }

    
    func createUUIDContainerUserAE() {
        
        // set input method
        let httpMethod = "POST"
        
        let userID = PFUser.currentUser()?.username
        let uuid = UIDevice.currentDevice().identifierForVendor.UUIDString
        
        // use this url to create new UUID
        let urlAsString = "http://"+hostname+":8282/InCSE1/UserAE/"+userID!
        
        // JSON payload
        var params: [NSString : AnyObject] =
        [
            "from":"http:localhost:10000",
            "requestIdentifier":"12345",
            "resourceType":"container",
            "content": [
                "labels":"",
                "resourceName":uuid,
            ]
        ]
        
        // url request properties
        let url = NSURL(string: urlAsString)
        let cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
        var err: NSError?
        
        // config request with timeout
        let urlRequest = NSMutableURLRequest(URL: url!, cachePolicy: cachePolicy, timeoutInterval: 15.0)
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
            println("Setup UUID Container under UserAE.")
            println("\n-------------------------------\n")
            
            self.createUUIDContainerLocationAE()
            
        } // end url block
    }

    
    func createUUIDContainerLocationAE() {
        
        // set input method
        let httpMethod = "POST"
        
        let uuid = UIDevice.currentDevice().identifierForVendor.UUIDString
        
        // use this url to create new UUID
        let urlAsString = "http://"+hostname+":8282/InCSE1/LocationAE/Things/?from=http:"+hostname+":10000&requestIdentifier=12345"
        
        // JSON payload
        var params: [NSString : AnyObject] =
        [
            "from":"http:localhost:10000",
            "requestIdentifier":"12345",
            "resourceType":"container",
            "content": [
                "labels":"",
                "resourceName":uuid,
            ]
        ]
        
        // url request properties
        let url = NSURL(string: urlAsString)
        let cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
        var err: NSError?
        
        // config request with timeout
        let urlRequest = NSMutableURLRequest(URL: url!, cachePolicy: cachePolicy, timeoutInterval: 15.0)
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
            println("Setup UUID Container under LocationAE.")
            println("\n-------------------------------\n")
            
            self.createLocBeaconContainer()
            
        } // end url block
    }
    
    
    
    func createLocBeaconContainer() {
        
        // set input method
        let httpMethod = "POST"
        
        let uuid = UIDevice.currentDevice().identifierForVendor.UUIDString
        
        // use this url to create new UUID
        let urlAsString = "http://"+hostname+":8282/InCSE1/LocationAE/Things/"+uuid+"/?from=http:"+hostname+":10000&requestIdentifier=12345"
        
        // JSON payload
        var params: [NSString : AnyObject] =
        [
            "from":"http:localhost:10000",
            "requestIdentifier":"12345",
            "resourceType":"container",
            "content": [
                "labels":"",
                "resourceName":"LocBeacon",
            ]
        ]
        
        // url request properties
        let url = NSURL(string: urlAsString)
        let cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
        var err: NSError?
        
        // config request with timeout
        let urlRequest = NSMutableURLRequest(URL: url!, cachePolicy: cachePolicy, timeoutInterval: 15.0)
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
            println("Setup LocBeacon Container.")
            println("\n-------------------------------\n")
            
            
        } // end url block
    }

    
    func createLocGPSContentInstance(uuid:String, info: String) {
        // set input method
        let httpMethod = "POST"
        let urlAsString = "http://"+hostname+":8282/InCSE1/LocationAE/Things/"+uuid+"/LocBeacon"
        
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
        let urlRequest = NSMutableURLRequest(URL: url!, cachePolicy: cachePolicy, timeoutInterval: 15.0)
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
            if data == nil{
                println("Do not receive any response")
                
            }else{
                let json = JSON(data: data)
                println("json:\(json)")
//                json:{
//                    "output" : {
//                        "responseCode" : "STATUS_CREATED a 'contentInstance' ",
//                        "responseStatusCode" : 2001,
//                        "content" : "Hierarchical path:InCSE1\/LocationAE\/Things\/KVM\/Location\/426128",
//                        "responseIdentifier" : "ResourceIdentifier"
//                    }
//                }
                println("Received response! Created a new content instance in LocGPS!")
                println("\n-------------------------------\n")
            }
        } // end url block
    }
    
    
    func createUUIDLocBeaconContainer(uuid:String) {
        
        // set input method
        let httpMethod = "POST"
        
        //let uuid = UIDevice.currentDevice().identifierForVendor.UUIDString
        // use this url to create new UUID
        let urlAsString = "http://"+hostname+":8282/InCSE1/LocationAE/Things/?from=http:"+hostname+":10000&requestIdentifier=12345"
        
        // JSON payload
        var params: [NSString : AnyObject] =
        [
            "from":"http:localhost:10000",
            "requestIdentifier":"12345",
            "resourceType":"container",
            "content": [
                "labels":"",
                "resourceName":uuid,
            ]
        ]
        
        // url request properties
        let url = NSURL(string: urlAsString)
        let cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
        var err: NSError?
        
        // config request with timeout
        let urlRequest = NSMutableURLRequest(URL: url!, cachePolicy: cachePolicy, timeoutInterval: 15.0)
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
            if data == nil{
                println("Do not receive any response")
                
            }else{
                let json = JSON(data: data)
                println("json:\(json)")
                println("Setup UUID Container under LocationAE.")
                println("\n-------------------------------\n")
                
                self.createLocBeaconContainer(uuid)
            }
        } // end url block
    }
    
    
    
    func createLocBeaconContainer(uuid:String) {
        
        // set input method
        let httpMethod = "POST"
        
        //let uuid = UIDevice.currentDevice().identifierForVendor.UUIDString
        
        // use this url to create new UUID
        let urlAsString = "http://"+hostname+":8282/InCSE1/LocationAE/Things/"+uuid+"/?from=http:"+hostname+":10000&requestIdentifier=12345"
        
        // JSON payload
        var params: [NSString : AnyObject] =
        [
            "from":"http:localhost:10000",
            "requestIdentifier":"12345",
            "resourceType":"container",
            "content": [
                "maxNrOfInstances":"1",
                "resourceName":"LocBeacon",
            ]
        ]
        
        // url request properties
        let url = NSURL(string: urlAsString)
        let cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
        var err: NSError?
        
        // config request with timeout
        let urlRequest = NSMutableURLRequest(URL: url!, cachePolicy: cachePolicy, timeoutInterval: 15.0)
        urlRequest.HTTPMethod = httpMethod
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("Basic YWRtaW46YWRtaW4=", forHTTPHeaderField: "Authorization")
        urlRequest.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        
        // init queue
        let queue = NSOperationQueue()
        
        // create connection on a new thread for request
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: queue) { (reponse: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if data == nil{
                println("Do not receive any response")
                
            }else{
                // deserialize json object
                let json = JSON(data: data)
                println("json:\(json)")
                println("Setup LocBeacon Container.")
                println("\n-------------------------------\n")
            }
            //self.createLocCMXContainer()
            
        } // end url block
    }

    
    
}