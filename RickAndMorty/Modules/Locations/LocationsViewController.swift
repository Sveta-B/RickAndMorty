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

class LocationsViewController:ParentCollectionViewController , LocationsDisplayLogic, CellDelegate {
    
    // MARK: Properties
    
    private var interactor: (LocationsBusinessLogic & URLStoreProtocol)?
    var router: (LocationsRoutingLogic & URLPassingProtocol)?
    private var locations =  LocationsModel.init(cells: [])
    
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
        let interactor            = LocationsInteractor()
        let presenter             = LocationsPresenter()
        let router                = LocationsRouter()
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
        title = "Locations"
        
        interactor?.makeRequest(request: .getLocations)
        collectionView.register(UINib(nibName:
                                        Constants.NibName.CustomCollectionViewCell.rawValue,
                                      bundle: nil),
                                forCellWithReuseIdentifier:
                                    Constants.ReuseIdentifier.CustomCollectionViewCell.rawValue)
    }
    
    // MARK: LocationsDisplayLogic
    
    func displayData(viewModel: Locations.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayLocations(locationModel: let locationModel):
            locations = locationModel
            collectionView.reloadData()
        }
    }
    
    // MARK: DidEndDragging
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView.contentOffset.y > scrollView.contentSize.height / 2 {
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
        cell.delegate = self
        return cell
    }
}
