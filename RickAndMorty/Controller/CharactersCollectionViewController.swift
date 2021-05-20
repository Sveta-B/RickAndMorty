//
//  CharactersCollectionViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 18.05.21.
//

import UIKit

class CharactersCollectionViewController: ParentCollectionViewController {

    var characters: [Result]?
    var filterCharacters: [Result]?
    var networkManager = NetworkManager()
    var countItem = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterCharacters = characters
        collectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Constants.ReuseIdentifier.CharactersCell.rawValue)
        createSearchBar()
        networkManager.getData(nameSection: .character) {[weak self] (characterData) in
            self?.characters = characterData.results
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
        return 20
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReuseIdentifier.CharactersCell.rawValue, for: indexPath) as! CharacterCollectionViewCell
        DispatchQueue.main.async {
            print(indexPath.item)
            guard let myCharacters = self.characters else { return}
                cell.nameLabel.text = myCharacters[indexPath.item].name
                guard  let stringForImage = self.characters?[indexPath.item].image else { return}
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
