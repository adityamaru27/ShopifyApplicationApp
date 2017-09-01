//
//  NetworkRequest.swift
//  ShopifyApp
//
//  Created by Aditya Maru on 2017-08-30.
//  Copyright © 2017 Aditya Maru. All rights reserved.
//

import Foundation
import UIKit

protocol NetworkRequest {
    associatedtype Model
    func load(withCompletion completion:@escaping (Model?) -> Void)
    func decode(_ data : Data) -> Model?
}

extension NetworkRequest {
    fileprivate func load(_ url : URL, withCompletion completion : @escaping (Model?) -> Void) {
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        let sessionTask = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data else {
                completion(nil)
                return
            }
            completion(self.decode(data))
        })
        sessionTask.resume()
    }
}

class APIRequest<Resource : APIResource> {
    let resource : Resource
    
    init(resource : Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequest {
    func decode(_ data: Data) -> [Resource.Model]? {
        return resource.makeModel(data: data)
    }
    
    func load(withCompletion completion: @escaping ([Resource.Model]?) -> Void) {
        load(resource.url, withCompletion: completion)
    }
}
