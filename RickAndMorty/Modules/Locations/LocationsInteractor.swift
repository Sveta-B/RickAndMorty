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
    private var locationData: LocationData?
    private var locations: [Location]?
    private var networkManager: NetworkManagerProtocol?
    private var stringURL = "https://rickandmortyapi.com/api/location"
    func makeRequest(request: Locations.Model.Request.RequestType) {
    networkManager = NetworkManager()
    switch request {
    
    case .getLocations:
        networkManager?.fetchData(stringURL: stringURL, typeResult: locationData) { [weak self] (result)  in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                self?.locations = data.results
                self?.presenter?.presentData(response: .presentLocations(locations: self?.locations ?? []))
                self?.stringURL = data.info.next
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    case  .getMoreLocations:
        networkManager?.fetchData(stringURL: stringURL, typeResult: locationData) { [weak self] (result)  in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                self?.locations?.append(contentsOf: data.results)
                self?.presenter?.presentData(response: .presentLocations(locations: self?.locations ?? []))
                self?.stringURL = data.info.next
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
                
        
    }
    
  }
  
}

