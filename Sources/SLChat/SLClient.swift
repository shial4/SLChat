//
//  SLClient.swift
//  SLChat
//
//  Created by Shial on 19/8/17.
//
//

import Foundation
import KituraWebSocket

public protocol SLClient {
    static func receivedData(_ message: Data, from: WebSocketConnection) -> Bool
    static func sendMessage(_ message: SLMessage, from client: String)
    static func statusMessage(_ command: SLMessageCommand, from client: String) -> [String]?
}

extension SLClient {
    public static func receivedData(_ message: Data, from: WebSocketConnection) -> Bool { return false }
    public static func sendMessage(_ message: SLMessage, from client: String) { }
    public static func statusMessage(_ command: SLMessageCommand, from client: String) -> [String]? { return nil }
}
