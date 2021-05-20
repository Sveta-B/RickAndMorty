//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Света Брасс on 18.05.21.
//

import Foundation

enum Sections {
    case character
    case location
    case episode
}

struct NetworkManager {
    
    let charactersURL = "https://rickandmortyapi.com/api/character"
    let locationsURL =  "https://rickandmortyapi.com/api/location"
    let episodesURL = "https://rickandmortyapi.com/api/episode"
 
    
    func getData(nameSection: Sections, completionHandler: @escaping (CharacterData ) -> Void) {
  let urlString = "https://rickandmortyapi.com/api/\(nameSection)"
        guard  let url = URL(string: urlString) else {
            print("error url")
            return
        }
        let session = URLSession(configuration: .default)
           let dataTask = session.dataTask(with: url) {(data, response, error) in
            if let data = data {
                if let characters = self.parseJSON(withData: data) {
                    completionHandler(characters)
                }
                }
}
        dataTask.resume()
        }
    
    func parseJSON(withData data: Data) -> CharacterData?  {
        let decoder = JSONDecoder()
        var charactersData: CharacterData?
        do {
            charactersData =  try decoder.decode(CharacterData.self, from: data)
            }
           
        catch  let error as NSError {
            print(error.localizedDescription)
        }
        return charactersData
    }
}

