//
//  CollectionViewCell.swift
//  iTunes Finder
//
//  Created by Александр Умаров on 13.09.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import UIKit

class AlbumCell: UICollectionViewCell {
    @IBOutlet var albumImageView: UIImageView!
    @IBOutlet var albumTitleLabel: UILabel!
    @IBOutlet var albumArtistLabel: UILabel!
    
    func updateCell (album: Album) {
        let imageUrl = URL(string: album.artworkUrl100)
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageUrl!) {
                DispatchQueue.main.async {
                    self.albumImageView.image = UIImage(data: imageData)
                }
            }
        }
        
        albumTitleLabel.text = album.collectionName
        albumArtistLabel.text = album.artistName
    }
}
