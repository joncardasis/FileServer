//
//  main.swift
//  FileServer
//
//  Created by Jon Cardasis on 2/12/17.
//  Copyright © 2017 Jonathan Cardasis. All rights reserved.
//

import Darwin
import Foundation

fileprivate func sockaddr_cast(_ p: UnsafeMutableRawPointer) -> UnsafeMutablePointer<sockaddr> {
    return UnsafeMutablePointer<sockaddr>(OpaquePointer(p))
}

fileprivate func htons(_ value: CUnsignedShort) -> CUnsignedShort {
    return (value << 8) + (value >> 8)
}


func bind(sock: FileDescriptor, port: Port) throws {
    let socklen = UInt8(MemoryLayout<sockaddr_in>.size)
    
    var serveraddr = sockaddr_in()
    serveraddr.sin_family = sa_family_t(AF_INET)
    serveraddr.sin_port = in_port_t(htons(in_port_t(port)))
    serveraddr.sin_addr = in_addr(s_addr: INADDR_ANY)
    
    let res = socket_bind(sock, sockaddr_cast(&serveraddr), socklen_t(socklen))
    guard res > -1 else {
        throw SocketError(.bindFailed)
    }
}

func listen(sock: FileDescriptor, numConnections: Int32 = 5) throws {
    let res = socket_listen(sock, numConnections)
    guard res > -1 else {
        throw SocketError(.listenFailed)
    }
}

func sendMessage(to client: FileDescriptor, _ message: String) {
    _ = message.withCString { bytes in
        socket_send(client, bytes, Int(strlen(bytes)), 0)
    }
}

func sendDataPacket(to client: FileDescriptor, _ data: [UInt8]) {
    _ = socket_send(client, data, data.count, 0)
}



func fileRequested(_ filename: String/*,in directory: URL*/) throws -> [UInt8] {
    guard let filepath = Bundle.main.url(forResource: "index", withExtension: "html") else {
        throw FileHandlerError.fileNotFound
    }
    
    do {
        let data = try Data(contentsOf: filepath)
        var byteBuffer = [UInt8](repeating: 0, count: data.count)
        data.copyBytes(to: &byteBuffer, count: data.count)
        return byteBuffer
    }
    catch {
        throw FileHandlerError.failedToReadData
    }
}


/****** MAIN ******/
let sock_stream = SOCK_STREAM // Set to Stream for HTTP
let sock = socket(AF_INET, Int32(sock_stream), 0)
let portNumber: Port = 8080


do {
    try bind(sock: sock, port: portNumber)
    try listen(sock: sock, numConnections: 5)
    print("Listening on port \(portNumber)...")
}
catch let e as SocketError {
    print(e.description)
}



let html = "<html><body><center><h1>Hello Swift!</h1></center></body></html>"

repeat {
    let clientSocket = accept(sock, nil, nil)
    
    // Get data packet from the client
//    let messageBuffer = Array<UInt8>(repeating: 0, count: HTTP.packetSize)
//    var bytesRead = 0
//    while(bytesRead < HTTP.packetSize) {
//        let dataLength = recv(clientSocket, UnsafeMutablePointer<UInt8>(OpaquePointer(messageBuffer)), HTTP.packetSize - bytesRead, 0) //TODO: should be a try
//        if dataLength < 0 {
//            print("ERROR recieving all packet data. Closing socket...")
//            close(clientSocket)
//            break
//        }
//        
//        bytesRead += dataLength
//    }
    
    
    let htmlData = try! fileRequested("doesnt matter here since its hard coded for now")
    
    
    let lineBreak = "\r\n"
    let headers = [
        "HTTP/1.1 200 OK",
        "Content-Type: text/html; charset=UTF-8",
        "Server: Swifty Web Server",
        "Content-length: \(htmlData.count)",
        "Connection: close"
        ].joined(separator: lineBreak) + lineBreak + lineBreak
    
    print("Headers to Serve:\n\(headers)")
    sendMessage(to: clientSocket, headers)
    //sendMessage(to: clientSocket, html)
    sendDataPacket(to: clientSocket, htmlData)
    
    close(clientSocket)
} while(sock >= 0)






