//
//  Serialization.swift
//  ShopifyApp
//
//  Created by Aditya Maru on 2017-08-29.
//  Copyright © 2017 Aditya Maru. All rights reserved.
//

import Foundation

typealias Serialization = [String : Any]

protocol SerializationKey {
    var stringValue : String { get }
}

extension RawRepresentable where RawValue == String {
    var stringValue : String {
        return rawValue
    }
}

protocol SerializationValue {}

extension String : SerializationValue {}
extension Dictionary : SerializationValue {}
extension Array : SerializationValue {}
extension Int : SerializationValue {}

extension Dictionary where Key == String, Value: Any {
    func value<V: SerializationValue>(forKey key: SerializationKey) -> V? {
        return self[key.stringValue] as? V
    }
}

