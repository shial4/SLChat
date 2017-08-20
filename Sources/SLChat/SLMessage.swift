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
    
    init(_ command: Character) throws {
        switch command {
        case "B":
            self = .base64Message
        case "C":
            self = .connected
        case "D":
            self = .disconnected
        case "M":
            self = .textMessage
        case "R":
            self = .readMessage
        case "S":
            self = .stoppedTyping
        case "T":
            self = .startedTyping
        default:
            throw SLMessageError.unsupportedType
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
        guard let command = data.characters.first else { throw SLMessageError.unsupportedType }
        self.command = try SLMessageCommand(command)
        let payload = String(data.characters.dropFirst(2))
        guard let end = data.characters.index(of: "}") else { throw SLMessageError.notAcceptable }
        self.recipients = payload.substring(to: end).components(separatedBy: ";")
        self.content = payload.substring(from: end)
    }
    
    init(command: SLMessageCommand, recipients: [String]? = nil) {
        self.command = command
        self.content = ""
        self.recipients = recipients
    }
    
    func make(_ client: String) -> String {
        return [String(describing: command) + client + content].joined(separator: ";")
    }
}
