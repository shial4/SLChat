//
//  testSLConnection.swift
//  SLChat
//
//  Created by Shial on 19/08/2017.
//
//

import XCTest
@testable import SLChat
@testable import KituraWebSocket
@testable import KituraNet
@testable import Socket

class testSLConnection: XCTestCase {
    static let allTests = [
        ("testSLConnection", testSLConnection)
    ]
    
    private var connection: SLConnections = SLConnections()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSLConnection() {
        connection.exertions({ connections in
            XCTAssertNotNil(connection)
        })
    }
    
    func testSLConnectionAdd() {
        let socket = try! Socket.create()
        let connectionInfo: SLConnection = ("client", WebSocketConnection(request: HTTPServerRequest(socket: socket, httpParser: nil)))
        connection.exertions({ connections in
            connections["id"] = connectionInfo
            XCTAssertNotNil(connections["id"])
        })
    }
    
    func testSLConnectionRemove() {
        testSLConnectionAdd()
        var connectionInfo: SLConnection?
        connection.exertions({ connections in
            connectionInfo = connections.removeValue(forKey: "id")
        })
        XCTAssertNotNil(connectionInfo)
    }
}
