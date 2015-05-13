//
//  LoginViewController.swift
//  ClosestBeacon
//
//  Created by Cangji Wu on 5/12/15.
//  Copyright (c) 2015 Cangji Wu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var signupTriangle: UIImageView!
    @IBOutlet weak var loginTriangle: UIImageView!
    
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBOutlet weak var enterButton: UIButton!
    
    var signUpActive = true
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        username.delegate = self
        password.delegate = self
        
        loginTriangle.alpha = 0
        enterButton.userInteractionEnabled = false
        
        self.makeUsernameBorder()
        self.makePasswordBorder()
        
    }

    
    // skip the login view of the user is the current the user
//    override func viewDidAppear(animated: Bool) {
//        // get current user cached on disk
//        var currentUser = PFUser.currentUser()
//        if currentUser != nil {
//            // go to table segue
//            self.performSegueWithIdentifier("showChooseBeacon", sender: self)
//        } else {
//            // wait for signup/login
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signupButtonToggled(sender: AnyObject) {
        if (signUpActive == false) {
            // disable signup mode
            signUpActive = true
            
            // change ui
            signupTriangle.alpha = 1
            loginTriangle.alpha = 0
        }
    }
    
    @IBAction func loginButtonToggled(sender: AnyObject) {
        if (signUpActive == true) {
            // disable signup mode
            signUpActive = false
            
            // change ui
            signupTriangle.alpha = 0
            loginTriangle.alpha = 1
        }
        
    }
    
    
    @IBAction func enterButtonSelected(sender: AnyObject) {
        // init error string
        var error = "";
        
        // check for empty email or password text fields
        if (username.text == "" || password.text == "") {
            error = "Please enter a username and password"
        }
            
            // check for minimum / maximum username string length
        else if (count(username.text) >= 11 || count(username.text) <= 2) {
            error = "Invalid username length. Must be 3 - 10 characters"
        }
            
            // check for minimum / maximum password string length
        else if (count(password.text) >= 21 || count(password.text) <= 3) {
            error = "Invalid password length. Must be 4 - 20 characters"
        }
        
        // if the error string is not empty
        if (error != "") {
            self.displayAlert("Error", error: error)
        }
            
        else {
            // create a new PFUser
            var user = PFUser()
            
            // set the user's name and password
            user.username = username.text
            user.password = password.text
            
            // inital activity indicator setup
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0.0, 0.0, 100, 100))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true;
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            
            // add to view and start animation
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            
            // begin ignoring user interaction
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            // check if sign up is active
            if (signUpActive == true) {
                // sign up in background
                
                user.signUpInBackgroundWithBlock {
                    (succeeded, signupError) -> Void in
                    if signupError == nil {
                        
                        // stop animation and end ignoring events
                        self.activityIndicator.stopAnimating()
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        
                        // now user can use app
                        NSLog("Signed Up.")
                        
                        // initializes all required containers for new user
                        SwiftPostman().createNewUserContainer()
                        
                        // go to table segue
                        self.performSegueWithIdentifier("showChooseBeacon", sender: self)
                        
                    } else {
                        
                        // stop animation and end ignoring events
                        self.activityIndicator.stopAnimating()
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        
                        // might be an error to display
                        if let errorString = signupError!.userInfo?["error"] as? NSString {
                            error = errorString as String
                        } else {
                            error = "Oops. Something went wrong."
                        }
                        
                        self.displayAlert("Could Not Sign Up", error: error)
                    }
                }
            }
                // if login is active
            else if (signUpActive == false) {
                
                PFUser.logInWithUsernameInBackground(username.text, password:password.text) {
                    (user, loginError) -> Void in
                    if loginError == nil {
                        
                        // stop animation and end ignoring events
                        self.activityIndicator.stopAnimating()
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        
                        // perform user table segue
                        self.performSegueWithIdentifier("showChooseBeacon", sender: self)
                        
                        NSLog("Logged In.")
                        
                    } else {
                        
                        // stop animation and end ignoring events
                        self.activityIndicator.stopAnimating()
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        
                        // might be an error to display
                        if let errorString = loginError!.userInfo?["error"] as? NSString {
                            error = errorString as String
                        } else {
                            error = "Oops. Something went wrong."
                        }
                        
                        self.displayAlert("Invalid Login", error: error)
                    }
                }
            }
        }

        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func makeUsernameBorder() {
        var eborder = CALayer()
        var width = CGFloat(0.3)
        eborder.borderColor = UIColor.lightGrayColor().CGColor
        eborder.frame = CGRect(x: 0, y: username.frame.size.height - width, width:  username.frame.size.width, height: username.frame.size.height)
        eborder.borderWidth = width
        username.layer.addSublayer(eborder)
    }
    
    func makePasswordBorder() {
        var pborder = CALayer()
        var width = CGFloat(0.3)
        pborder.borderColor = UIColor.lightGrayColor().CGColor
        pborder.frame = CGRect(x: 0, y: password.frame.size.height - width, width:  password.frame.size.width, height: password.frame.size.height)
        pborder.borderWidth = width
        password.layer.addSublayer(pborder)
    }
    
    
    // MARK: Text Field Functions
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        // end editing when touching view
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // show buttons
        enterButton.userInteractionEnabled = true
        enterButton.alpha = 1
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        if username.text == "" || password.text == "" {
            // hide buttons
            enterButton.userInteractionEnabled = false
            enterButton.alpha = 0
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        username.resignFirstResponder()
        password.resignFirstResponder()
        return true
    }
    
    // MARK: Alert Functions
    
    func displayAlert(title:String, error:String) {
        // display error alert
        var errortAlert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        errortAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { action in
            // close alert
        }))
        
        self.presentViewController(errortAlert, animated: true, completion: nil)
    }
    
}
