//
//  UITableView+Extension.swift
//  weather
//
//  Created by Mickael Laloum on 05/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(cell: T.Type) where T: Nibable & Reusable {
        register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeue<T: UITableViewCell>(cell: T.Type, for indexPath: IndexPath) -> T where T: Nibable & Reusable {
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func register<T: UITableViewHeaderFooterView>(headerFooter: T.Type) where T: Nibable & Reusable {
        register(T.nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeue<T: UITableViewHeaderFooterView>(headerFooter: T.Type) -> T where T: Nibable & Reusable {
        return dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T
    }
}

extension UITableViewCell: Reusable, Nibable {}
extension UITableViewHeaderFooterView: Reusable, Nibable {}
