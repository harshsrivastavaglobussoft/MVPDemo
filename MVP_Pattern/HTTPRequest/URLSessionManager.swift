//
//  URLSessionManager.swift
//  MVP_Pattern
//
//  Created by Sumit Ghosh on 19/01/19.
//  Copyright © 2019 Sumit Ghosh. All rights reserved.
//

import Foundation

class URLSessionManager {
   static let share = URLSessionManager()
    
    //MARK: GET Methods
    func getRequest(with url: URL, completionHandler: @escaping (Data?, Error?) -> Void) -> Void {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        
        let sessionTask = URLSession.shared
        sessionTask.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                completionHandler(nil, error)
                return
            }
            
            let httpResponse: HTTPURLResponse = response as! HTTPURLResponse
            if httpResponse.statusCode == 200 {
                completionHandler(data, nil)
            }
            else {
                completionHandler(nil, error)
            }
            }.resume()
        sessionTask.finishTasksAndInvalidate()
    }
}

