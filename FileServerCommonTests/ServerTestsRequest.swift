//
//  ServerTestsRequest.swift
//  FileServer
//
//  Created by Jon Cardasis on 2/13/17.
//  Copyright © 2017 Jonathan Cardasis. All rights reserved.
//

import Foundation
import XCTest
@testable import FileServer

class ServerTestsRequest: XCTestCase {

    func testParsingHeaderData() {
        let header = [
            "GET /images/coolImage.jpeg HTTP/1.1",
            "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36",
            "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
            "Accept-Encoding: gzip, deflate, sdch, br",
            "Accept-Language: en-US,en;q=0.8"
            ].joined(separator: "\r\n") + "\r\n"
        
        let headerData = header.data(using: .utf8)!
        let testRequest = Request(headerData: headerData)
        
        XCTAssertEqual(testRequest.method, .get)
        XCTAssertEqual(testRequest.path, "/images/coolImage.jpeg")
        
    }
    
    
}
