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
        case DetailsStoryboard
    }
    enum IdRootViewControllers: String {
        case LocationsNavigationViewController
        case CharactersNavigationViewController
        case DetailsNavigationViewController
    }
    
    enum ReuseIdentifier: String {
        case SectionCollectionViewCell
        case CharactersCell
    }
}
