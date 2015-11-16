//
//  RecordedAudio.swift
//  Pitch Perfect
//

import Foundation

class RecordedAudio: NSObject {
    var filePathUrl: NSURL!
    var title:String!
    
    init(filePath: NSURL, title: String) {
        self.filePathUrl = filePath
        self.title = title
    }
}
