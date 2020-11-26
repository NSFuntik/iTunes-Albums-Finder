//
//  SearchCollectionCell.swift
//  iTunesAPI
//
//  Created by Mikhailov on 25.11.2020.
//

import UIKit

class SearchCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageMask: UIView!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var albumArtistLabel: UILabel!
    
    func updateCell (album: AlbumModel) {
        let imageUrl = URL(string: album.artworkUrl100)
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageUrl!) {
                DispatchQueue.main.async {
                    self.albumImage.image = UIImage(data: imageData)
                }
            }
        }
        albumImage.applyshadowWithCorner(containerView: imageMask, cornerRadious: 10)
        albumTitleLabel.text = album.collectionName.uppercased()
        albumArtistLabel.text = album.artistName.uppercased()
    }
    
}

@IBDesignable
class RoundedImageView: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
}

extension UIImageView {
    func applyshadowWithCorner(containerView : UIView, cornerRadious : CGFloat) {
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.7
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = 5
        containerView.layer.cornerRadius = cornerRadious
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadious).cgPath
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
    }
}
