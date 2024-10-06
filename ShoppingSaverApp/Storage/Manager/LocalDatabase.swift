//
//  LocalDatabase.swift
//  ShoppingSaverApp
//
//  Created by furkan sakız on 2.10.2024.
//

import RealmSwift

protocol LocalDatabaseProtocol {
    func add<T: Object>(model: T)
    func clearAll<T: Object>(model: T.Type)
    func items<T: Object>() -> [T]
    func delete<T: Object>(model: T)
    func deleteFromID<T: Object>(id: String, model: T.Type)
    
    func listenChanges<T: Object>(model: T.Type, result: @escaping (LocalDatabaseUpdate, [Int]) -> Void)
}

enum LocalDatabaseUpdate {
    case delete
    case inserte
    case modify
}
