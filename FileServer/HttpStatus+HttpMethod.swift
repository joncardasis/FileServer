//
//  HTTPContants.swift
//  FileServer
//
//  Created by Jon Cardasis on 2/13/17.
//  Copyright © 2017 Jonathan Cardasis. All rights reserved.
//

/**
 HTTP Method type for headers
*/
public enum HTTPMethod: String {
    case post   = "POST"
    case get    = "GET"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
    case head   = "HEAD"
    case undefined = ""
}


/** HTTP Response Status Codes based on RFC7231
    - Note: http://www.ietf.org/assignments/http-status-codes/http-status-codes.xml
 */
public enum HTTPStatus: UInt16 {
    case ok                  = 200
    case created             = 201
    case noContent           = 204
    case found               = 302
    case notModified         = 304
    case badRequest          = 400
    case unauthorized        = 401
    case forbidden           = 403
    case notFound            = 404
    case conflict            = 409
    case internalServerError = 500
    
    /**
     Returns: A String for the meaning of the status code
    */
    func reasonPhrase() -> String {
        switch self {
        case .ok:                   return "OK"
        case .created:              return "Created"
        case .noContent:            return "No Content"
        case .found:                return "Found"
        case .notModified:          return "Not Modified"
        case .badRequest:           return "Bad Request"
        case .unauthorized:         return "Unauthorized"
        case .forbidden:            return "Forbidden"
        case .notFound:             return "Not Found"
        case .conflict:             return "Conflict"
        case .internalServerError:  return "Interal Server Error"
        }
    }
    
    /**
     Returns: A pretty-print description of the status code for logging
    */
    func description() -> String {
        let statusCode = self.rawValue
        return "[\(statusCode)] \(reasonPhrase())"
    }
}
