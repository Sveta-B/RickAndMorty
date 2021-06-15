//
//  LocationsViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 15.06.21.
//

import UIKit

protocol LocationsDisplayLogic: class {
  func displayData(viewModel: Locations.Model.ViewModel.ViewModelData)
}

class LocationsViewController:ParentCollectionViewController , LocationsDisplayLogic {
  
  var interactor: LocationsBusinessLogic?
  var router: (NSObjectProtocol & LocationsRoutingLogic)?

    private var countRows: Int?
    var locations =  LocationsModel.init(cells: [])
  
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = LocationsInteractor()
    let presenter             = LocationsPresenter()
    let router                = LocationsRouter()
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
    title = "Locations"
    setup()
    
    interactor?.makeRequest(request: .getLocations)
    collectionView.register(UINib(nibName:
                                  Constants.NibName.CustomCollectionViewCell.rawValue,
                                  bundle: nil),
                                  forCellWithReuseIdentifier:
                                  Constants.ReuseIdentifier.CustomCollectionViewCell.rawValue)
  }

  func displayData(viewModel: Locations.Model.ViewModel.ViewModelData) {
    switch viewModel {
    
    case .displayLocations(locationModel: let locationModel):
  
        locations = locationModel
        collectionView.reloadData()
    }
  }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if locations.cells.count == 108 {
            return
        } else
        if scrollView.contentOffset.y > scrollView.contentSize.height / 1.4 {
        interactor?.makeRequest(request: .getMoreLocations)
        
        }
    }
    
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return locations.cells.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReuseIdentifier.CustomCollectionViewCell.rawValue, for: indexPath) as! CustomCollectionViewCell
        let location = locations.cells[indexPath.item]
        cell.set(viewModel: location)
        return cell
    }
  
}
