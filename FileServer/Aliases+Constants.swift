//
//  Aliases.swift
//  FileServer
//
//  Created by Jon Cardasis on 2/12/17.
//  Copyright © 2017 Jonathan Cardasis. All rights reserved.
//
import Darwin

/* Constants */
enum HTTP {
    static let packetSize = 1024
}

/* Darwin bindings */
public let socket_bind = Darwin.bind
public let socket_listen = Darwin.listen
public let socket_write = Darwin.write
public let socket_send = Darwin.send


/* Socket aliases for common types */
public typealias Port = UInt16
public typealias Descriptor = Int32
public typealias FileDescriptor = Int32



//public enum AddressFamily {
//    case ipv4
//    case ipv6
//    case any /// If any is specified the system will decide if IPv4 or IPv6 is applicable
//}

