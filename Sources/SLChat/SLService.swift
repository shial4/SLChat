//
//  SLService.swift
//  SLChat
//
//  Created by Shial on 19/8/17.
//
//

import Foundation
import KituraWebSocket

public class SLService<T: SLClient>: WebSocketService {
    private var connection: SLConnections = SLConnections()
    
    public init() {}
    
    public func connected(connection: WebSocketConnection) {
        guard let clientId = connection.request.urlURL.query else {
            inconsonantClient(from: connection, description: "Missing client id")
            return;
        }
        connectClient(from: connection, client: clientId)
    }
    
    public func disconnected(connection: WebSocketConnection, reason: WebSocketCloseReasonCode) {
        disconnectClient(from: connection)
    }
    
    public func received(message: Data, from: WebSocketConnection) {
        guard T.receivedData(message, from: from) else {
            inconsonantClient(from: from, description: "Data not supoerted")
            return
        }
    }
    
    public func received(message: String, from: WebSocketConnection) {
        do {
            let message = try SLMessage(message)
            guard let clientId = from.request.urlURL.query else {
                inconsonantClient(from: from, description: "Missing client id")
                return
            }
            broadcast(from: clientId, message: message)
        } catch SLMessageError.badRequest {
            inconsonantClient(from: from, description: "Bad data")
        } catch SLMessageError.unsupportedType {
            inconsonantClient(from: from, description: "Unexpected Data")
        } catch SLMessageError.notAcceptable {
            inconsonantClient(from: from, description: "Corrupted Data")
        } catch let error {
            inconsonantClient(from: from, description: "Something went wrong, error: \(error)")
        }
        
    }
    
    private func connectClient(from: WebSocketConnection, client: String) {
        connection.exertions({ connections in
            connections[from.id] = (client, from)
        })
        if let recipients = T.statusMessage(.connected, from: client) {
            broadcast(from: client, message: SLMessage(command: .connected, recipients: recipients))
        }
    }
    
    private func disconnectClient(from: WebSocketConnection) {
        var connectionInfo: SLConnection?
        connection.exertions({ connections in
            connectionInfo = connections.removeValue(forKey: from.id)
        })
        guard let info = connectionInfo else { return }
        if let recipients = T.statusMessage(.disconnected, from: info.client) {
            broadcast(from: info.client, message: SLMessage(command: .disconnected, recipients: recipients))
        }
    }
    
    private func inconsonantClient(from: WebSocketConnection, description: String) {
        from.close(reason: .invalidDataContents, description: description)
        disconnectClient(from: from)
    }
    
    private func broadcast(from client: String, message: SLMessage) {
        if message.command == .base64Message || message.command == .textMessage {
            let recipients = T.sendMessage(message, from: client)
            connection.exertions({ connections in
                for (_, (client: clienId, connection: connection)) in connections where recipients.contains(clienId) {
                    connection.send(message: message.make(client))
                }
            })
        }
    }
}
