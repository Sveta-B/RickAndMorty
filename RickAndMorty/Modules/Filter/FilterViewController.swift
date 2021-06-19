//
//  FilterViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 19.06.21.
//

import UIKit

protocol FilterDisplayLogic: class {
  func displayData(viewModel: Filter.Model.ViewModel.ViewModelData)
}

class FilterViewController: UIViewController, FilterDisplayLogic {
    
    // MARK: Properties
    
  var interactor: FilterBusinessLogic?
  var router: (NSObjectProtocol & FilterRoutingLogic)?
    
    // MARK: @IBOutlets
    
    @IBOutlet weak var applyFiltersButton: UIButton!
    
    @IBOutlet weak var statusReset: UIButton!
    @IBOutlet weak var aliveButton: UIButton!
    @IBOutlet weak var deadButton: UIButton!
    @IBOutlet weak var statusUnknownButton: UIButton!
    @IBOutlet weak var aliveLabel: UILabel!
    @IBOutlet weak var deadLabel: UILabel!
    @IBOutlet weak var statusUnknownLabel: UILabel!
    
    
    @IBOutlet weak var genderReset: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var genderlessButton: UIButton!
    @IBOutlet weak var genderUnknownButton: UIButton!
    
    @IBOutlet weak var femaleLabel: UILabel!
    @IBOutlet weak var maleLabel: UILabel!
    @IBOutlet weak var genderlessLabel: UILabel!
    @IBOutlet weak var genderUnknownLabel: UILabel!

    // MARK: Initialization
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = FilterInteractor()
    let presenter             = FilterPresenter()
    let router                = FilterRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    statusReset.isEnabled = false
    genderReset.isEnabled = false
    applyFiltersButton.isEnabled = false
   
    
  }
    
    @IBAction func applyFiltersAction(_ sender: UIButton) {
        print("filters")
        
    }
    
    @IBAction func statusResetButtonAction(_ sender: UIButton) {
        self.aliveLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.deadLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.statusUnknownLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.aliveButton.isSelected = false
        self.deadButton.isSelected = false
        self.statusUnknownButton.isSelected = false
        statusReset.isEnabled = false
        applyFiltersButton.isEnabled = false
    }
    
    @IBAction func statusButtonAction(_ sender: UIButton) {
        if sender.tag == 0 {
            self.aliveLabel.textColor = #colorLiteral(red: 0.6772206426, green: 0.8038287163, blue: 0.2435124815, alpha: 1)
            self.deadLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.statusUnknownLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.aliveButton.isSelected = true
        self.deadButton.isSelected = false
        self.statusUnknownButton.isSelected = false
            statusReset.isEnabled = true
            applyFiltersButton.isEnabled = true
        } else if sender.tag == 1 {
            self.aliveLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.deadLabel.textColor = #colorLiteral(red: 0.6772206426, green: 0.8038287163, blue: 0.2435124815, alpha: 1)
            self.statusUnknownLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.aliveButton.isSelected = false
            self.deadButton.isSelected = true
            self.statusUnknownButton.isSelected = false
            statusReset.isEnabled = true
            applyFiltersButton.isEnabled = true
            } else if sender.tag == 2 {
                self.aliveLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.deadLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.statusUnknownLabel.textColor = #colorLiteral(red: 0.6772206426, green: 0.8038287163, blue: 0.2435124815, alpha: 1)
                self.aliveButton.isSelected = false
                self.deadButton.isSelected = false
                self.statusUnknownButton.isSelected = true
                statusReset.isEnabled = true
                applyFiltersButton.isEnabled = true
                }
    }
    

    
    @IBAction func genderResetButtonAction(_ sender: UIButton) {
        
        self.femaleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.maleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.genderlessLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.genderUnknownLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.femaleButton.isSelected = false
        self.maleButton.isSelected = false
        self.genderlessButton.isSelected = false
        self.genderUnknownButton.isSelected = false
        genderReset.isEnabled = false
        applyFiltersButton.isEnabled = false
     
    }
    @IBAction func genderButtonAction (_ sender: UIButton) {
        if sender.tag == 0 {
            self.femaleLabel.textColor = #colorLiteral(red: 0.6772206426, green: 0.8038287163, blue: 0.2435124815, alpha: 1)
            self.maleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.genderlessLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.genderUnknownLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.femaleButton.isSelected = true
            self.maleButton.isSelected = false
            self.genderlessButton.isSelected = false
            self.genderUnknownButton.isSelected = false
            genderReset.isEnabled = true
            applyFiltersButton.isEnabled = true
        } else if sender.tag == 1 {
            self.femaleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.maleLabel.textColor = #colorLiteral(red: 0.6772206426, green: 0.8038287163, blue: 0.2435124815, alpha: 1)
            self.genderlessLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.genderUnknownLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.femaleButton.isSelected = false
            self.maleButton.isSelected = true
            self.genderlessButton.isSelected = false
            self.genderUnknownButton.isSelected = false
            genderReset.isEnabled = true
            applyFiltersButton.isEnabled = true
        } else if sender.tag == 2 {
            self.femaleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.maleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.genderlessLabel.textColor = #colorLiteral(red: 0.6772206426, green: 0.8038287163, blue: 0.2435124815, alpha: 1)
            self.genderUnknownLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.femaleButton.isSelected = false
            self.maleButton.isSelected = false
            self.genderlessButton.isSelected = true
            self.genderUnknownButton.isSelected = false
            genderReset.isEnabled = true
            applyFiltersButton.isEnabled = true
        } else if sender.tag == 3 {
            self.femaleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.maleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.genderlessLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.genderUnknownLabel.textColor = #colorLiteral(red: 0.6772206426, green: 0.8038287163, blue: 0.2435124815, alpha: 1)
            self.femaleButton.isSelected = false
            self.maleButton.isSelected = false
            self.genderlessButton.isSelected = false
            self.genderUnknownButton.isSelected = true
            genderReset.isEnabled = true
            applyFiltersButton.isEnabled = true
        }
    }
   
  
  func displayData(viewModel: Filter.Model.ViewModel.ViewModelData) {

  }
  
}
