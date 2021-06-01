//
//  EpisodesViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 28.05.21.
//

import UIKit

class EpisodesViewController: UIViewController {
    var episodes: [Episode]? {
        didSet {
            print(episodes)
        }
    }
    var episodeData: EpisodeData?
    private let networkManager = NetworkManager()
    
    
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episodes"
        networkManager.getData(nameSection: .episode, typeResult: episodeData, pageNumber: 1) { [weak self](result) in
         
            switch result {
            case .success(let data):
                self?.episodes = data?.results
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
        
        
    }
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
