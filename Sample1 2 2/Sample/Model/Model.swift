//
//  Model.swift
//  Sample
//
//  Created by rajnikant on 17/09/19.
//  Copyright © 2019 rajnikant. All rights reserved.
//


import Foundation


struct Model : Codable {
    let total_pages : Int?
    let results : [Results]?
    
    enum CodingKeys: String, CodingKey {
        
        case total_pages = "total_pages"
        case results = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
        results = try values.decodeIfPresent([Results].self, forKey: .results)
    }
    
}

struct Results : Codable {

    let urls : Dictionary<String, String>?
    
    enum CodingKeys: String, CodingKey {
        case urls = "urls"    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        urls = try values.decodeIfPresent([String:String].self, forKey: .urls)
    }
    
}

