//
//  ViewModel.swift
//  Sample
//
//  Created by rajnikant on 17/09/19.
//  Copyright © 2019 rajnikant. All rights reserved.
//


import UIKit

class ViewModel: NSObject {

    var model : Model?
    /**
     Get list API call.
     */
    func getList(searchString:String,pagination:Pagination, completion: @escaping () -> Void) {
        
        ApiClient.sharedInstance.fetApiRequest(url: String(format: "\(url)page=\(pagination.pageNumber)&query=\(searchString)")) { (result) in
            
            DispatchQueue.main.async {
                self.model = result
                completion()
            }
        }
        
    }
    
}
