//
//  ChooseSectionViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 18.06.21.
//

import UIKit

protocol ChooseSectionDisplayLogic: class {
  func displayData(viewModel: ChooseSection.Model.ViewModel.ViewModelData)
}

class ChooseSectionViewController: ParentCollectionViewController, ChooseSectionDisplayLogic {
  
    // MARK: Properties
    
  private var interactor: ChooseSectionBusinessLogic?
  var router: (NSObjectProtocol & ChooseSectionRoutingLogic)?
    var sections: [Section]? {
        willSet {
            if newValue != nil {
                collectionView.reloadData()
            }
        }
    }

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
    let interactor            = ChooseSectionInteractor()
    let presenter             = ChooseSectionPresenter()
    let router                = ChooseSectionRouter()
    let networkManager        = NetworkManager()
    interactor.networkManager = networkManager
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    interactor?.makeRequest(request: .getSections)
    
  }
    
    // MARK: ChooseSectionDisplayLogic
    func displayData(viewModel: ChooseSection.Model.ViewModel.ViewModelData) {
      switch viewModel {
      
      case .displaySections(sections: let sections):
          self.sections = sections
      }
    }
    
    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections?.count ?? 0
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.ReuseIdentifier.SectionCollectionViewCell.rawValue, for: indexPath) as! SectionCollectionViewCell
        
        let section = sections?[indexPath.item]
        cell.nameSectionLabel.text = section?.name
        cell.imageForSection.image = UIImage(named: section?.name ?? "")
        return cell
        
    }
    
    // MARK: - Navigation
    
        override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            collectionView.deselectItem(at: indexPath, animated: true)
            let section = self.sections?[indexPath.item]
            switch indexPath {
            case [0, 0]:
                router?.sendingURL(url: section?.url ?? "", name: section?.name ?? "")
            case [0, 1]:
                router?.sendingURL(url: section?.url ?? "", name: section?.name ?? "")
            case [0, 2]:
                router?.sendingURL(url: section?.url ?? "", name: section?.name ?? "")
            default:
                return
            }
        }
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
         let hight = (Int(hightScreen) - Int(Constants.minimumSpacing) * 5 - Constants.hightTabBar) / 3
         let wight = Int(wightScreen) - Int(Constants.minimumSpacing) * 2
        return CGSize(width: wight, height: hight)
     }
    
    
  
}
