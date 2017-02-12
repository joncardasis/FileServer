//
//  String+Socket.swift
//  FileServer
//
//  Created by Jon Cardasis on 2/12/17.
//  Copyright © 2017 Jonathan Cardasis. All rights reserved.
//
import Foundation

public extension String {
    public var byteLength: Int {
        return withCString { bytes in
            return Int(strlen(bytes))
        }
    }
    
    public static func from(_ chars: Array<CChar>) -> String {
        let byteData = chars.map({ UInt8($0) })
        return String(data: Data(bytes: byteData), encoding: .utf8) ?? ""
    }
    
    /*
     Returns the first string component up until a given Character
     - Parameter character: The character to read up until (exclusive)
     - Returns: String of self up until the provided Character
     */
    public func firstComponent(until character: Character) -> String {
        var newString = String()
        for char in self.characters {
            guard char != character else {
                break
            }
            newString.append(char)
        }
        return newString
    }
}
