//
//  ChooseSectionCollectionViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 17.05.21.
//

import UIKit

class ChooseSectionCollectionViewController: ParentCollectionViewController {
    let sections = [Section(name: "Characters", image: "characters"), Section(name: "Locations", image: "locations"), Section(name: "Episodes", image: "episodes")]
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.ReuseIdentifier.SectionCollectionViewCell.rawValue, for: indexPath) as! SectionCollectionViewCell 
        let  section = sections[indexPath.item]
        cell.nameSectionLabel.text = section.name
        cell.imageForSection.image = UIImage(named: section.image!)
        return cell
        
    }
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        print("You taped on \(indexPath)")
        switch indexPath {
        case [0, 0]:
            changeSection(nameStoryboard:Constants.Storyboards.CharactersStoryboard.rawValue,  idVC: Constants.IdRootViewControllers.CharactersNavigationViewController.rawValue)
        case [0, 1]:
            changeSection(nameStoryboard: Constants.Storyboards.LocationsStoryboard.rawValue, idVC: Constants.IdRootViewControllers.LocationsNavigationViewController.rawValue)
        default:
            print("no sb")
        }
    }
    
    func changeSection(nameStoryboard: String,  idVC: String) {
    let storyboard = UIStoryboard(name: nameStoryboard, bundle: nil)
        guard let secondViewController = storyboard.instantiateViewController(identifier: idVC)  as? NavigationViewController else { return }
       // navigationController?.pushViewController(secondViewController, animated: true)
        secondViewController.modalPresentationStyle = .fullScreen
        show(secondViewController, sender: nil)
    }
    
   override func collectionView(_: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        let hight = (Int(hightScreen) - Int(Constants.minimumSpacing) * 5 - Constants.hightTabBar) / 3
        let wight = Int(wightScreen) - Int(Constants.minimumSpacing) * 2
       return CGSize(width: wight, height: hight)
    }
}

