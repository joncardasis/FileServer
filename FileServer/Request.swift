//
//  Request.swift
//  FileServer
//
//  Created by Jon Cardasis on 2/13/17.
//  Copyright © 2017 Jonathan Cardasis. All rights reserved.
//

import Foundation


public class Request {
    
    public var path: String = ""
    public var headers = [String:String]()
    public var method: HTTPMethod = .undefined
    
    public var arguments = [String:String]() // ?name=jon -> arguments["name"]
    public var parameters = [String:String]() // x:password -> parameters["password"]
    
    public var body = [String:String]()
    
    private var httpVersion: String?
    
    
    init(headerData: Data) {
        parseHeaderData(data: headerData)
    }
    
    ///MARK: has side effects
    private func parseHeaderData(data: Data) {
        guard let stringRep = String(data: data, encoding: .utf8) else {
            return
        }
        let headerLines = stringRep.components(separatedBy: "\r\n") //Each line in the header
        
        /* Read HTTP status line */
        let statusLineComponents = headerLines.first?.characters.split { $0 == " " }.map({ String($0) })
        
        if let method = statusLineComponents?[0] {
            self.method = HTTPMethod(rawValue: method)!
        }
        if let path = statusLineComponents?[1] {
            self.path = path
        }
        if let httpVersion = statusLineComponents?[2] {
            self.httpVersion = httpVersion
        }
        
        /* Read rest of HTTP header content */
        for line in headerLines[1..<headerLines.endIndex] {
            let kvArray = line.characters.split { $0 == ":" }.map({ String($0) })
            guard let key = kvArray.first, var value = kvArray.last else {
                continue
            }
            
            /* Remove space at beginning if it exists */
            if value.characters.count > 1 && value[value.startIndex] == " " {
                let index = value.index(after: value.startIndex)
                value = value[index..<value.endIndex]
            }
            
            body[key] = value
        }
        
        
        print(body)
    }
    
//    private func parseURLencodedForm() -> [String:String] {
//    
//    }
    
    
    
    public func supportsBodyData() -> Bool {
        switch method {
        case .post:
            return true
        case .put:
            return true
        case .patch:
            return true
            
        default:
            return false
        }
    }
    
    
    
    
}
