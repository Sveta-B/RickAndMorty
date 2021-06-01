//
//  CharactersCollectionViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 18.05.21.
//

import UIKit

class CharactersCollectionViewController: ParentCollectionViewController {
    
    //MARK: - Properties
    
    private var countItem = 0
    private var countRows = 0
    private var pagesCount = 1
    private var characters: [Character]? {
        didSet {
            countItem = characters?.count ?? 0
            
        }
    }
    private var charactersData: CharacterData? {
        didSet {
           countRows =  charactersData?.info.count ?? 0
           pagesCount = charactersData?.info.pages ?? 0
            
        }
    }
    private let networkManager = NetworkManager()
    
    private var searchCharacters: [Character]?
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        collectionView.register(UINib(nibName: Constants.NibName.CharacterCollectionViewCell.rawValue, bundle: nil), forCellWithReuseIdentifier: Constants.ReuseIdentifier.CharactersCell.rawValue)
        createSearchController()
        networkManager.getData(nameSection: .character, typeResult: charactersData, pageNumber: pagesCount) { [weak self] (result) in
            switch result {
            case .success(let characterData) :
                self?.charactersData = characterData
                self?.characters = characterData?.results
            case .failure(let error):
                print(error)

            }
        }
        
        searchCharacters = characters
    }
    
    // MARK: - IBActions
    @IBAction func filter(_ sender: Any) {
       
    }
    
    @IBAction func tapedBackButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - SearchController
    func  createSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Введите имя"
        navigationItem.searchController = searchController
        definesPresentationContext = true
            }
    
    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return countRows
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReuseIdentifier.CharactersCell.rawValue, for: indexPath) as! CharacterCollectionViewCell
        if let myCharacter = self.characters?[indexPath.item] {
            cell.nameLabel.text = myCharacter.name
            cell.indicator.stopAnimating()
            if let stringForImage = myCharacter.image {
                if let url = URL(string: stringForImage) {
                    if  let data = try? Data(contentsOf: url) {
        DispatchQueue.main.async {
            cell.imageView.image = UIImage(data: data)
        }
                    }
                }
            }
        }
        return cell
    }

    //MARK: - WillDisplay cell
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        var i = 2
        if indexPath.row == countItem - 8 {
            while i < pagesCount + 1 {
                fetchMoreData(pageNumber: i)
                i += 1
            }
       }
        self.countItem = (self.characters?.count)!
   }


    func fetchMoreData(pageNumber: Int) {
        
        networkManager.getData(nameSection: .character, typeResult: charactersData, pageNumber: pageNumber) { [weak self] (result) in
            switch result {
            case .success(let characterData) :
              //  self?.charactersData = characterData
                self?.characters? += characterData?.results ?? []
            case .failure(let error):
                print(error)

            }
        }
    }
    
    //MARK: - DidSelectItemAt
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let  character  = self.characters?[indexPath.item] {
           
            let storyboard = UIStoryboard(name: Constants.Storyboards.DetailsStoryboard.rawValue, bundle: nil)
            guard let characterViewController = storyboard.instantiateViewController(identifier: Constants.IdRootViewControllers.DetailsViewController.rawValue)  as? DetailsViewController else { return }
            characterViewController.character = character
            navigationController?.pushViewController(characterViewController, animated: true)
        }
    }
}

// MARK: - SearchResultsUpdating
extension CharactersCollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    private func filterContentForSearchText(_ searchText: String) {
        searchCharacters = characters?.filter({ (characters: Character) -> Bool in
            return characters.name.lowercased().contains(searchText.lowercased())
        })
        collectionView.reloadData()
    }
}

