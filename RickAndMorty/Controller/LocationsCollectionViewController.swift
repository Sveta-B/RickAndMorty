//
//  LocationsCollectionViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 20.05.21.
//

import UIKit

class LocationsCollectionViewController: ParentCollectionViewController {
    var locations = ["", "", ""]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Constants.ReuseIdentifier.CharactersCell.rawValue)

    }

   
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReuseIdentifier.CharactersCell.rawValue, for: indexPath) as! CharacterCollectionViewCell
        cell.nameLabel.text = locations[indexPath.item]
        cell.imageView.image = #imageLiteral(resourceName: "characters")
        return cell
    }

}
