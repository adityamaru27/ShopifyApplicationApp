//
//  APIResources.swift
//  ShopifyApp
//
//  Created by Aditya Maru on 2017-08-29.
//  Copyright © 2017 Aditya Maru. All rights reserved.
//

import Foundation

struct APIWrapper {
    let orders : [Serialization]!
}

extension APIWrapper {
    private enum Keys : String, SerializationKey {
        case orders
    }
    
    init(serialization : Serialization) {
        orders = serialization.value(forKey: Keys.orders) ?? []
    }
}

protocol APIResource {
    associatedtype Model
    func makeModel(serialization : Serialization) -> Model
}

extension APIResource {
    var url : URL {
        let url : String = "https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        return URL(string: url)!
    }
    
    func makeModel(data: Data) -> [Model]? {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            else {
                return nil
        }
        guard let jsonSerialization = json as? Serialization
            else {
                return nil
        }
        let wrapper = APIWrapper(serialization: jsonSerialization)
        return wrapper.orders.map(makeModel(serialization:))
    }
}

struct OrderResource : APIResource {
    func makeModel(serialization: Serialization) -> OrderModel {
        return OrderModel(serialization: serialization)
    }
}
