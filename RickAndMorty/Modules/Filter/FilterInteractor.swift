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
    
   //  alive, dead or unknown
    // female, male, genderless or unknown
    let url = "https://rickandmortyapi.com/api/character/?gender=female&status=alive"

  var presenter: FilterPresentationLogic?

  
  func makeRequest(request: Filter.Model.Request.RequestType) {
    
  }
  
}
