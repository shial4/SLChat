//
//  testSLClient.swift
//  SLChat
//
//  Created by Shial on 19/08/2017.
//
//

import XCTest
@testable import SLChat

class testSLClient: XCTestCase {
    static let allTests = [
        ("testSLClient", testSLClient),
        ("testSLClientProtocol", testSLClientProtocol)
    ]
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSLClient() {
        struct Client: SLClient {}
        let cl = Client()
        XCTAssertNotNil(cl)
    }
    
    func testSLClientSendMessage() {
        struct Client: SLClient {
            static var handler: Bool = false
            
            static func sendMessage(_ message: SLMessage, from client: String) {
                handler = true
            }
        }
        Client.sendMessage(SLMessage(command: .connected), from: "")
        XCTAssert(Client.handler)
    }
    
    func testSLClientStatusMessageDefault() {
        struct Client: SLClient {}
        XCTAssertNil(Client.statusMessage(.disconnected, from: ""))
    }
    
    func testSLClientStatusMessage() {
        struct Client: SLClient {
            static func statusMessage(_ command: SLMessageCommand, from client: String) -> [String]? { return [] }
        }
        XCTAssertNotNil(Client.statusMessage(.disconnected, from: ""))
    }
    
    func testSLClientProtocol() {
        struct Client: SLClient {
            static func sendMessage(_ message: SLMessage, from client: String) { }
            static func statusMessage(_ command: SLMessageCommand, from client: String) -> [String]? { return nil }
        }
        let cl = Client()
        XCTAssertNotNil(cl)
    }
    
    func testSLClientStatus() {
        struct Client: SLClient {
            static func statusMessage(_ command: SLMessageCommand, from client: String) -> [String]? { return nil }
        }
        let cl = Client()
        XCTAssertNotNil(cl)
    }
    
    func testSLClientMessage() {
        struct Client: SLClient {
            static func sendMessage(_ message: SLMessage, from client: String) { }
        }
        let cl = Client()
        XCTAssertNotNil(cl)
    }
}
