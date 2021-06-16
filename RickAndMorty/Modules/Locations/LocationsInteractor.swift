//
//  LocationsInteractor.swift
//  RickAndMorty
//
//  Created by Света Брасс on 15.06.21.
//

import UIKit

protocol LocationsBusinessLogic {
  func makeRequest(request: Locations.Model.Request.RequestType)
  
}

class LocationsInteractor: LocationsBusinessLogic {

  var presenter: LocationsPresentationLogic?
  var service: LocationsService?
var locationData: LocationData?
    var locations: [Location]?
    var networkManager: NetworkManagerProtocol?
    var pageNumber = 1
  func makeRequest(request: Locations.Model.Request.RequestType) {
    networkManager = NetworkManager()
    if service == nil{
      service = LocationsService()
    }
    switch request {
    
    case .getLocations:
        networkManager?.getData(nameSection: .location, typeResult: locationData, pageNumber: pageNumber) { [weak self] (result) in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                self?.locations = data.results
                self?.presenter?.presentData(response: .presentLocations(locations: self?.locations ?? []))
                self?.pageNumber = 2
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    case  .getMoreLocations:
                
                networkManager?.getData(nameSection: .location, typeResult: locationData, pageNumber: pageNumber) { [weak self] (result) in
                    switch result {
                    case .success(let data):
                        guard let data = data else { return }
                        self?.locations?.append(contentsOf: data.results) 
                        self?.presenter?.presentData(response: .presentLocations(locations: self?.locations ?? []))
                        if self?.pageNumber ?? 0 <= 6 {
                        self?.pageNumber += 1
                        } else {return}
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
        
    }
    
  }
  
}
}
