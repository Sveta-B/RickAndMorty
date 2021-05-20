//
//  LocationsCollectionViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 20.05.21.
//

import UIKit

class LocationsCollectionViewController: ParentCollectionViewController {
let locations = ["Citadel of Ricks", "Rick Sanchez", "Earth", "Citadel of Ricks", "Rick Sanchez", "Earth", "Citadel of Ricks", "Rick Sanchez", "Earth", "Citadel of Ricks", "Rick Sanchez", "Earth", "Citadel of Ricks", "Rick Sanchez", "Earth", "Citadel of Ricks", "Rick Sanchez", "Earth", "Citadel of Ricks", "Rick Sanchez", "Earth", "Citadel of Ricks", "Rick Sanchez", "Earth", "Citadel of Ricks", "Rick Sanchez", "Earth"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Constants.ReuseIdentifier.CharactersCell.rawValue)

    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReuseIdentifier.CharactersCell.rawValue, for: indexPath) as! CharacterCollectionViewCell
        
        cell.nameLabel.text = locations[indexPath.item]
        cell.imageView.image = #imageLiteral(resourceName: "characters")
        return cell
    }

}
