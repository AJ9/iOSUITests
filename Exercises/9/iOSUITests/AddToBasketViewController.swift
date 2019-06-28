//
//  AddToBasketViewController.swift
//  NottsTest
//
//  Created by Gask, Adam on 05/09/2018.
//  Copyright © 2018 Gask, Adam. All rights reserved.
//

import UIKit

class AddToBasketViewController: UIViewController {

    @IBOutlet weak var entryField: UITextField!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!

    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        stepper.maximumValue = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        valueLabel.text = Int(sender.value).description
    }

    @IBAction func add(_ sender: Any) {

        guard let name = entryField.text, !name.isEmpty else {
            return
        }

        guard let text = valueLabel.text, let count = Int(text) else {
            return
        }

        for i in 0..<count {

            let item = Item(name: name)
            ShoppingBasket.shared.items.append(item)
        }

        navigationController?.popViewController(animated: true)

    }

    @IBAction func minus(_ sender: Any) {
        guard stepper.value != stepper.minimumValue else {
            return
        }
        stepper.value -= 1
        valueLabel.text = "\(Int(stepper.value))"
    }

    @IBAction func plus(_ sender: Any) {
        guard stepper.value != stepper.maximumValue else {
            return
        }
        stepper.value += 1
        valueLabel.text = "\(Int(stepper.value))"
    }

}
