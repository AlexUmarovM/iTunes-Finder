//
//  DetailViewController.swift
//  iTunes Finder
//
//  Created by Александр Умаров on 13.09.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var albumLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var imageView: UIImageView!
    
    var album: Album!
    var image: UIImage!
    var tracks = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        updateLabels()
        loadTracks()
    }
    
    func updateLabels () {
        albumLabel.text = album.collectionName
        artistLabel.text = album.artistName
        genreLabel.text = album.primaryGenreName
        countryLabel.text = album.country
        yearLabel.text = album.releaseDate
        imageView.image = image
    }
    
    func loadTracks() {
        DataService.instance.getAlbumTracks(collectionId: album.collectionId) { (requestedTracks) in
            self.tracks = requestedTracks
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

// MARK: - TableView methods

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Appearance.StringValues.trackCell, for: indexPath) as? TrackCell {
            cell.updateCell(track: tracks[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
}
