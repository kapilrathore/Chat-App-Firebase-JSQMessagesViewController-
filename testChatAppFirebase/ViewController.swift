//
//  ViewController.swift
//  testChatAppFirebase
//
//  Created by Kapil Rathore on 25/05/16.
//  Copyright © 2016 Kapil Rathore. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var userField: UITextField!
    
    var username: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.tap(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    func tap(gesture: UITapGestureRecognizer) {
        userField.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginAuth(sender: AnyObject) {
        loginUser()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        let navVc = segue.destinationViewController as! UINavigationController
        let chatVc = navVc.viewControllers.first as! ChatViewController
        chatVc.senderId = username
        chatVc.senderDisplayName = username
    }
    
    func loginUser() {
        let username = userField.text
        if (username!.isEmpty) {
            displayAlertMessage("Please enter username!")
        } else {
            FIRAuth.auth()?.signInAnonymouslyWithCompletion() { (user, error) in
                if let error = error {
                    print("Signin Failed! \(error.localizedDescription)")
                } else {
                    print("Signed In with user \(user?.uid)")
                }
            }
            self.username = username!
            performSegueWithIdentifier("LoginToChat", sender: nil)
        }
    }
    
    func displayAlertMessage(msg: String) {
        let myAlert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
}

