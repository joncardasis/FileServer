//
//  Request.swift
//  FileServer
//
//  Created by Jon Cardasis on 2/13/17.
//  Copyright © 2017 Jonathan Cardasis. All rights reserved.
//

import Foundation


public class Request {
    
    
    public var headers = [String:String]()
    public var method: HTTPMethod = .undefined
    
    public var arguments = [String:String]() // ?name=jon -> arguments["name"]
    public var parameters = [String:String]() // x:password -> parameters["password"]
    
    public var body = [String:String]()
    
    private var httpVersion: String?
    
    
    init(headerData: Data) {
        
    }
    
    private func parseHeaderData(data: Data) {
        guard let stringRep = String(data: data, encoding: .utf8) else {
            return
        }
        let headerLines = stringRep.components(separatedBy: "\r\n") //Each line in the header
        
        let statusLineComponents = headerLines.first?.characters.split { $0 == " " }.map({ String($0) })
        
        
        
        
    }
    
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
