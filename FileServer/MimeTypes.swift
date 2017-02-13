//
//  HttpMimeTypes.swift
//  FileServer
//
//  Created by Jon Cardasis on 2/13/17.
//  Copyright © 2017 Jonathan Cardasis. All rights reserved.
//

import Foundation

/**
 HTTP MIME types
 */
public class MimeTypes {
    
    /**
     Returns HTTP MIME string type for an file extension key
     - Parameter key: File type extension string
     - Returns: HTTP MIME type used for the file type
    */
    class func get(key: String) -> String {
        
        let extensions = [
            //Audio
            "ua":"audio/basic",
            "aiff":"audio/x-aiff",
            "mid":"audio/x-midi",
            "midi":"audio/x-midi",
            "wav":"audio/x-wav",
            
            //Image
            "bmp":"image/bmp",
            "gif":"image/gif",
            "jpeg":"image/jpeg",
            "jpg":"image/jpeg",
            "jpe":"image/jpeg",
            "tiff":"image/tiff",
            "tif":"image/tiff",
            "xbm":"image/x-xbitmap",
            
            //Video
            "mpg":"video/mpeg",
            "mpeg":"video/mpeg",
            "mpe":"video/mpeg",
            "viv":"video/vnd.vivo",
            "vivo":"video/vnd.vivo",
            "qt":"video/quicktime",
            "mov":"video/quicktime",
            "avi":"video/x-msvideo",
            
            //Text
            "htm":"text/html",
            "html":"text/html",
            "text/plain":"txt",
            "rtf":"text/richtext",
            "rtx":"text/richtext",
            
            //Multipart
            "gzip":"multipart/x-gzip",
            "zip":"multipart/x-zip",
            
            //Application
            "doc":"application/msword",
            "exe":"application/octet-stream",
            "bin":"application/octet-stream",
            "pdf":"application/pdf",
            "gtar":"application/x-gtar",
            "gz":"application/x-gzip",
            "jar":"application/x-java-archive",
            "json":"application/json",
            "ser":"application/x-java-serialized-object",
            "class":"application/x-java-vm",
            "tar":"application/x-tar"
        ]
        
        if let value = extensions[key] {
            return value
        }
        else {
            // Return as a 8bit stream of data
            return "application/octet-stream"
        }
    }
}
