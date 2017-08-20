# SLChat

<p align="center">
    <a href="http://swift.org">
        <img src="https://img.shields.io/badge/Swift-3.1-brightgreen.svg" alt="Language" />
    </a>
    <a href="https://raw.githubusercontent.com/shial4/SLChat/master/LICENSE">
        <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License" />
    </a>
    <a href="https://travis-ci.org/shial4/SLChat">
        <img src="https://travis-ci.org/shial4/SLChat.svg?branch=master" alt="TravisCI" />
    </a>
    <a href="https://codebeat.co/projects/github-com-shial4-slchat-master">
        <img alt="codebeat badge" src="https://codebeat.co/badges/bafbee05-9197-4625-84f8-1e022e3a6dad" /></a>

</p>

SLChat is a simple extension for Kitura-WebSocket. Allows you to integrate chat system with your client.


## 🔧 Installation

Add the following dependency to your `Package.swift` file:
```swift
.Package(url:"https://github.com/shial4/SLChat.git", majorVersion: 0, minor: 1)
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
    static func sendMessage(_ message: SLMessage, from client: String) { }
    static func statusMessage(_ command: SLMessageCommand, from client: String) -> [String]? { return nil }
}
```

#### SLService

Is very simple in the way it works. First of all what you should know is:
Message sent to clinet looks like:
`M;MESSAGE-OWNER-ID;My message content sent to others`
First character in this case `M` is the type of message. Followed by client id responsible for sending this message and the last part is message content. All parts joined by `;`
This message model will be delivered to your client application.

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
