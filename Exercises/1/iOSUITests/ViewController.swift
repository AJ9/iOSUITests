//
//  ViewController.swift
//  NottsTest
//
//  Created by Gask, Adam on 05/09/2018.
//  Copyright © 2018 Gask, Adam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func signIn(_ sender: Any) {

        guard emailAddressField?.text == "user@example.com" else {
            showAlert(title: "Something went wrong!", message: "Invalid Email")
            return
        }

        guard passwordField?.text == "password" else {
            showAlert(title: "Something went wrong!", message: "Invalid Password")
            return
        }

        showAlert(title: "Logged In", message: "You are now Logged In")
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}

