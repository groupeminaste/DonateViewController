/*
*  Copyright (C) 2020 Groupe MINASTE
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License along
* with this program; if not, write to the Free Software Foundation, Inc.,
* 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*
*/

import Foundation
import UIKit
import StoreKit

open class DonateViewController: UITableViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    /// Delegate
    public weak var delegate: DonateViewControllerDelegate?
    
    /// Cell class
    private let cellClass: DonateCell.Type
    
    /// Donations
    private var donations = [Donation]()
    
    /// Payment queue
    private let paymentQueue = SKPaymentQueue()
    
    /// Strong reference to request
    private var request: SKProductsRequest?
    
    /// View header
    public var header: String?
    
    /// View footer
    public var footer: String?
    
    /// Initializer
    public init(style: UITableView.Style = .grouped, cellClass: DonateCell.Type = DonateCell.self) {
        // Save cell class
        self.cellClass = cellClass
        
        // Init the table view as a grouped one
        super.init(style: style == .plain ? .grouped : style)
    }
    
    /// Initializer with a custom style
    public override init(style: UITableView.Style) {
        // Set default cell class
        self.cellClass = DonateCell.self
        
        // Init, but replace plain with grouped
        super.init(style: style == .plain ? .grouped : style)
    }
    
    /// Required init (not implemented)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Load the view
    open override func viewDidLoad() {
        // Call super class
        super.viewDidLoad()

        // Register cell
        tableView.register(cellClass, forCellReuseIdentifier: "donateCell")
        
        // Add the observer
        paymentQueue.add(self)
        
        // Update data
        updateDonationProducts()
    }
    
    /// Add a donation to the view controller
    public func add(identifier: String) {
        // Add the new donation to the list
        self.donations.append(Donation(identifier: identifier))
    }
    
    /// Update donation datas
    public func updateDonationProducts() {
        // Create a request
        request = SKProductsRequest(productIdentifiers: Set(donations.filter({ $0.product == nil }).map({ $0.identifier })))
        request?.delegate = self
        request?.start()
    }
    
    /// Number of sections in the donate view controller
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// Number of rows in the section
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return donations.count
    }
    
    /// Set header for section
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return header
    }
    
    /// Set footer for section
    public override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return footer
    }
    
    /// Create a cell
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Return a cell with the donation object
        return (tableView.dequeueReusableCell(withIdentifier: "donateCell", for: indexPath) as! DonateCell).with(donation: donations[indexPath.row])
    }
    
    /// Handle when a row is selected
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the product
        guard let product = donations[indexPath.row].product else { return }
        
        // Create a payment
        let payment = SKPayment(product: product)
        
        // Add it to queue
        paymentQueue.add(payment)
    }
    
    /// Handle response from product request
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        // Iterate products
        for product in response.products {
            // Set it to corresponding donation
            donations.first(where: { $0.identifier == product.productIdentifier })?.product = product
        }
        
        // Reload the table view data
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    /// Handle when transactions are updated
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        // Iterate transactions
        for transaction in transactions {
            // Get the corresponding donation
            if let donation = donations.first(where: { $0.identifier == transaction.payment.productIdentifier }) {
                // Check the transaction state
                if transaction.transactionState == .purchased {
                    // Donation succeed
                    delegate?.donateViewController(self, didDonationSucceed: donation)
                } else if transaction.transactionState == .failed {
                    // Donation failed
                    delegate?.donateViewController(self, didDonationFailed: donation)
                }
                
                // End the transaction if needed
                if transaction.transactionState != .purchasing {
                    // Finish transaction if not purchasing state
                    queue.finishTransaction(transaction)
                }
            }
        }
    }
    
}
