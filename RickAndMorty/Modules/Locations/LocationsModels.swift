//
//  LocationsModels.swift
//  RickAndMorty
//
//  Created by Света Брасс on 15.06.21.
//

import UIKit

enum Locations {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getLocations
        case getMoreLocations
      }
    }
    struct Response {
      enum ResponseType {
        case presentLocations(locations: [Location])
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayLocations(locationModel: LocationsModel)
      }
    }
  }
  
}

struct LocationsModel {
    struct Cell: CustomCollectionViewCellProtocol {
        
        var name: String
        var type: String?
        var dimension: String?
        var residents: [String]?
    
    }
    var cells: [Cell]
}
