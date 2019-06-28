//
//  ViewController.swift
//  NottsTest
//
//  Created by Gask, Adam on 05/09/2018.
//  Copyright © 2018 Gask, Adam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Setup your view here
        self.view.accessibilityIdentifier = "LoginView"

        let greetingLabel = UILabel()
        greetingLabel.text = "Welcome"
        greetingLabel.textAlignment = .center
        greetingLabel.font = UIFont.boldSystemFont(ofSize: 20)
        greetingLabel.accessibilityIdentifier = "GreetingLabel"
        labelStackView.insertArrangedSubview(greetingLabel, at: 0)
        
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

        self.navigationController?.show(ShoppingListTableViewController(), sender: true)
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}

