//
//  Package.swift
//  SLChat
//
//  Created by Shial on 19/8/17.
//
//

import PackageDescription

let package = Package(
    name: "SLChat",
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Kitura-WebSocket", majorVersion: 0, minor: 9)
    ]
)
