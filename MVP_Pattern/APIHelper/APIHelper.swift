//
//  APIHelper.swift
//  MVP_Pattern
//
//  Created by Sumit Ghosh on 19/01/19.
//  Copyright © 2019 Sumit Ghosh. All rights reserved.
//

import Foundation

class APIHelper {
    
    //MARK: get country list
    func getCountryList(completionHandler:@escaping([Country]?, Error?)->Void) -> Void {
        let urlstring = "\(NetworkConfigurations.BASE_URL)all"
        let url = URL.init(string: urlstring)
        
        URLSessionManager.share.getRequest(with: url!) { (data, error) in
            if error != nil {
                completionHandler([], error)
            } else {
                do {
                    let response = try JSONDecoder().decode([Country].self, from: data!)
                    completionHandler(response, error)
                } catch let error {
                    completionHandler([], error)
                }
            }
        }
    }
}
