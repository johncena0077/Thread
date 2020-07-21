//
//  ViewController.swift
//  Sample
//
//  Created by rajnikant on 17/09/19.
//  Copyright © 2019 rajnikant. All rights reserved.
//


import UIKit


class ViewController: UIViewController,UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        getData(search: text)
    }
    
    /**
     Properties.
     */
    
    static let annotationPadding: CGFloat = 4
    var model : Model?
    var viewModel : ViewModel = ViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    var pagination = Pagination()
    var listCollectionView : UICollectionView?
  
    
    private var _searchBar: UISearchController?
    public var searchBar: UISearchController {
    let controller = UISearchController(searchResultsController: nil)
    controller.searchResultsUpdater = self
    controller.dimsBackgroundDuringPresentation = false
    controller.searchBar.sizeToFit()
    controller.searchBar.barStyle = UIBarStyle.black
    controller.searchBar.barTintColor = UIColor.white
    controller.searchBar.backgroundColor = UIColor.clear
    return controller
    }
    /**
     Orinataion change method.
     */
    override open func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        listCollectionView?.collectionViewLayout.invalidateLayout()
        DispatchQueue.main.async{
            self.listCollectionView?.reloadData()
        }
        
    }
    
    override  func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("11 viewWillAppear")
    }
    
    override  func viewDidLoad() {
        super.viewDidLoad()
        self.setupInitialData()
        
  
    }
    
    /**
     Get list of data.
     */
    
    func getData(search:String) {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
          let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
          var homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
          let nav = UINavigationController(rootViewController: homeViewController)
          appdelegate.window!.rootViewController = nav
        /*
        if Connectivity.isConnectedToInternet() {
            
            self.viewModel.getList(searchString:search,pagination: self.pagination) {
                self.model = self.viewModel.model
                if let pages = self.model?.total_pages {
                    self.pagination.total_Pages = pages
                }
                self.listCollectionView?.reloadData()
            }
        }else {
            
            let alertController = UIAlertController(title: "Alert", message: "The Internet is not available", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
            
        }
        
        */
    }
}

