//
//  CustomTableViewCell.swift
//  RickAndMorty
//
//  Created by Света Брасс on 2.06.21.
//

import UIKit

class CustomTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    

    @IBOutlet weak var charactersCollectionView: UICollectionView!
    @IBOutlet weak var dateLabel: UILabel!
    var wightScreen = 343
    var hightScreen = 100
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
//        wightScreen = charactersCollectionView.bounds.size.width
//        hightScreen = charactersCollectionView.bounds.size.height
      let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
       charactersCollectionView.collectionViewLayout = layout
        charactersCollectionView.delegate = self
        charactersCollectionView.dataSource = self
        charactersCollectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Constants.ReuseIdentifier.CharactersCell.rawValue)
      
    }

    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        let hight = Int(hightScreen)
        let wight = (Int(wightScreen) - Int(Constants.minimumSpacing) * 3) / 2
//        let hight = (Int(hightScreen) - Int(Constants.minimumSpacing) * 5 - (Constants.hightTabBar * 2)) / 3
//        let wight = (Int(wightScreen) - Int(Constants.minimumSpacing) * 3) / 2
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReuseIdentifier.CharactersCell.rawValue, for: indexPath) as! CharacterCollectionViewCell
        cell.imageView.image = #imageLiteral(resourceName: "rick_morty_PNG19")
        cell.nameLabel.text = "fd"
        return cell
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
