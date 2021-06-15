//
//  CustomCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Света Брасс on 4.06.21.
//

import UIKit
protocol CustomCollectionViewCellProtocol {
    var name: String { get }
    var type: String? { get }
    var  dimension: String? { get }
    var residents: [String]? { get }
}

class CustomCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var typeSecondLabel: UILabel!
    @IBOutlet weak var typeThirdLabel: UILabel!
    @IBOutlet weak var typeFourthLabel: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 10
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
    }

    @IBAction func showСharacters(_ sender: UIButton) {
        
        
    }
    
    func set(viewModel: CustomCollectionViewCellProtocol) {
        nameLabel.text = viewModel.name
        thirdLabel.text = viewModel.type
        secondLabel.text = viewModel.dimension
    
    }
    
}