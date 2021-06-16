//
//  DetailCharactersViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 16.06.21
//

import UIKit

protocol DetailCharactersDisplayLogic: class {
  func displayData(viewModel: DetailCharacters.Model.ViewModel.ViewModelData)
}

class DetailCharactersViewController: UIViewController, DetailCharactersDisplayLogic {

    @IBOutlet weak var avatarCharacter: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    
   private var interactor: (DetailCharactersBusinessLogic & DetailCharactersStoreProtocol)?
  var router: (NSObjectProtocol & DetailCharactersRoutingLogic & DetailCharactersDataPassingProtocol)!
    var character: DetailCharacter?
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = DetailCharactersInteractor()
    let router                = DetailCharactersRouter()
    viewController.interactor = interactor
    viewController.router     = router
    router.dataStore = interactor
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    interactor?.makeRequest(request: .getCharacter)
    
  }
  
  func displayData(viewModel: DetailCharacters.Model.ViewModel.ViewModelData) {
    switch viewModel {

    case .displayCharacters(characterModel: let characterModel):
        nameLabel.text =  characterModel.name
        genderLabel.text = characterModel.gender
        statusLabel.text = characterModel.status
        speciesLabel.text = characterModel.species
        if let stringForImage = characterModel.image {
                if let url = URL(string: stringForImage) {
                    if  let data = try? Data(contentsOf: url) {
        
        avatarCharacter.image = UIImage(data: data)
                    }
                }
        }
    }

    
  }
  
}
