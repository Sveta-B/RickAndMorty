//
//  CharactersCollectionViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 18.05.21.
//

import UIKit

class CharactersCollectionViewController: UICollectionViewController {

    var characters: [Result]?
    var filterCharacters: [Result]?
    var wightScreen = CGFloat()
    var hightScreen = CGFloat()
    private let reuseIdentifier = "CharactersCell"
    var results: CharacterData?
    var networkManager = NetworkManager()
    var countItem = 671
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterCharacters = characters
        wightScreen = view.bounds.size.width
        hightScreen = view.bounds.size.height
      let layout = UICollectionViewFlowLayout()
       collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        createSearchBar()
        networkManager.getData(nameSection: .character) { (characterData) in
                self.characters = characterData.results
                self.countItem =  self.characters!.count
        }
    }
    
    @IBAction func filter(_ sender: Any) {
       
    }
    
    @IBAction func tapedBackButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func createSearchBar()  {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: Int(wightScreen - 2 * Constants.minimumSpacing), height: Constants.hightTabBar))
        searchBar.barStyle = .black
        searchBar.backgroundColor = #colorLiteral(red: 0.144208163, green: 0.1694156826, blue: 0.2115245759, alpha: 1)
        searchBar.placeholder = "Введите имя"
        searchBar.searchBarStyle = .minimal
        collectionView.addSubview(searchBar)
        searchBar.delegate = self
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countItem
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CharacterCollectionViewCell
        DispatchQueue.main.async {
            
            cell.nameLabel.text = self.characters![indexPath.item].name
             let stringForImage = self.characters![indexPath.item].image
            guard let url = URL(string: stringForImage) else { return}
            guard  let data = try? Data(contentsOf: url) else {return}
            cell.imageView.image = UIImage(data: data)
        }
      
       
    
        
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: wightScreen, height: CGFloat(Constants.hightTabBar))
    }

}

extension CharactersCollectionViewController: UICollectionViewDelegateFlowLayout {
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

}


extension CharactersCollectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterCharacters = []
        if searchText == "" {
            filterCharacters = characters
        } else {
            for object in characters! {
                for character in object.name {
                    if character.lowercased().contains(searchText.lowercased()) {
                        filterCharacters!.append(object)
                }
            }
        }
        }
        self.collectionView.reloadData()
    }
}
