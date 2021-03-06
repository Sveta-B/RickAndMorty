//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Света Брасс on 18.05.21.
//

import Foundation
protocol NetworkManagerProtocol {
    
    func fetchData<T: Codable>(stringURL: String, typeResult: T?,completionHandler: @escaping (Result<T?, Error>) -> Void) 
}


struct NetworkManager: NetworkManagerProtocol {
    
    
    func fetchData<T: Codable>(stringURL: String, typeResult: T?,completionHandler: @escaping (Result<T?, Error>) -> Void)  {
        var json = typeResult
        guard  let url = URL(string: stringURL) else { return }
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) {(data, response, error) in
            guard let data = data  else {return}
            do { json = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(.success(json))
                }
            } catch let error {
                completionHandler(.failure(error))
                print(error.localizedDescription)
            }
        }
        dataTask.resume()
    }
}
