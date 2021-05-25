//
//  CharactersCollectionViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 18.05.21.
//

import UIKit

class CharactersCollectionViewController: ParentCollectionViewController {
    var countItem = 0
    var characters: [Result]? {
        willSet {
            if (newValue != nil) {
                countItem = newValue!.count
            }
        }
    }
    var networkManager = NetworkManager()
   private var filterCharacters: [Result]?
   private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {
            return false
        }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterCharacters = characters
        collectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Constants.ReuseIdentifier.CharactersCell.rawValue)
      createSearchController()
        networkManager.getData(nameSection: .character, PageNumber: 1) {[weak self] (characterData) in
            self?.characters = characterData.results
        }
       countItem =  self.characters?.count ?? 0
    }
    
    @IBAction func filter(_ sender: Any) {
       
    }
    
    @IBAction func tapedBackButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    func  createSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Введите имя"
        navigationItem.searchController = searchController
        definesPresentationContext = true
            }
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filterCharacters!.count
        }
        
        return 671
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReuseIdentifier.CharactersCell.rawValue, for: indexPath) as! CharacterCollectionViewCell
        var count  = 0
        DispatchQueue.main.async {
            guard let myCharacters = self.characters else { return}
                cell.nameLabel.text = myCharacters[indexPath.item].name
            print(myCharacters[indexPath.item].id)
            
            count += 1
                guard  let stringForImage = self.characters?[indexPath.item].image else { return}
                guard let url = URL(string: stringForImage) else { return}
            guard  let data = try? Data(contentsOf: url) else {return}
            cell.imageView.image = UIImage(data: data)
        }
        print(count)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: wightScreen, height: CGFloat(Constants.hightTabBar))
    }


    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        for i in 2...34 {
        if indexPath.row > countItem - 8 {
           
                networkManager.getData(nameSection: .character, PageNumber: i)  {[weak self] (characterData) in
                self?.characters? += characterData.results
                
                }
                }
    }
}
}

extension CharactersCollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    private func filterContentForSearchText(_ searchText: String) {
        filterCharacters = characters?.filter({ (characters: Result) -> Bool in
            return characters.name.lowercased().contains(searchText.lowercased())
        })
        collectionView.reloadData()
    }
    
    
}
extension CharactersCollectionViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        filterCharacters = []
//        if searchText == "" {
//            filterCharacters = characters
//        } else {
//            for object in characters! {
//                for character in object.name {
//                    if character.lowercased().contains(searchText.lowercased()) {
//                        filterCharacters!.append(object)
//                }
//            }
//        }
//        }
//        self.collectionView.reloadData()
//    }
}
