//
//  FileHandlerError.swift
//  FileServer
//
//  Created by Jon Cardasis on 2/12/17.
//  Copyright © 2017 Jonathan Cardasis. All rights reserved.
//

import Foundation

public enum FileHandlerError: Error {
    case fileNotFound
    case failedToReadData
}
