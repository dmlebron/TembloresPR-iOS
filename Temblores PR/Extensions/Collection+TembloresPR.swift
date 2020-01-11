//
//  Collection+TembloresPR.swift
//  Temblores PR
//
//  Created by Eduardo Moll on 1/10/20.
//  Copyright © 2020 eduardo moll. All rights reserved.
//

import Foundation

extension RandomAccessCollection where Self.Element == Earthquake {
    func isLastItem(_ item: Earthquake) -> Bool {
        guard !isEmpty else {
            return false
        }
        
        guard let itemIndex = firstIndex(where: { $0.id == item.id }) else {
            return false
        }
        
        let distance = self.distance(from: itemIndex, to: endIndex)
        return distance == 1
    }
}
