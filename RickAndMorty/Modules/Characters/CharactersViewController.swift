//
//  CharactersViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 16.06.21.
//

import UIKit

protocol CharactersDisplayLogic: class {
  func displayData(viewModel: Characters.Model.ViewModel.ViewModelData)
}

class CharactersViewController: ParentCollectionViewController, CharactersDisplayLogic, UISearchBarDelegate, UISearchResultsUpdating {
    
    // MARK: Properties
    
    private var interactor: (CharactersBusinessLogic & CharactersStoreProtocol & URLStoreProtocol & FilterURLStoreProtocol)?
    let searchController = CustomSearchController()
    var characters =  CharactersModel.init(cells: [])
    var router :  (CharactersDataPassingProtocol  & CharactersRoutingLogic & URLPassingProtocol & FilterTransferProtocol & FilterURLPassingProtocol)?
    let filterButton = UIButton()

    
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
    let interactor            = CharactersInteractor()
    let presenter             = CharactersPresenter()
    let router                = CharactersRouter()
    let networkManager        = NetworkManager()
    interactor.networkManager = networkManager
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
    router.dataStore = interactor
    router.urlStore = interactor
    router.filterURLStore = interactor
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Characters"
    
    searchController.searchBar.delegate = self
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false



    
    setFilterButton()

    interactor?.makeRequest(request: .getCharacters)

    collectionView.register(UINib(nibName:
                                  Constants.NibName.CharacterCollectionViewCell.rawValue,
                                  bundle: nil),
                                  forCellWithReuseIdentifier:
                                  Constants.ReuseIdentifier.CharactersCell.rawValue)
    
  }
    
    // MARK: Filter
    
    func setFilterButton()  {
        filterButton.setImage(#imageLiteral(resourceName: "icons8-filter-50"), for: .normal)
        let barButton = UIBarButtonItem(customView: filterButton)
        self.navigationItem.rightBarButtonItem = barButton
        filterButton.addTarget(self, action: #selector(showFilterVC), for: .touchUpInside)
    }

    @objc func  showFilterVC() {
        router?.showFilterViewController()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor?.makeRequest(request: .getFilterCharacters)
    }
    
    
    // MARK: CharactersDisplayLogic
    
  func displayData(viewModel: Characters.Model.ViewModel.ViewModelData) {
    switch viewModel {
   
    case .displayCharacters(charactersModel: let charactersModel):
        characters = charactersModel
        collectionView.reloadData()
    }
  }
    
    // MARK: DidEndDragging
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
          
            if scrollView.contentOffset.y > scrollView.contentSize.height / 2 {
                interactor?.makeRequest(request: .getMoreCharacters)
            }
  }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.cells.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReuseIdentifier.CharactersCell.rawValue, for: indexPath) as! CharacterCollectionViewCell
        let character = characters.cells[indexPath.item]
        cell.set(viewModel: character)
        return cell
    }
    
   // MARK: - Navigation
    
       override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let  characterModel  = self.characters.cells[indexPath.item]
        let character = DetailCharacter(name: characterModel.name, image: characterModel.image, status: characterModel.status, gender: characterModel.gender, species: characterModel.species)
        router?.showDetailsCharacter(character: character)
  }
    
    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
       
        searchBar(searchController.searchBar, textDidChange: text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

            if searchText.isEmpty {
                interactor?.makeRequest(request: .getCharacters)
                collectionView.reloadData()
            } else {
                if searchText.count  >= 3 {
                interactor?.makeRequest(request: .getSearchCharacters(text: searchText))
                    collectionView.reloadData()
                }
            }
        }
}
