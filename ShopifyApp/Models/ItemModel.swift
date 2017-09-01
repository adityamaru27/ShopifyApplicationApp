//
//  ItemModel.swift
//  ShopifyApp
//
//  Created by Aditya Maru on 2017-08-29.
//  Copyright © 2017 Aditya Maru. All rights reserved.
//

import Foundation

struct ItemModel {
    let title : String!
    let quantity : Int!
}

extension ItemModel {
    private enum Keys : String, SerializationKey {
        case title
        case quantity
    }
    
    init(serialization : Serialization) {
        title = serialization.value(forKey: Keys.title)
        quantity = serialization.value(forKey: Keys.quantity)
    }
}
