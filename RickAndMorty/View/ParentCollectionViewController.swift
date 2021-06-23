//
//  ParentCollectionViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 20.05.21.
//

import UIKit

class ParentCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var wightScreen = CGFloat()
    var hightScreen = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = #colorLiteral(red: 0.144208163, green: 0.1694156826, blue: 0.2115245759, alpha: 1) 
        wightScreen = view.bounds.size.width
        hightScreen = view.bounds.size.height
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        
    }
    
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        var countItemInRow: Int
        switch wightScreen {
        case 0...399:
            countItemInRow = 2
        case 400...799:
            countItemInRow = 3
        case 800...999:
            countItemInRow = 4
        case 1000...:
            countItemInRow = 5
        default:
            countItemInRow = 0
        }
        let wight = (Int(wightScreen) - Int(Constants.minimumSpacing) * (countItemInRow + 1)) / countItemInRow
        let hight = Double(wight) * 1.4
        return CGSize(width: wight, height: Int(hight))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.minimumSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var insets = UIEdgeInsets()
        insets.top = Constants.minimumSpacing
        insets.left = Constants.minimumSpacing
        insets.right = Constants.minimumSpacing
        insets.bottom = Constants.minimumSpacing
        return insets
    } 
}
