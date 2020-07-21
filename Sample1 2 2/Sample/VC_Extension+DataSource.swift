//
//  VC_Extension+DataSource.swift
//  Sample
//
//  Created by rajnikant on 17/09/19.
//  Copyright © 2019 rajnikant. All rights reserved.
//


import UIKit
import Foundation
import AlamofireImage

class Pagination {
    var pageNumber : Int = 1
    var total_Pages : Int = 0
}
/**
 Extension of ViewController and UICollectionViewDataSource,PinterestLayoutDelegate implemention.
 */
extension ViewController : UICollectionViewDataSource ,UICollectionViewDelegate,  PinterestLayoutDelegate  {
   
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.model?.results?.count ?? 0
        
    }
    
    public func collectionView(collectionView: UICollectionView,
                               heightForImageAtIndexPath indexPath: IndexPath,
                               withWidth: CGFloat) -> CGFloat {
        
        return  150
    }
    
    public func collectionView(collectionView: UICollectionView,
                               heightForAnnotationAtIndexPath indexPath: IndexPath,
                               withWidth: CGFloat) -> CGFloat {
        return  PinterestCell.annotationPadding + PinterestCell.annotationPadding
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: pinterestCellIdentifier,
            for: indexPath) as! PinterestCell
        
        let object  = self.model?.results? [indexPath.row]
        if let url = object?.urls?["full"],let urlPath = URL(string:(url)) {
            let placeholderImage = UIImage(named: imgPlaceholder)!
            cell.imageView.af_setImage(withURL: urlPath, placeholderImage: placeholderImage)
            
        }else {
            cell.imageView.image = UIImage(named: imgPlaceholder)!
        }
        cell.roundedCornersView.backgroundColor = UIColor.white
        cell.roundedCornersView.setAsCardBackground()
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        print("...........................")
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("...........................")
    }
     func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
    
    }
    
}

/**
 Extension addView methods
 */

extension ViewController :UISearchControllerDelegate,UISearchBarDelegate{
    
    func setupInitialData() {
        self.view.backgroundColor = .gray
        let layout = PinterestLayout()
        listCollectionView?.collectionViewLayout = layout
        listCollectionView?.delegate = self
        layout.delegate = self
        layout.cellPadding = 5
        layout.numberOfColumns = 2
        listCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        self.view.addSubview(listCollectionView! )
        self.addConstraintsForCollection()
        setupCollectionViewInsets()
        listCollectionView?.register(
            PinterestCell.self,
            forCellWithReuseIdentifier: pinterestCellIdentifier
        )
        
        listCollectionView?.contentInset = UIEdgeInsets(
            top: 20,
            left: 5,
            bottom: 49,
            right: 5
        )
        listCollectionView?.dataSource = self
        listCollectionView?.reloadData()
        
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search..."
        searchController.searchBar.sizeToFit()
        searchController.searchBar.becomeFirstResponder()
        self.navigationItem.titleView = searchController.searchBar
        
        self.definesPresentationContext = true
        self.searchController.searchBar.placeholder = "Search for Items"
    }
    
    func setupCollectionViewInsets() {
        listCollectionView?.backgroundColor = .clear
        listCollectionView?.contentInset = UIEdgeInsets(
            top: 15,
            left: 5,
            bottom: 5,
            right: 5
        )
    }
    
    func addConstraintsForCollection() {
        
        if let collectionView = self.listCollectionView {
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            collectionView.bottomAnchor.constraint(equalTo:self.view.bottomAnchor).isActive = true
            collectionView.trailingAnchor.constraint(equalTo:self.view.trailingAnchor).isActive = true
        }
    }
    
}

