//
//  EpisodesCollectionViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 4.06.21.
//

import UIKit


class EpisodesCollectionViewController: ParentCollectionViewController {

    
    private var episodes: [Episode]?
    private var episodeData: EpisodeData?
    private let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episodes"
        collectionView.register(UINib(nibName: Constants.NibName.CustomCollectionViewCell.rawValue, bundle: nil), forCellWithReuseIdentifier: Constants.ReuseIdentifier.CustomCollectionViewCell.rawValue)
        networkManager.getData(nameSection: .episode, typeResult: episodeData, pageNumber: 1) { [weak self](result) in
            switch result {
            case .success(let data):
                self?.episodes = data?.results
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
        
   
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReuseIdentifier.CustomCollectionViewCell.rawValue, for: indexPath) as! CustomCollectionViewCell
        
        cell.typeSecondLabel.text = "Episode number"
        cell.typeThirdLabel.text = "Date"
        cell.typeFourthLabel.text = "Characters"
        if let episode = self.episodes?[indexPath.item] {
            cell.nameLabel.text = episode.name
            cell.secondLabel.text = episode.airDate
            cell.thirdLabel.text = episode.episode
            
        }
        return cell
    }


}
