//
//  ShoppingBasket.swift
//  NottsTest
//
//  Created by Gask, Adam on 05/09/2018.
//  Copyright © 2018 Gask, Adam. All rights reserved.
//

import Foundation

struct Item {
    let name: String
}

class ShoppingBasket {
    var items: [Item] = [Item(name: "Apple"), Item(name: "Orange"), Item(name: "Kiwi")]
    static let shared: ShoppingBasket = ShoppingBasket()
}
