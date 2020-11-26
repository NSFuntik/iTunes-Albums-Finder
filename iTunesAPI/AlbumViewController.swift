//
//  AlbumViewController.swift
//  iTunesAPI
//
//  Created by Mikhailov on 25.11.2020.
//

import UIKit

class AlbumViewController: UIViewController {

    
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var imageMask: UIView!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var album: AlbumModel!
    var image: UIImage!
    var tracks = [Track]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
        updateLabels()
        loadTracks()
    }
    
    func updateLabels () {
        albumLabel.text = album.collectionName.uppercased()
        artistLabel.text = album.artistName.uppercased()
        genreLabel.text = album.primaryGenreName.uppercased()
        countryLabel.text = album.country.uppercased()
        yearLabel.text = album.releaseDate.uppercased()
        albumImage.image = image
        albumImage.applyshadowWithCorner(containerView: imageMask, cornerRadious: 10)
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

extension AlbumViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableCell", for: indexPath) as? TrackCell {
            cell.updateCell(track: tracks[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
}








