//
//  CharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Света Брасс on 18.05.21.
//

import UIKit

protocol CharactersCollectionViewCellProtocol {
    var name: String { get }
    var image: String? { get }
    var status: String? { get }
    var gender: String { get }
    var species: String? { get }
    
}

class CharacterCollectionViewCell: UICollectionViewCell, NSUserActivityDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        imageView.contentMode = .scaleToFill
        contentView.layer.cornerRadius = 10
        nameLabel.numberOfLines = 0
        
    }
    
    
    func set(viewModel: CharactersCollectionViewCellProtocol) {
        nameLabel.text = viewModel.name
        if let stringForImage = viewModel.image {
            if let url = URL(string: stringForImage) {
                DispatchQueue.global(qos: .userInitiated).async {
                    
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data!)
                        self.indicator.stopAnimating()
                    }
                    
                }
            }
        }
    }
}
