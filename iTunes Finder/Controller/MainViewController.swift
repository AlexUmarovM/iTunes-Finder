//
//  ViewController.swift
//  iTunes Finder
//
//  Created by Александр Умаров on 13.09.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    lazy var searchBar: UISearchBar = UISearchBar()
    var albums = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        setupViews()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Appearance.StringValues.detailSegue {
            if let destinationVC = segue.destination as? DetailViewController {
                if let album = sender as? Album {
                    destinationVC.album = album
                    let index = albums.firstIndex(where: {$0 === album})
                    let indexPath = IndexPath(row: index!, section: 0)
                    if let cell = collectionView.cellForItem(at: indexPath) as? AlbumCell {
                        destinationVC.image = cell.albumImageView.image
                    }
                }
            }
        }
    }
    
    func setupViews() {
        searchBar.searchTextField.backgroundColor = .white
        searchBar.placeholder = Appearance.StringValues.searchBarPlaceholder
        searchBar.sizeToFit()
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.backgroundColor = .systemIndigo
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
}

// MARK: - CollectionView methods

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Appearance.StringValues.albumCell, for: indexPath) as? AlbumCell {
            cell.updateCell(album: albums[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = albums[indexPath.row]
        performSegue(withIdentifier: Appearance.StringValues.detailSegue, sender: album)
        searchBar.resignFirstResponder()
    }
    
}

// MARK: - SearchBar methods

extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != nil || searchBar.text != "" {
            DataService.instance.getAlbums(searchRequest: searchBar.text!) { (requestedAlbums) in
                self.albums = requestedAlbums.sorted(by: {$0.collectionName < $1.collectionName})
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        searchBar.resignFirstResponder()
    }
}

