//
//  EpisodesCollectionViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 4.06.21.
//

import UIKit

protocol EpisodesCollectionViewProtocol: class {
    func displayData(data: [Episode] )
    
}

class EpisodesCollectionViewController: ParentCollectionViewController, EpisodesCollectionViewProtocol {
    
    weak var interactor: EpisodesInteractorProtocol?
    private var episodesToDisplay: [Episode]?
    
    
//    
//   override init(nibName: String?, bundle: Bundle?) {
//    super.init(nibName: nibName, bundle: bundle )
//
//    setUp()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        
//        setUp()
//    }
    
     func setUp() {
      let viewController = self
      let  interactor = EpisodesInteractor()
      let presenter = EpisodesPresenter(viewController: viewController)
      interactor.presenter = presenter
      viewController.interactor = interactor
      
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        interactor?.fetchEpisodes()
        title = "Episodes"
        collectionView.register(UINib(nibName: Constants.NibName.CustomCollectionViewCell.rawValue, bundle: nil), forCellWithReuseIdentifier: Constants.ReuseIdentifier.CustomCollectionViewCell.rawValue)
        
    }
    
    
    
    func displayData(data: [Episode]) {
        
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
       
        if let episode = self.episodesToDisplay?[indexPath.item] {
            cell.nameLabel.text = episode.name
            cell.secondLabel.text = episode.airDate
            cell.thirdLabel.text = episode.episode
            
        }
        
        return cell
    }
  
}
