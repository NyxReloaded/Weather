//
//  UICollectionView.swift
//  weather
//
//  Created by Mickael Laloum on 05/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(cell: T.Type) where T: Nibable & Reusable {
        register(T.nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeue<T: UICollectionViewCell>(cell: T.Type, for indexPath: IndexPath) -> T where T: Nibable & Reusable {
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    func dequeue<T: UICollectionReusableView>(view: T.Type, ofKind elementKind: String, for indexPath: IndexPath) -> T where T: Nibable & Reusable {
        return dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}

extension UICollectionReusableView: Reusable, Nibable  {}
