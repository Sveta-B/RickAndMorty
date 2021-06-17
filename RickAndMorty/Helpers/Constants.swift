//
//  Constants.swift
//  RickAndMorty
//
//  Created by Света Брасс on 20.05.21.
//

import UIKit

struct Constants {
   static let  minimumSpacing:CGFloat = 16
    static let hightTabBar = 44
    
    enum Storyboards: String{
        case CharactersStoryboard
        case LocationsStoryboard
        case DetailsStoryboard
        case EpisodesStoryboard
        case EmptyStoryboard
    }
    enum IdRootViewControllers: String {
        case LocationsViewController
        case CharactersViewController
        case EpisodesViewController
        case DetailCharactersViewController
        case EmptyViewController
    }
    enum NibName: String {
    case CharacterCollectionViewCell
    case CustomCollectionViewCell
    }
    
    enum ReuseIdentifier: String {
        
        case SectionCollectionViewCell
        case CharactersCell
        case CustomCollectionViewCell
    }
}
