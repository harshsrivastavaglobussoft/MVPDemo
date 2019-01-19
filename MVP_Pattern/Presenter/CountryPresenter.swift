//
//  CountryPresenter.swift
//  MVP_Pattern
//
//  Created by Sumit Ghosh on 19/01/19.
//  Copyright © 2019 Sumit Ghosh. All rights reserved.
//

import Foundation
import UIKit

//protocols for controller
protocol presenterDelegate:NSObjectProtocol {
    func startLoading() -> Void
    func dataReceived(countryArray:[Country]) -> Void
    func finishLoading() -> Void
    func dataEmpty() -> Void
}

class CountryPresenter {
    fileprivate let apihelper:APIHelper!
    weak fileprivate var delegate: presenterDelegate?
    
    //init function
    init(apiHelper:APIHelper) {
        self.apihelper = apiHelper
    }
    
    //attaching the controller to presenter
    //NOTE* in MVP  ViewController and View are considered as single unit i.e View
    func attachViewToPresenter(_ view:presenterDelegate) {
        delegate = view
    }
    
    //detaching the controller from presenter
    func detachView() -> Void {
        delegate = nil
    }
    
    //get country data from API
    func getCountryList() {
        //calling view controller methods using protocol
        //start loading function
        self.delegate?.startLoading()
        apihelper.getCountryList { (countryArray, error) in
            DispatchQueue.main.async { [unowned self] in
                //finish loading function
                self.delegate?.finishLoading()
                if countryArray?.count == 0 {
                    //if array is empty
                    self.delegate?.dataEmpty()
                } else {
                    //if fetch data is successfull
                    self.delegate?.dataReceived(countryArray: countryArray!)
                }
            }
        }
    }
}
