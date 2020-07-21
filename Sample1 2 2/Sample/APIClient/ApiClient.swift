//
//  ApiClient.swift
//  Sample
//
//  Created by rajnikant on 17/09/19.
//  Copyright © 2019 rajnikant. All rights reserved.
//


import Foundation
import Alamofire

class ApiClient: NSObject {
    static let sharedInstance = ApiClient()
    private override init() {
        
    }
    
    /**
     Get API  Call.
     */
    func fetApiRequest(url : String, completion:@escaping ( Model) -> () ) {
        
        let headers = [
            "Authorization": "Client-ID 4331571bef6babadd0623a46056ac27ef94e66bfdb74fd1750df1c02efefd5d9"
        ]
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<600)
            .responseString { (jsonData) in
                do {
                    if let value = jsonData.result.value {
                        print("value \(value)")
                        let data = Data(value.utf8)
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(Model.self, from: data)
                        completion(responseModel)
                    }
                    
                }
                catch{
                    print("error")
                }
                
        }
        
    }
    
    
    
}

