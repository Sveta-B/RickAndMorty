//
//  ContainerForData.swift
//  RickAndMorty
//
//  Created by Света Брасс on 4.06.21.
//

import Foundation

class ContainerForData {
    
    private let networkManager = NetworkManager()
//    private var countRows = 0
//    private var pagesCount = 0
//    private var characters: [Character]?
    private var charactersData: CharacterData?
    func getDAta(completionHandler: @escaping (_ countRows: Int, _ pagesCount: Int, _ characters: [Character] ) -> Void)  {
       
    networkManager.getData(nameSection: .character, typeResult: charactersData, pageNumber: 1) { [weak self] (result) in
        switch result {
        case .success(let characterData) :
            
            self?.charactersData = characterData
            
            if let countRows =  characterData?.info.count {
                if let pagesCount = characterData?.info.pages{
            if let characters = characterData?.results{
            completionHandler(countRows, pagesCount, characters)
            }
                }
            }
        case .failure(let error):
            print(error)
        }
    }
    }
}
