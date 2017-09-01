//
//  ShopifyViewController.swift
//  ShopifyApp
//
//  Created by Aditya Maru on 2017-08-29.
//  Copyright © 2017 Aditya Maru. All rights reserved.
//

import Foundation
import UIKit

class ShopifyViewController : UIViewController {
    @IBOutlet weak var amountTitleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var numberOfBagsTitleLabel: UILabel!
    @IBOutlet weak var numberOfBagsLabel: UILabel!
    
    var orderCollection : [OrderModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchOrders()
    }
    
    func fetchOrders() {
        let orderResource = OrderResource()
        let orderRequest = APIRequest(resource: orderResource)
        orderRequest.load { (orders: [OrderModel]?) in
            guard let orders = orders
                else {
                    return
            }
            self.orderCollection = orders
            self.parseOrders()
        }
    }
    
    func parseOrders() {
        var total = 0
        for order in orderCollection {
            if (order.customer != nil) && order.customer!.firstName == "Napoleon" &&
                order.customer!.lastName == "Batz" {
                amountLabel.text = order.customer!.totalSpent
            }
            
            let filteredItems = order.lineItems.filter{
                self.checkItemTitle(item: $0)
            }
            for x in filteredItems {
                total += x.quantity
            }
        }
        self.numberOfBagsLabel.text =t String(total)
    }
    
    func checkItemTitle(item: ItemModel) -> Bool {
        return item.title! == "Awesome Bronze Bag"
    }
}
