//
//  SocketError.swift
//  FileServer
//
//  Created by Jon Cardasis on 2/12/17.
//  Copyright © 2017 Jonathan Cardasis. All rights reserved.
//

import Darwin

public enum ErrorReason {
    case bindFailed
    case listenFailed
    
    case generic(String)
}

public struct SocketError: Error {
    public let type: ErrorReason
    public let errorCode: Int32
    
    init(_ type: ErrorReason) {
        self.type = type
        self.errorCode = errno // Last reported error code by the kernal
    }
    
    init(message: String) {
        self.type = .generic(message)
        self.errorCode = -1
    }
    
    /// Returns a String for the kernal's meaning for the errorCode
    private func getOSReason() -> String {
        return String(validatingUTF8: strerror(errorCode)) ?? "?"
    }
    
    public var description: String {
        return "Socket failed with code \(errorCode): \"\(getOSReason())\" [\(type)]"
    }
}
