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

open class DonateCell: UITableViewCell {
    
    public let loading = UIActivityIndicatorView()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        
        // Add loading indicator to cell
        contentView.addSubview(loading)
        
        // Configure it
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.centerXAnchor.constraint(equalTo: contentView.layoutMarginsGuide.centerXAnchor).isActive = true
        loading.centerYAnchor.constraint(equalTo: contentView.layoutMarginsGuide.centerYAnchor).isActive = true
        loading.hidesWhenStopped = true
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult
    open func with(donation: Donation) -> DonateCell {
        // Check if the product is loaded
        if let product = donation.product {
            // Set the text
            textLabel?.text = product.localizedTitle
            detailTextLabel?.text = product.localizedPrice
            
            // Stop loading if required
            if loading.isAnimating {
                loading.stopAnimating()
            }
        } else {
            // Clear the text
            textLabel?.text = nil
            detailTextLabel?.text = nil
            
            // Start loading if required
            if !loading.isAnimating {
                loading.startAnimating()
            }
        }
        
        return self
    }
    
}
