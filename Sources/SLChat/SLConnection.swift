//
//  SLConnections.swift
//  SLChat
//
//  Created by Shial on 19/8/17.
//
//

import Dispatch
import Foundation
import KituraWebSocket

typealias SLConnection = (client: String, connection: WebSocketConnection)
typealias SLClientConnections = [String: SLConnection]

class SLConnections {
    private let connectionsLock = DispatchSemaphore(value: 1)
    private var connections = SLClientConnections()
    
    private func lock() { _ = connectionsLock.wait(timeout: DispatchTime.distantFuture) }
    private func unlock() { connectionsLock.signal() }
    
    func exertions(_ operation: (_ connections: inout SLClientConnections)->()) {
        lock()
        operation(&connections)
        unlock()
    }
}
