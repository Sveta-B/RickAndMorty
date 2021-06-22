//
//  NavigationViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 17.05.21.
//

import UIKit

class NavigationViewController: UINavigationController {
    
    override func viewWillAppear(_ animated: Bool) {
        navigationBar.topItem?.title = ""
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.setValue(true, forKey : "hidesShadow" )
        navigationBar.barTintColor = #colorLiteral(red: 0.1491553485, green: 0.1692692935, blue: 0.2072440982, alpha: 1)
        navigationBar.tintColor = #colorLiteral(red: 0.1472979188, green: 0.8754439354, blue: 0.4968790412, alpha: 1)
       

       
        
    }

   
}
