//
//  Tect.swift
//  RickAndMorty
//
//  Created by Света Брасс on 24.05.21.
//

import Foundation


class NetManager {
 
    
    func getData<T: Codable>(nameSection: Sections, number: Int, completionHandler: @escaping (T) -> Void) {
  let urlString = "https://rickandmortyapi.com/api/\(nameSection)?page=\(number)"
        guard  let url = URL(string: urlString) else {
            print("error url")
            return
        }
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) {(data, response, error) in
            if let data = data {
//                if let json =  self.parseJSON(withData: data) {
//                    completionHandler(json)
//                }
                }
        }

        dataTask.resume()
        
        }
    
    func parseJSON<T: Codable>(withData data: Data) -> T?  {
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
