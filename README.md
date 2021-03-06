# SLChat

<p align="center">
    <a href="http://swift.org">
        <img src="https://img.shields.io/badge/Swift-4.0-brightgreen.svg" alt="Language" />
    </a>
    <a href="https://raw.githubusercontent.com/shial4/SLChat/master/LICENSE">
        <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License" />
    </a>
    <a href="https://travis-ci.org/shial4/SLChat">
        <img src="https://travis-ci.org/shial4/SLChat.svg?branch=master" alt="TravisCI" />
    </a>
    <a href="https://codebeat.co/projects/github-com-shial4-slchat-master">
        <img src="https://codebeat.co/badges/bafbee05-9197-4625-84f8-1e022e3a6dad" alt="Codebeat" />
    </a>
</p>

SLChat is a simple extension for Kitura-WebSocket. Allows you to integrate chat system with your client.


## 🔧 Installation

Add the following dependency to your `Package.swift` file:
```swift
.package(url: "https://github.com/shial4/SLChat.git", from: "0.1.1"),
```

## 💊 Usage

### 1 Import

It's really easy to get started with the SLChat library! First you need to import the library, by adding this to the top of your Swift file:
```swift
import SLChat
```

### 2 Initialize

The easiest way to setup SLChat is to create object for example in your `main.swift` file. Like this:
```swift
let slChat = SLService<Client>()
```

Perfectly works with Kitura.
```swift
WebSocket.register(service: SLService<Client>(), onPath: "slchat")
```

### 3 Configure

`SLService` instance require your Client model. If you won't use it, you can simply declare an empty struct for that
```swift
struct Client: SLClient {}
let chat = SLService<Client>()
```

#### SLClient Protocol
Every function in this protocol is optional. It means `SLClient` provide default implementation. However, you are allowed to override it by your own. Why do that? To provide additional functionality. For example: data base storage for your message history, handle `Data` messages, provide recipients for status messages like connected or disconnected. And many more!
```swift
extension SLClient {
    static func receivedData(_ message: Data, from: WebSocketConnection) -> Bool { return false }
    static func sendMessage(_ message: SLMessage, from client: String) -> [String] { return message.recipients }
    static func statusMessage(_ command: SLMessageCommand, from client: String) -> [String]? { return nil }
}
```
Sending message via `sendMessage` protocol method. Provide `SLMessage` object which hold recipients parsed from socket message. This can be chat room ids or simple client ids to which message should be delivered.

Recipients are strings defined by you. Thanks to that you can identify your target clients to which message should be delivered. They can be simple other clients id or room id.

#### SLService

Is very simple in the way it works. First of all what you should know is:
Message sent to clinet looks like:
`M;MESSAGE-OWNER-ID;{MESSAGE-RECIPIENT-ID, CAN_BE_CHAT_ROOM_ID, CAN_BE_OTHER_CLIENT_ID};My message content sent to others`
First character in this case `M` is the type of message. Followed by client id responsible for sending this message with recipients placed inside `{}` and the last part is message content. All parts joined by `;`
This message model will be delivered to your client application.
``

Status messages (connected or disconnected) are different, they simply have empty recipient closure `{}`. If you receive message:
`C;MESSAGE-OWNER-ID;{};` Simply all clients related with message owner should be notify.

Beside receiving messages, you will send some as well!
Your message should look like:
`M{RECIPIENT_1;RECIPIENT_2;RECIPIENT_3}My message content sent to others`
Similar to recived message, first character describe type of message. Followed by recipients places inside `{}` separated by `;` with the last component is the message content.

To open socket conection from client register your WebSocket on:
`ws:// + host + /slchat?OWNER-ID`
SLChat uses path components to send owner id.

## ⭐ Contributing

Be welcome to contribute to this project! :)

## ❓ Questions

You can create an issue on GitHub.

## 📝 License

This project was released under the [MIT](LICENSE) license.
