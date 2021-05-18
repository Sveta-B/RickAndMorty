//
//  ChooseSectionCollectionViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 17.05.21.
//

import UIKit

private let reuseIdentifier = "Cell"

class ChooseSectionCollectionViewController: UICollectionViewController {
    
    let minimumSpacing:CGFloat = 32
    var wightScreen = CGFloat()
    var hightScreen = CGFloat()
    let sections = [Section(name: "Characters", image: "characters"), Section(name: "Locations", image: "locations"), Section(name: "Episodes", image: "episodes")]
 
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
         wightScreen = view.bounds.size.width
         hightScreen = view.bounds.size.height
       let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        
        
    }

    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SectionCollectionViewCell
        let  section = sections[indexPath.item]
        cell.nameSectionLabel.text = section.name
        cell.imageForSection.image = UIImage(named: section.image!)
        return cell
        
    }
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        print("You taped on \(indexPath)")
    }
}

extension ChooseSectionCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        let hight = (Int(hightScreen) - Int(minimumSpacing) * 5 - 44) / 3
        let wight = Int(wightScreen) - Int(minimumSpacing) * 2
       return CGSize(width: wight, height: hight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        
        return minimumSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var insets = UIEdgeInsets()
        insets.top = minimumSpacing
        return insets
    }

    
    
}
