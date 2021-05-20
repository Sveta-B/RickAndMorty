//
//  ParentCollectionViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 20.05.21.
//

import UIKit

private let reuseIdentifier = "Cell"

class ParentCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var wightScreen = CGFloat()
    var hightScreen = CGFloat()
    override func viewDidLoad() {
        super.viewDidLoad()
        wightScreen = view.bounds.size.width
        hightScreen = view.bounds.size.height
      let layout = UICollectionViewFlowLayout()
       collectionView.collectionViewLayout = layout
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }


    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        let hight = (Int(hightScreen) - Int(Constants.minimumSpacing) * 5 - (Constants.hightTabBar * 2)) / 3
        let wight = (Int(wightScreen) - Int(Constants.minimumSpacing) * 3) / 2
       return CGSize(width: wight, height: hight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.minimumSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var insets = UIEdgeInsets()
        insets.top = Constants.minimumSpacing
        insets.left = Constants.minimumSpacing
        insets.right = Constants.minimumSpacing
        return insets
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }

   

}
