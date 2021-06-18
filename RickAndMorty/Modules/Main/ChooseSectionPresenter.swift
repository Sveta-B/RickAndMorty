//
//  ChooseSectionPresenter.swift
//  RickAndMorty
//
//  Created by Света Брасс on 18.06.21.
//

import UIKit

protocol ChooseSectionPresentationLogic {
  func presentData(response: ChooseSection.Model.Response.ResponseType)
}

class ChooseSectionPresenter: ChooseSectionPresentationLogic {
    
    // MARK: Properties
    
  weak var viewController: ChooseSectionDisplayLogic?
  
    // MARK: ChooseSectionPresentationLogic
    
  func presentData(response: ChooseSection.Model.Response.ResponseType) {
    switch response {
    
    case .presentSections(characters: let characters, locations: let locations, episodes: let episodes):
        let sections = [Section(name: "Characters", url: characters), Section(name: "Locations", url: locations),Section(name: "Episodes", url: episodes)]
        viewController?.displayData(viewModel: .displaySections(sections: sections))
    }
  }
}
