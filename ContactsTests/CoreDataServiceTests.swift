//
//  ContactsTests.swift
//  ContactsTests
//
//  Created by Macbook on 06.11.2022.
//

import XCTest
@testable import Contacts

final class CoreDataServiceTests: XCTestCase {
    
    // MARK: - Dependencies
    
    private var coreDataStack: CoreDataStackMock!
    
    private var coreDataService: CoreDataService!
    
    // MARK: - XCTestCase
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        coreDataStack = CoreDataStackMock()
        
        coreDataService = CoreDataService(coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        
        coreDataStack = nil
        
        coreDataService = nil
    }
    
    // MARK: - Tests
    
    func test_coreDataService_saveChannel() {
        // given
        let contact = Contact(name: "", phoneNumber: "", skills: [""])
        
        // when
        coreDataService.saveContacts(contacts: [contact])
        
        // then
        XCTAssertTrue(coreDataStack.invokedPerformSave)
        XCTAssertEqual(coreDataStack.invokedPerformSaveCount, 1)
    }
    
    func test_coreDataService_getChannels() {
        // when
        _ = coreDataService.getContacts()
        
        // then
        XCTAssertTrue(coreDataStack.invokedFetch)
        XCTAssertEqual(coreDataStack.invokedFetchCount, 1)
    }

}
