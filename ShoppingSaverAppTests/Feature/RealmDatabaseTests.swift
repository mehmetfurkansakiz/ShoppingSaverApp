//
//  RealmDatabaseTests.swift
//  ShoppingSaverAppTests
//
//  Created by furkan sakız on 2.10.2024.
//

import RealmSwift
@testable import ShoppingSaverApp
import XCTest

internal class TestObject: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String = ""

    var idValue: String {
        /// id lazım olduğu zaman string olarak alıyoruz
        return id.stringValue
    }
}

final class RealmDatabaseTests: XCTestCase {
    var realmDatabase: RealmDatabase!

    override func setUp() {
        super.setUp()
        realmDatabase = RealmDatabase(
            inMemoryIdentifier: "TestableRealm",
            objects: [TestObject.self])
    }

    func testAddItem() {
        let testObject = TestObject()
        testObject.name = "Test Name"
        realmDatabase.add(model: testObject)
        let items = realmDatabase.items<TestObject>() as [TestObject]
        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(items.first?.name, "Test Name")
    }
    
    func testDeleteItem() {
        let testObject = TestObject()
        testObject.name = "Test Name"
        realmDatabase.add(model: testObject)
        var items = realmDatabase.items<TestObject>() as [TestObject]
        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(items.first?.name, "Test Name")
        
        realmDatabase.delete(model: testObject)
        items = realmDatabase.items<TestObject>() as [TestObject]
        XCTAssertEqual(items.count, 0)
    }
    
    func testClearAll() {
        let testObject = TestObject()
        testObject.name = "Test Name"
        realmDatabase.add(model: testObject)
        var items = realmDatabase.items<TestObject>() as [TestObject]
        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(items.first?.name, "Test Name")
        
        realmDatabase.clearAll(model: TestObject.self)
        items = realmDatabase.items<TestObject>() as [TestObject]
        XCTAssertEqual(items.count, 0)
    }
    
    func testDeleteFromID() {
        let testObject = TestObject()
        testObject.name = "Test Name"
        realmDatabase.add(model: testObject)
        var items = realmDatabase.items<TestObject>() as [TestObject]
        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(items.first?.name, "Test Name")
        
        realmDatabase.deleteFromID(id: items.first!.idValue, model: TestObject.self)
        items = realmDatabase.items<TestObject>() as [TestObject]
        XCTAssertEqual(items.count, 0)
    }
}
