//
//  FilterPresenter.swift
//  RickAndMorty
//
//  Created by Света Брасс on 19.06.21.
//

import UIKit

protocol FilterPresentationLogic {
  func presentData(response: Filter.Model.Response.ResponseType)
}

class FilterPresenter: FilterPresentationLogic {
  weak var viewController: FilterDisplayLogic?
  
  func presentData(response: Filter.Model.Response.ResponseType) {
  
  }
  
}
