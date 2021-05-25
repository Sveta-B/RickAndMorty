//
//  CharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Света Брасс on 18.05.21.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell, NSUserActivityDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        indicator.startAnimating()
        imageView.contentMode = .scaleToFill
        contentView.layer.cornerRadius = 10
       
    }
}
