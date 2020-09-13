//
//  Appearance.swift
//  iTunes Finder
//
//  Created by Александр Умаров on 13.09.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import Foundation
class Appearance {
    
    enum StringValues {
        
        //MARK: - Data Service
        static let baseURL = "https://itunes.apple.com/search?entity=album&attribute=albumTerm&offset=0&limit=100&term="
        static let albumURL = "https://itunes.apple.com/lookup?entity=song&id="
        static let results = "results"
        static let artistName = "artistName"
        static let artworkUrl = "artworkUrl100"
        static let collectionId = "collectionId"
        static let collectionName = "collectionName"
        static let country = "country"
        static let primaryGenreName = "primaryGenreName"
        static let releaseDate = "releaseDate"
        static let trackName = "trackName"
        static let trackNumber = "trackNumber"
        
        //MARK: - Identifiers
        static let detailSegue = "DetailSegue"
        static let albumCell = "AlbumCell"
        static let trackCell = "TrackCell"
        
        static let searchBarPlaceholder = "Type album Title"
    }
}
