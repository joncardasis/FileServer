//
//  String+Socket.swift
//  FileServer
//
//  Created by Jon Cardasis on 2/12/17.
//  Copyright © 2017 Jonathan Cardasis. All rights reserved.
//
import Darwin

extension String {
    var byteLength: Int {
        return withCString { bytes in
            return Int(strlen(bytes))
        }
    }
}
