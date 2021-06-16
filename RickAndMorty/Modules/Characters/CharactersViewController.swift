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

class CharactersViewController: ParentCollectionViewController, CharactersDisplayLogic {
  
  private var interactor: CharactersBusinessLogic?
  var router: (NSObjectProtocol & CharactersRoutingLogic)?
    var characters =  CharactersModel.init(cells: [])
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = CharactersInteractor()
    let presenter             = CharactersPresenter()
    let router                = CharactersRouter()
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
    title = "Characters"
    setup()
    interactor?.makeRequest(request: .getCharacters)
    collectionView.register(UINib(nibName:
                                  Constants.NibName.CharacterCollectionViewCell.rawValue,
                                  bundle: nil),
                                  forCellWithReuseIdentifier:
                                  Constants.ReuseIdentifier.CharactersCell.rawValue)
  }

  func displayData(viewModel: Characters.Model.ViewModel.ViewModelData) {
    switch viewModel {
   
    case .displayCharacters(charactersModel: let charactersModel):
        characters = charactersModel
        collectionView.reloadData()
    }
  }
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
       
        if scrollView.contentOffset.y > scrollView.contentSize.height / 1.4 {
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
  
}
