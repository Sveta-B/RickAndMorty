//
//  Constants.swift
//  RickAndMorty
//
//  Created by Света Брасс on 20.05.21.
//

import UIKit

struct Constants {
   static let  minimumSpacing:CGFloat = 32
    static let hightTabBar = 44
    enum Storyboards: String{
        case CharactersStoryboard
        case LocationsStoryboard
    }
    enum IdRootViewControllers: String {
        case LocationsNavigationViewController
        case CharactersNavigationViewController
    }
    
    enum ReuseIdentifier: String {
        case SectionCollectionViewCell
        case CharactersCell
    }
}
