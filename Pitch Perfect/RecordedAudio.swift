//
//  RecordedAudio.swift
//  Pitch Perfect
//

import Foundation

class RecordedAudio: NSObject {
    var filePathUrl: NSURL!
    var title:String!
    
    //No argument constructor
    override init() {
        super.init()
    }
    
    //Constructor
    init(filePath: NSURL, title: String) {
        super.init()
        self.filePathUrl = filePath
        self.title = title
    }
}
