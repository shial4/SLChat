//
//  SLMessage.swift
//  SLChat
//
//  Created by Shial on 19/8/17.
//
//

import Foundation

public enum SLMessageCommand: Character {
    case base64Message = "B"
    case connected = "C"
    case disconnected = "D"
    case textMessage = "M"
    case readMessage = "R"
    case stoppedTyping = "S"
    case startedTyping = "T"
    
    func toAll() -> Bool {
        switch self {
        case .connected, .disconnected:
            return true
        default:
            return false
        }
    }
}

enum SLMessageError: Int, Error {
    case badRequest = 400
    case notAcceptable = 406
    case unsupportedType = 415
}

public struct SLMessage {
    public var command: SLMessageCommand
    public var content: String
    public var recipients: [String]?
    
    init(_ data: String) throws {
        guard data.characters.count > 1 else { throw SLMessageError.badRequest }
        guard let command = data.characters.first,
              let messageCommand = SLMessageCommand(rawValue: command) else { throw SLMessageError.unsupportedType }
        self.command = messageCommand
        let payload = String(data.characters.dropFirst(2))
        guard let end = payload.characters.index(of: "}") else { throw SLMessageError.notAcceptable }
        self.recipients = payload[..<end].components(separatedBy: ";")
        self.content = String(payload[payload.index(after: end)..<payload.endIndex])
    }
    
    init(command: SLMessageCommand, recipients: [String]? = nil) {
        self.command = command
        self.content = ""
        self.recipients = recipients
    }
    
    func make(_ client: String) -> String {
        let recipientString = command.toAll() ? "{}" : "{\(recipients?.joined(separator: ";") ?? "")}"
        return [String(describing: command),client,recipientString,content].joined(separator: ";")
    }
}
