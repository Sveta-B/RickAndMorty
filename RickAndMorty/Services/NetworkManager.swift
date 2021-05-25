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

class NetworkManager {
 
    func getData(nameSection: Sections, pageNumber: Int, completionHandler: @escaping (Result<CharacterData, Error>) -> Void) {
  let urlString = "https://rickandmortyapi.com/api/\(nameSection)?page=\(pageNumber)"
        guard  let url = URL(string: urlString) else {
            print("error url")
            return
        }
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) {(data, response, error) in
            
          
                if let data = data {
                    if let data = self.parseJSON(withData: data) {
                        completionHandler(.success(data))
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
    
    func parse<T: Codable>(withData data: Data) -> T?  {
        let decoder = JSONDecoder()
        var charactersData: T?
        do {
            charactersData =  try decoder.decode(T.self, from: data)
            }
           
        catch  let error as NSError {
            print(error.localizedDescription)
        }
        return charactersData
    }
}

