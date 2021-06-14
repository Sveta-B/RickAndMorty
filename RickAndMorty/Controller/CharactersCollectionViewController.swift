//
//  CharactersCollectionViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 18.05.21.
//

import UIKit

class CharactersCollectionViewController: ParentCollectionViewController, UISearchResultsUpdating, UISearchBarDelegate {
    private let searchController = UISearchController(searchResultsController: nil)
    //MARK: - Properties
    
    private var countItem = 0
    private var countRows = 0
    private var pagesCount = 0
    private var numberOfPage = 1
    private var characters: [Character]? {
        willSet{
            if (newValue != nil) {
                             countItem = newValue!.count
                         }
        }
    }
    private var charactersData: CharacterData? {
        willSet{
            if (newValue != nil) {
                countRows =  newValue?.info.count ?? 0
                pagesCount = newValue?.info.pages ?? 0
                print(pagesCount)
                print(countRows)
                collectionView.reloadData()
                         }
        }

    }
    private let networkManager = NetworkManager()
    var filterCharacters: [Character]?
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        searchController.searchBar.delegate = self
        networkManager.getData(nameSection: .character, typeResult: charactersData, pageNumber: numberOfPage) { [weak self] (result) in
            switch result {
            case .success(let characterData) :
                self?.charactersData = characterData
                self?.characters = characterData?.results
                self?.numberOfPage += 1
            case .failure(let error):
                print(error)
            }
        }
       
        collectionView.register(UINib(nibName:
                                      Constants.NibName.CharacterCollectionViewCell.rawValue,
                                      bundle: nil),
                                      forCellWithReuseIdentifier:
                                      Constants.ReuseIdentifier.CharactersCell.rawValue)
        createSearchController()
    }

   
    func updateSearchResults(for searchController: UISearchController) {
        
    }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    
        return CGSize(width: 343, height: 44)
    }
    // MARK: - SearchController
    func  createSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Введите имя"
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
            }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

            if searchText.isEmpty {
                filterCharacters = characters
                collectionView.reloadData()
            } else {

                func filterTableView(text:String) {
                    let search = text.lowercased()
                    filterCharacters = characters?.filter({ (mod) -> Bool in
                        return (mod.name?.lowercased().contains(search))!
                    })
                    self.collectionView.reloadData()
                }

                filterTableView(text: searchText)
            }
        }
    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if countRows == 0 {
            return 20
        }
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
        
            cell.imageView.image = UIImage(data: data)
        
                    }
                }
            }
        }
        return cell
    }

    //MARK: - Fetch more data
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if numberOfPage == pagesCount  {
            print("range")
            return
        } else {
        if indexPath.row == countItem - 8 {
                print(countItem)
                fetchMoreData(pageNumber: numberOfPage)
                numberOfPage += 1
            self.countItem = self.characters?.count ?? 20
            }
       }
   }


    func fetchMoreData(pageNumber: Int) {
        
        networkManager.getData(nameSection: .character, typeResult: charactersData, pageNumber: pageNumber) { [weak self] (result) in
            switch result {
            case .success(let characterData) :
                self?.characters? += characterData?.results ?? []
            case .failure(let error):
                print(error)

            }
        }
    }
    
    //MARK: - Navigation
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let  character  = self.characters?[indexPath.item] {
           
            let storyboard = UIStoryboard(name: Constants.Storyboards.DetailsStoryboard.rawValue, bundle: nil)
            guard let characterViewController = storyboard.instantiateViewController(identifier: Constants.IdRootViewControllers.DetailsViewController.rawValue)  as? DetailsViewController else { return }
            characterViewController.character = character
            navigationController?.pushViewController(characterViewController, animated: true)
        }
    }
}


