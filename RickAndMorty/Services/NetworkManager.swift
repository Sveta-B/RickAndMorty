//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Света Брасс on 18.05.21.
//

import Foundation
protocol NetworkManagerProtocol {
    func getData<T: Codable>(nameSection: Sections, typeResult: T?, pageNumber: Int, completionHandler: @escaping (Result<T?, Error>) -> Void)
}


struct NetworkManager: NetworkManagerProtocol {
 let baseURL = "https://rickandmortyapi.com/api/"
    

    func getData<T: Codable>(nameSection: Sections, typeResult: T?, pageNumber: Int, completionHandler: @escaping (Result<T?, Error>) -> Void)  {
        var json = typeResult
    let urlString = baseURL + "\(nameSection)?page=\(pageNumber)"
        print(urlString)
    guard  let url = URL(string: urlString) else { return }
       
    let session = URLSession(configuration: .default)
    let dataTask = session.dataTask(with: url) {(data, response, error) in
        guard let data = data  else {return}
        do {  json = try? JSONDecoder().decode(T.self, from: data)
            DispatchQueue.main.async {
                completionHandler(.success(json))
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    dataTask.resume()
        
    }

    
    func getCharacterData(stringURL: String, completionHandler: @escaping (Result<Character?, Error>) -> Void)  {
   
    guard  let url = URL(string: stringURL) else { return }
       
    let session = URLSession(configuration: .default)
    let dataTask = session.dataTask(with: url) {(data, response, error) in
        guard let data = data  else {return}
        
        do {  let json = try? JSONDecoder().decode(Character.self, from: data)
            completionHandler(.success(json))
            
//        } catch let error {
//            print(error.localizedDescription)
       }
    }
    dataTask.resume()
        
    }

}

