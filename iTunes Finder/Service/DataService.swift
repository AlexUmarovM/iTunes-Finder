//
//  DataService.swift
//  iTunes Finder
//
//  Created by Александр Умаров on 13.09.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import Foundation

private let baseURL = Appearance.StringValues.baseURL
private let albumURL = Appearance.StringValues.albumURL

class DataService {
    
    static let instance = DataService()
    
    func getAlbums (searchRequest: String, complition: @escaping ([Album])->()) {
        var albums = [Album]()
        let searchString = searchRequest.replacingOccurrences(of: " ", with: "+")
        let url = URL(string: "\(baseURL)\(searchString)")
        let session = URLSession.shared
        session.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    if let albumsResults = json[Appearance.StringValues.results] as? NSArray {
                        for album in albumsResults {
                            if let albumInfo = album as? [String: AnyObject] {
                                guard let artistName = albumInfo[Appearance.StringValues.artistName] as? String else {return}
                                guard let artworkUrl100 = albumInfo[Appearance.StringValues.artworkUrl] as? String else {return}
                                guard let collectionId = albumInfo[Appearance.StringValues.collectionId] as? Int else {return}
                                guard let collectionName = albumInfo[Appearance.StringValues.collectionName] as? String else {return}
                                guard let country = albumInfo[Appearance.StringValues.country] as? String else {return}
                                guard let primaryGenreName = albumInfo[Appearance.StringValues.primaryGenreName] as? String else {return}
                                guard let releaseDate = albumInfo[Appearance.StringValues.releaseDate] as? String else {return}
                                let releaseDateFormatted = releaseDate.prefix(4)
                                let albumInstance = Album(artistName: artistName,
                                                          artworkUrl100: artworkUrl100,
                                                          collectionId: collectionId,
                                                          collectionName: collectionName,
                                                          country: country,
                                                          primaryGenreName: primaryGenreName,
                                                          releaseDate: String(releaseDateFormatted))
                                albums.append(albumInstance)
                            }
                        }
                        complition(albums)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            if error != nil {
                print(error!.localizedDescription)
            }
        }.resume()
    }
    
    func getAlbumTracks (collectionId: Int, complition: @escaping ([Track]) -> ()) {
        var tracks = [Track]()
        let url = URL(string: "\(albumURL)\(collectionId)")
        let session = URLSession.shared
        session.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    if let trackResults = json[Appearance.StringValues.results] as? NSArray {
                        for song in trackResults {
                            if trackResults.index(of: song) != 0 {
                                if let songInfo = song as? [String: AnyObject] {
                                    guard let trackName = songInfo[Appearance.StringValues.trackName] as? String else {return}
                                    guard let trackNumber = songInfo[Appearance.StringValues.trackNumber] as? Int else {return}
                                    let track = Track(trackName: trackName, trackNumber: trackNumber)
                                    tracks.append(track)
                                }
                            }
                        }
                        complition(tracks)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            if error != nil {
                print(error!.localizedDescription)
            }
        }.resume()
    }
    
}
