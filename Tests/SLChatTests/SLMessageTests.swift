//
//  testSLMessage.swift
//  SLChat
//
//  Created by Shial on 19/08/2017.
//
//

import XCTest
@testable import SLChat

class SLMessageTests: XCTestCase {
    static let allTests = [
        ("testSLMessage", testSLMessage),
        ("testSLMessageBadRequest", testSLMessageBadRequest),
        ("testSLMessageNotAcceptable", testSLMessageNotAcceptable),
        ("testSLMessageUnsupportedType", testSLMessageUnsupportedType),
        ("testSLMessageBase64", testSLMessageBase64),
        ("testSLMessageConnected", testSLMessageConnected),
        ("testSLMessageDisconnected", testSLMessageDisconnected),
        ("testSLMessageTextMessage", testSLMessageTextMessage),
        ("testSLMessageReadMessage", testSLMessageReadMessage),
        ("testSLMessageStoppedTyping", testSLMessageStoppedTyping),
        ("testSLMessageStart", testSLMessageStart),
        ("testSLMessageRecipients", testSLMessageRecipients),
        ("testSLMessageContent", testSLMessageContent),
        ("testSLMessageEmptyContent", testSLMessageEmptyContent)
    ]
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSLMessage() {
        do {
            let message = try SLMessage("C{A;B;C}Message")
            XCTAssertNotNil(message)
        } catch {
            XCTFail()
        }
    }
    
    func testSLMessageBadRequest() {
        do {
            let _ = try SLMessage("")
            XCTFail()
        } catch SLMessageError.badRequest {
            XCTAssert(true)
        } catch {
            XCTFail()
        }
    }
    
    func testSLMessageNotAcceptable() {
        do {
            let _ = try SLMessage("C{A;B;CMessage")
            XCTFail()
        } catch SLMessageError.notAcceptable {
            XCTAssert(true)
        }catch {
            XCTFail()
        }
    }
    
    func testSLMessageUnsupportedType() {
        do {
            let _ = try SLMessage("A{A;B;C}Message")
            XCTFail()
        } catch SLMessageError.unsupportedType {
            XCTAssert(true)
        } catch {
            XCTFail()
        }
    }
    
    func testSLMessageBase64() {
        do {
            let message = try SLMessage("B{A;B;C}Message")
            XCTAssertTrue(message.command == .base64Message)
        } catch {
            XCTFail()
        }
    }
    
    func testSLMessageConnected() {
        do {
            let message = try SLMessage("C{A;B;C}Message")
            XCTAssertTrue(message.command == .connected)
        } catch {
            XCTFail()
        }
    }
    
    func testSLMessageDisconnected() {
        do {
            let message = try SLMessage("D{A;B;C}Message")
            XCTAssertTrue(message.command == .disconnected)
        } catch {
            XCTFail()
        }
    }
    
    func testSLMessageTextMessage() {
        do {
            let message = try SLMessage("M{A;B;C}Message")
            XCTAssertTrue(message.command == .textMessage)
        } catch {
            XCTFail()
        }
    }
    
    func testSLMessageReadMessage() {
        do {
            let message = try SLMessage("R{A;B;C}Message")
            XCTAssertTrue(message.command == .readMessage)
        } catch {
            XCTFail()
        }
    }
    
    func testSLMessageStoppedTyping() {
        do {
            let message = try SLMessage("S{A;B;C}Message")
            XCTAssertTrue(message.command == .stoppedTyping)
        } catch {
            XCTFail()
        }
    }
    
    func testSLMessageStart() {
        do {
            let message = try SLMessage("T{A;B;C}Message")
            XCTAssertTrue(message.command == .startedTyping)
        } catch {
            XCTFail()
        }
    }
    
    func testSLMessageRecipients() {
        do {
            let message = try SLMessage("M{A;B;C}Message")
            guard let recipients = message.recipients else {
                XCTFail()
                return
            }
            for rec in recipients {
                print(rec)
                XCTAssertTrue(["A","B","C"].contains(rec))
            }
        } catch {
            XCTFail()
        }
    }
    
    func testSLMessageContent() {
        do {
            let message = try SLMessage("M{A;B;C}Message")
            XCTAssertTrue(message.content == "Message")
        } catch {
            XCTFail()
        }
    }
    
    func testSLMessageEmptyContent() {
        do {
            let message = try SLMessage("M{A;B;C}")
            XCTAssertTrue(message.content == "")
        } catch {
            XCTFail()
        }
    }
}
