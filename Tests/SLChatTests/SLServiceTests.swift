//
//  testSLService.swift
//  SLChat
//
//  Created by Shial on 19/08/2017.
//
//

import XCTest
@testable import SLChat

class SLServiceTests: XCTestCase {
    static let allTests = [
        ("testSLService", testSLService)
    ]
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSLService() {
        struct Client: SLClient {}
        let chat = SLService<Client>()
        XCTAssertNotNil(chat)
    }
}
