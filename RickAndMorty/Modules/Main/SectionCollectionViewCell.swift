//
//  SectionCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Света Брасс on 17.05.21.
//

import UIKit

class SectionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageForSection: UIImageView!
    @IBOutlet weak var nameSectionLabel: UILabel!
   
    @IBOutlet weak var viewForImage: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageForSection.clipsToBounds = false
        imageForSection.contentMode = .scaleToFill
        viewForImage.layer.cornerRadius = 10
        viewForImage.layer.masksToBounds = true
    }
}
