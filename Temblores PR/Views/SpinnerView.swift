//
//  SpinnerView.swift
//  Temblores PR
//
//  Created by Eduardo Moll on 1/9/20.
//  Copyright © 2020 eduardo moll. All rights reserved.
//

import Foundation
import SwiftUI

struct SpinnerView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .large)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        uiView.startAnimating()
    }
}
