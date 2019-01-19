//
//  CountryModel.swift
//  MVP_Pattern
//
//  Created by Sumit Ghosh on 19/01/19.
//  Copyright © 2019 Sumit Ghosh. All rights reserved.
//

import Foundation

//country data model
struct Country: Decodable {
    let name: String?
    let capital: String?
}
