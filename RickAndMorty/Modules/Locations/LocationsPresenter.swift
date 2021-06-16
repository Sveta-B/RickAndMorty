//
//  LocationsPresenter.swift
//  RickAndMorty
//
//  Created by Света Брасс on 15.06.21.
//

import UIKit

protocol LocationsPresentationLogic {
  func presentData(response: Locations.Model.Response.ResponseType)
}

class LocationsPresenter: LocationsPresentationLogic {
  
  weak var viewController: LocationsDisplayLogic?
  
  func presentData(response: Locations.Model.Response.ResponseType) {
    switch response {
    
    case .presentLocations(locations: let locations):
        let cells = locations.map { (location)  in
            cellViewModel(from: location)
            
        }
        let locationModel = LocationsModel.init(cells:
           cells )
       viewController?.displayData(viewModel: .displayLocations(locationModel: locationModel))
        
    }

  }
  
    func cellViewModel(from locations: Location) -> LocationsModel.Cell {
        return LocationsModel.Cell.init(name: locations.name ?? "No name", type: locations.type, dimension: locations.dimension, residents: locations.residents)
    }
}
