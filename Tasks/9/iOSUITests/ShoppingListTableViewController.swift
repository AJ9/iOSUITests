//
//  ShoppingListTableViewController.swift
//  NottsTest
//
//  Created by Gask, Adam on 05/09/2018.
//  Copyright © 2018 Gask, Adam. All rights reserved.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Shopping Basket"
        self.navigationItem.setHidesBackButton(true, animated: false);

        tableView.accessibilityIdentifier = "ShoppingListTableView"

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuse")
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))

        addButton.accessibilityIdentifier = "AddButton"

        navigationItem.rightBarButtonItem = addButton
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    @objc func addTapped(sender: UIBarButtonItem) {
self.navigationController?.show(AddToBasketViewController(), sender: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShoppingBasket.shared.items.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuse", for: indexPath)

        // Configure the cell...
        let item = ShoppingBasket.shared.items[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let goToPub = ShoppingBasket.shared.items[indexPath.row].name == "Beer"
            ShoppingBasket.shared.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)

            if goToPub {
                let alert = UIAlertController(title: "Shall we go to the pub?", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
}
