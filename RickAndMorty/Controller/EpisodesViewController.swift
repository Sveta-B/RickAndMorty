//
//  EpisodesViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 28.05.21.
//

import UIKit

class EpisodesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    private var episodes: [Episode]? {
        didSet {
            print(episodes)
        }
    }
    private var episodeData: EpisodeData?
    private let networkManager = NetworkManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episodes"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.NibName.CustomTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: Constants.ReuseIdentifier.EpisodeTableViewCell.rawValue)
        networkManager.getData(nameSection: .episode, typeResult: episodeData, pageNumber: 1) { [weak self](result) in
         
            switch result {
            case .success(let data):
                self?.episodes = data?.results
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return episodes?.count ?? 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ReuseIdentifier.EpisodeTableViewCell.rawValue, for: indexPath) as! CustomTableViewCell
        cell.dateLabel.text = self.episodes?[indexPath.row].name
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 200 //or whatever you need
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
