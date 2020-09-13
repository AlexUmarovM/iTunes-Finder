//
//  TrackCell.swift
//  iTunes Finder
//
//  Created by Александр Умаров on 13.09.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import UIKit

class TrackCell: UITableViewCell {
    
    @IBOutlet var trackName: UILabel!
    @IBOutlet var trackNumber: UILabel!
    
    func updateCell (track: Track) {
        trackNumber.text = String(track.trackNumber)
        trackName.text = track.trackName
    }
}
