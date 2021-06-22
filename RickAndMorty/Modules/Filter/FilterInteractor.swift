//
//  FilterInteractor.swift
//  RickAndMorty
//
//  Created by Света Брасс on 19.06.21.
//

import UIKit

protocol FilterBusinessLogic {
  func makeRequest(request: Filter.Model.Request.RequestType)
}

class FilterInteractor: FilterBusinessLogic {
    

  var presenter: FilterPresentationLogic?

  
  func makeRequest(request: Filter.Model.Request.RequestType) {
    
  }
  
}
