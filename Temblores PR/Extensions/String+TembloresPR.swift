//
//  String+TembloresPR.swift
//  Temblores PR
//
//  Created by Eduardo Moll on 1/10/20.
//  Copyright © 2020 eduardo moll. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
