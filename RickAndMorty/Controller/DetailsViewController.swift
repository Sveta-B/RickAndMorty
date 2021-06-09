//
//  DetailsViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 23.05.21.
//

import UIKit

class DetailsViewController: UIViewController {

    var character: Character?
    

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Name"
        guard   let stringForImage = character?.image else {return}
        guard let url = URL(string: stringForImage) else {return}
        guard let data = try? Data(contentsOf: url) else {return}
        characterImage.image = UIImage(data: data)
        
        nameLabel.text = character?.name
        title = character?.name
        statusLabel.text = character?.status?.rawValue
        genderLabel.text = character?.gender?.rawValue
        speciesLabel.text = character?.species
        
    }
    
    

}
