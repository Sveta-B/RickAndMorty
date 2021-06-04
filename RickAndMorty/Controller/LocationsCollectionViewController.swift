//
//  LocationsCollectionViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 20.05.21.
//

import UIKit

class LocationsCollectionViewController: ParentCollectionViewController {
    private var countRows: Int?
    var locations: [Location]?
    var locationData: LocationData?
    private let networkManager = NetworkManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Locations"
        networkManager.getData(nameSection: .location, typeResult: locationData, pageNumber: 1) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.locations = data?.results
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
        collectionView.register(UINib(nibName:
                                      Constants.NibName.CustomCollectionViewCell.rawValue,
                                      bundle: nil),
                                      forCellWithReuseIdentifier:
                                      Constants.ReuseIdentifier.CustomCollectionViewCell.rawValue)

    }

    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = countRows else { return 20 }
      return count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReuseIdentifier.CustomCollectionViewCell.rawValue, for: indexPath) as! CustomCollectionViewCell
        
       
        if let location = self.locations?[indexPath.item] {
                cell.nameLabel.text = location.name
            cell.secondLabel.text = location.dimension
            cell.thirdLabel.text = location.type
               
        }
        return cell
    }
}
