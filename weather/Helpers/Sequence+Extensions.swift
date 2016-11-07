//
//  Array.swift
//  weather
//
//  Created by Mickael Laloum on 02/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import Foundation


extension Sequence {
    
    public func grouped<T: Hashable>(by group: (Self.Iterator.Element) -> T ) -> [T: [Self.Iterator.Element]] {
        return self.reduce([:]) { result, element in
            var res = result
            let key = group(element)
            var groupList = res[key] ?? []
            groupList += [element]
            res[key] = groupList
            return res
        }
    }
}
