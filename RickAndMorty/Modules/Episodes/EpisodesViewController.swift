//
//  EpisodesViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 15.06.21.
//

import UIKit

protocol EpisodesDisplayLogic: class {
  func displayData(viewModel: Episodes.Model.ViewModel.ViewModelData)
}

class EpisodesViewController: ParentCollectionViewController, EpisodesDisplayLogic, CellDelegate {
    
    // MARK: Properties
  
    private var interactor: (EpisodesBusinessLogic& URLStoreProtocol)?
    var router: ( EpisodesRoutingLogic & URLPassingProtocol)?
    var episodes = EpisodesModel.init(cells: [])

    // MARK: Initialization
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        
    }
  
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = EpisodesInteractor()
    let presenter             = EpisodesPresenter()
    let router                = EpisodesRouter()
    let networkManager        = NetworkManager()
    interactor.networkManager = networkManager
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
    router.urlStore = interactor
  }
  
  // MARK: Routing
    
    func didShowCharacters(characters: [String]?) {
        router?.navigateCharacters(characters: characters ?? [])
    }

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Episodes"
    
    interactor?.makeRequest(request: .getEpisodes)
    collectionView.register(UINib(nibName:
                                  Constants.NibName.CustomCollectionViewCell.rawValue,
                                  bundle: nil),
                                  forCellWithReuseIdentifier:
                                  Constants.ReuseIdentifier.CustomCollectionViewCell.rawValue)
  }

    // MARK: LocationsDisplayLogic
  func displayData(viewModel: Episodes.Model.ViewModel.ViewModelData) {
    switch viewModel {
    case .displayEpisodes(episodeModel: let episodeModel):
        episodes = episodeModel
        collectionView.reloadData()
        
    }
  }
    // MARK: DidEndDragging
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView.contentOffset.y > scrollView.contentSize.height / 1.4 {
            interactor?.makeRequest(request: .getMoreEpisodes)
    }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return episodes.cells.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReuseIdentifier.CustomCollectionViewCell.rawValue, for: indexPath) as! CustomCollectionViewCell
        let episode = episodes.cells[indexPath.item]
        cell.setEpisodes(viewModel: episode)
        cell.typeSecondLabel.text = "Number"
        cell.typeThirdLabel.text = "Date"
        cell.typeFourthLabel.text = "Characters"
        cell.delegate = self
        return cell
    }
}
