//
//  LaunchViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 22.06.21.
//

import UIKit

class LaunchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "NavigationViewController") as! NavigationViewController
            viewController.modalPresentationStyle = .fullScreen
            viewController.modalTransitionStyle = .flipHorizontal
            
            self.present(viewController, animated: true, completion: nil)
            
        })
        animation()
        
    }
    
    @IBOutlet weak var cucumberImage: UIImageView!
    
    func animation() {
        
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        rotation.toValue = Double.pi * 4
        rotation.duration = 4.00
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.cucumberImage.layer.add(rotation, forKey: "rotationAnimation")
    }
}
