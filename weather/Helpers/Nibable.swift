//
//  Nibable.swift
//  weather
//
//  Created by Mickael Laloum on 05/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import UIKit

protocol Nibable {
    static var nibBundle: Bundle { get }
    static var nibName: String { get }
    static var nib: UINib { get }
}

extension Nibable {
    
    static var nibBundle: Bundle {
        return Bundle.main
    }
    
    static var nibName: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: self.nibName, bundle: self.nibBundle)
    }
}
