//
//  DetailCharactersViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 16.06.21
//

import UIKit


class DetailCharactersViewController: UIViewController {
    
    @IBOutlet weak var avatarCharacter: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    
    
    var character: DetailCharacter?
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = character?.name
        
        nameLabel.text =  character?.name
        genderLabel.text = character?.gender
        statusLabel.text = character?.status
        speciesLabel.text = character?.species
        if let stringForImage = character?.image {
            if let url = URL(string: stringForImage) {
                if  let data = try? Data(contentsOf: url) {
                    avatarCharacter.image = UIImage(data: data)
                }
            }
        }
    }
}


