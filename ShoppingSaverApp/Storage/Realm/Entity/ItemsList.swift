//
//  ItemsList.swift
//  ShoppingSaverApp
//
//  Created by furkan sakız on 2.10.2024.
//

import Foundation
import RealmSwift

class ItemsList: Object {
    @Persisted var listID: Int64
    @Persisted var listName: String
    @Persisted var listCheck: Bool
    @Persisted var listItem: List<ListItem>
}
