//
//  ChooseSectionCollectionViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 17.05.21.
//

import UIKit

class ChooseSectionCollectionViewController: ParentCollectionViewController {
   
    let sections = [Section(name: .character, image: .character), Section(name: .location, image: .location), Section(name: .episode, image: .episode)]
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.ReuseIdentifier.SectionCollectionViewCell.rawValue, for: indexPath) as! SectionCollectionViewCell 
        let  section = sections[indexPath.item]
        cell.nameSectionLabel.text = section.name.rawValue
        cell.imageForSection.image = UIImage(named: section.image.rawValue)
        return cell
        
    }
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    
        switch indexPath {
        case [0, 0]:
            changeSection(nameStoryboard:Constants.Storyboards.CharactersStoryboard.rawValue,  idVC: Constants.IdRootViewControllers.CharactersCollectionViewController.rawValue)
        case [0, 1]:
            changeSection(nameStoryboard: Constants.Storyboards.LocationsStoryboard.rawValue, idVC: Constants.IdRootViewControllers.LocationsViewController.rawValue)
            
        case [0, 2]:
           
            changeSection(nameStoryboard: Constants.Storyboards.EpisodesStoryboard.rawValue, idVC: Constants.IdRootViewControllers.EpisodesCollectionViewController.rawValue)
            
        default:
            return
        }  
        
    }
    
    func changeSection(nameStoryboard: String,  idVC: String) {
    let storyboard = UIStoryboard(name: nameStoryboard, bundle: nil)
        guard let secondViewController = storyboard.instantiateViewController(identifier: idVC)  as? UICollectionViewController else { return }
       
        secondViewController.modalPresentationStyle = .fullScreen
        show(secondViewController, sender: nil)
    }
    
   override func collectionView(_: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        let hight = (Int(hightScreen) - Int(Constants.minimumSpacing) * 5 - Constants.hightTabBar) / 3
        let wight = Int(wightScreen) - Int(Constants.minimumSpacing) * 2
       return CGSize(width: wight, height: hight)
    }
}

