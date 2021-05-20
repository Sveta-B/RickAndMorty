//
//  CharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Света Брасс on 18.05.21.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    
        imageView.contentMode = .scaleToFill
        contentView.layer.cornerRadius = 10
       
    }
}
