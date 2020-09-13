//
//  AlbumModel.swift
//  iTunes Finder
//
//  Created by Александр Умаров on 13.09.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import Foundation

class Album {
    
    let artistName: String
    var artworkUrl100: String
    let collectionId: Int
    let collectionName: String
    let country: String
    let primaryGenreName: String
    let releaseDate: String
    
    init(artistName: String,
         artworkUrl100: String,
         collectionId: Int,
         collectionName: String,
         country: String,
         primaryGenreName: String,
         releaseDate: String) {
        self.artistName = artistName
        self.artworkUrl100 = artworkUrl100
        self.collectionId = collectionId
        self.collectionName = collectionName
        self.country = country
        self.primaryGenreName = primaryGenreName
        self.releaseDate = releaseDate
    }
}
