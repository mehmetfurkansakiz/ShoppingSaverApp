//
//  RealmDatabase.swift
//  ShoppingSaverApp
//
//  Created by furkan sakız on 2.10.2024.
//

import RealmSwift

class RealmDatabase: LocalDatabaseProtocol {
    private var realm: Realm
    
    init(inMemoryIdentifier: String? = nil, objects: [Object.Type]? = nil) {
        let configuration = Realm.Configuration(inMemoryIdentifier: inMemoryIdentifier, deleteRealmIfMigrationNeeded: true, objectTypes: objects)
        guard let realm = try? Realm(configuration: configuration) else {
            fatalError("Realm could not be initialized")
        }
        self.realm = realm
    }
    
    func add<T: Object>(model: T) {
        try? realm.write {
            realm.add(model)
        }
    }
    
    func clearAll<T: Object>(model: T.Type) {
        try? realm.write {
            realm.deleteAll()
        }
    }
    
    func items<T: Object>() -> [T] {
        return realm.objects(T.self).map { $0 }
    }
    
    func delete<T: Object>(model: T) {
        try? realm.write {
            realm.delete(model)
        }
    }
    
    func deleteFromID<T: Object>(id: String, model: T.Type) {
        guard let objectId = try? ObjectId(string: id) else {
            return
        }
        
        let item = realm.objects(model.self).filter("id == %@", objectId)
        
        try? realm.write {
            realm.delete(item)
        }
    }
    
    func listenChanges<T: Object>(model: T.Type, result: @escaping (LocalDatabaseUpdate, [Int]) -> Void) {
        let results = realm.objects(model.self)
        
        let token = results.observe { changes in
            switch changes {
            case .initial:
                break
            case .update(_, let deletions, let insertions, let modifications):
                if !deletions.isEmpty {
                    return result(.delete, deletions)
                }
                if !insertions.isEmpty {
                    return result(.inserte, insertions)
                }
                if !modifications.isEmpty {
                    return result(.modify, modifications)
                }
            case .error(let error):
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}
