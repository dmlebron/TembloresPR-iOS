//
//  InfoView.swift
//  Temblores PR
//
//  Created by Eduardo Moll on 1/7/20.
//  Copyright © 2020 eduardo moll. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    
    let title: String
    let detail: String
    
    var body: some View {
        HStack(alignment: .center) {
            Text(NSLocalizedString(title, comment: ""))
                .font(.body)
            Spacer()
            Text(NSLocalizedString(detail, comment: ""))
                .foregroundColor(.secondary)
        }
        .padding(.horizontal)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(title: "Title", detail: "Detail")
    }
}
