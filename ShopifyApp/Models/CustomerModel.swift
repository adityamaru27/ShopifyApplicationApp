//
//  CustomerModel.swift
//  ShopifyApp
//
//  Created by Aditya Maru on 2017-08-29.
//  Copyright © 2017 Aditya Maru. All rights reserved.
//

import Foundation

struct CustomerModel {
    let firstName : String!
    let lastName : String!
    let totalSpent : String!
}

extension CustomerModel {
    private enum Keys : String, SerializationKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case totalSpent = "total_spent"
    }
    
    init(serialization : Serialization) {
        firstName = serialization.value(forKey: Keys.firstName)
        lastName = serialization.value(forKey: Keys.lastName)
        totalSpent = serialization.value(forKey: Keys.totalSpent)
    }
}
