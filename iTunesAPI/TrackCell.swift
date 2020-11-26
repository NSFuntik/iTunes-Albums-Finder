//
//  AlbumTableCell.swift
//  iTunesAPI
//
//  Created by Mikhailov on 25.11.2020.
//

import UIKit

class TrackCell: UITableViewCell {
    
    @IBOutlet weak var trackNumber: UILabel!
    @IBOutlet weak var trackName: UILabel!

    func updateCell (track: Track) {
        trackNumber.text = String(track.trackNumber)
        trackName.text = track.trackName
    }
    
}
