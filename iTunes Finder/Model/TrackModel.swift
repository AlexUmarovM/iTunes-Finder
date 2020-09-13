//
//  TrackModel.swift
//  iTunes Finder
//
//  Created by Александр Умаров on 13.09.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import Foundation

class Track {
    
    var trackName: String
    var trackNumber: Int
    
    init(trackName: String, trackNumber: Int) {
        self.trackName = trackName
        self.trackNumber = trackNumber
    }
}
