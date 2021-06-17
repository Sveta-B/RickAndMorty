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

class EpisodesViewController: ParentCollectionViewController, EpisodesDisplayLogic {
  
    private var interactor: EpisodesBusinessLogic?
    private(set) var router: (NSObjectProtocol & EpisodesRoutingLogic)?
    var episodes = EpisodesModel.init(cells: [])

  
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = EpisodesInteractor()
    let presenter             = EpisodesPresenter()
    let router                = EpisodesRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing


  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Episodes"
    
    setup()
    
    interactor?.makeRequest(request: .getEpisodes)
    collectionView.register(UINib(nibName:
                                  Constants.NibName.CustomCollectionViewCell.rawValue,
                                  bundle: nil),
                                  forCellWithReuseIdentifier:
                                  Constants.ReuseIdentifier.CustomCollectionViewCell.rawValue)
  }

  func displayData(viewModel: Episodes.Model.ViewModel.ViewModelData) {
    switch viewModel {
    case .displayEpisodes(episodeModel: let episodeModel):
        episodes = episodeModel
        collectionView.reloadData()
        
    }
  }
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView.contentOffset.y > scrollView.contentSize.height / 1.4 {
            interactor?.makeRequest(request: .getMoreEpisodes)
    }
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return episodes.cells.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReuseIdentifier.CustomCollectionViewCell.rawValue, for: indexPath) as! CustomCollectionViewCell
        let episode = episodes.cells[indexPath.item]
        cell.setEpisodes(viewModel: episode)
        cell.typeSecondLabel.text = "Number"
        cell.typeThirdLabel.text = "Date"
        return cell
    }
  
}
