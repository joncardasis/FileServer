//
//  Response.swift
//  FileServer
//
//  Created by Jon Cardasis on 2/13/17.
//  Copyright © 2017 Jonathan Cardasis. All rights reserved.
//

import Foundation

public protocol HttpResponseProtocol {
    func generateResponseData(for method: HTTPMethod) -> Data
}


public class Response: HttpResponseProtocol {
    
    /// HTTP Response Status Code
    public var status: HTTPStatus = .ok
    
    /// HTTP headers which will be sent
    public var headers = [String:String]()
    
    /// HTTP response body
    public var body: Data?
    
    /// Body length (in number of bytes)
    public var bodyLength: Int {
        guard let b = body else {
            return 0
        }
        return b.count
    }
    
    /// Header Protocol String
    private let HTTP_VERSION: String = "HTTP/1.1"
    
    
    /**
     Sets Response object to redirect to the given URL string
     - Parameter redirectURL: Full string of the URL to redirect to
    */
    public func redirects(to redirectURL: String) {
        status = .found
        headers["Location"] = redirectURL
    }
    
    /**
     Sets status to the errorStatus code provided
    */
    public func setError(_ errorStatus: HTTPStatus) {
        status = errorStatus
    }
    
    /** 
     Sets Response body with contents of file and updates header for content-type
     - Parameter url: URL resource for the file to provide
     */
    public func setBody(forFile url: URL?) {
        enum FileError: Error { case foundNil }
        
        do {
            guard let url = url else {
                throw FileError.foundNil
            }
            
            let data = try Data(contentsOf: url)
            body = data
            headers["Content-Type"] = MimeTypes.get(key: url.pathExtension)
        }
        catch {
            //On error reading file data set http response status to error
            setError(.notFound)
        }
    }
    
    /**
     Creates formatted HTTP header data from the objects properties and returns as Data
     - Returns: Data representation of HTTP header information
     */
    private func generateHeaderData() -> Data {
        if headers["Content-Length"] == nil {
            headers["Content-Length"] = String(bodyLength)
        }
        
        let statusLine = "\(HTTP_VERSION) \(String(status.rawValue)) \(status.reasonPhrase())\r\n"
        var headersString = statusLine // Begin header string with status line
        
        for (key, value) in headers {
            headersString += "\(key): \(value)\r\n"
        }
        headersString += "\r\n"
        
        return headersString.data(using: .utf8) ?? Data()
    }
    
    /**
     - Returns: Header data and Body data if Body data exists and method is not HEAD
     */
    public func generateResponseData(for method: HTTPMethod) -> Data {
        let headerData = generateHeaderData()
        
        if let bodyData = body, method != .head {
            return headerData + bodyData
        }
        
        return headerData
    }
}
