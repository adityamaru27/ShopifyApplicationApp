//
//  OrderModel.swift
//  ShopifyApp
//
//  Created by Aditya Maru on 2017-08-30.
//  Copyright © 2017 Aditya Maru. All rights reserved.
//

import Foundation

struct OrderModel {
    let customer : CustomerModel?
    let lineItems : [ItemModel]!
}

extension OrderModel{
    private enum Keys : String, SerializationKey {
        case lineItems = "line_items"
        case customer
    }
    
    init(serialization : Serialization) {
        if let itemSerialization : [Serialization] = serialization.value(forKey: Keys.lineItems) {
            lineItems = Array()
            for item in itemSerialization {
                lineItems.append(ItemModel(serialization: item))
            }
        }
        else {
            lineItems = []
        }
        if let customerSerialization : Serialization = serialization.value(forKey: Keys.customer) {
            customer = CustomerModel(serialization: customerSerialization)
        }
        else {
            customer = nil
        }
    }
}
