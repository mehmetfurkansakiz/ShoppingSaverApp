//
//  ListItem.swift
//  ShoppingSaverApp
//
//  Created by furkan sakız on 2.10.2024.
//

import Foundation
import RealmSwift

class ListItem: Object {
    @Persisted var itemID: Int64
    @Persisted var itemName: String
    @Persisted var itemCheck: Bool
    @Persisted var itemAmount: Double
}
