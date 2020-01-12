//
//  EmptyStateView.swift
//  Temblores PR
//
//  Created by Eduardo Moll on 1/11/20.
//  Copyright © 2020 eduardo moll. All rights reserved.
//

import SwiftUI

struct EmptyStateView: View {
    
    let title: String?
    let message: String
    let buttonTitle: String
    let buttonAction: () -> Void
    
    var body: some View {
        
        VStack {
            Spacer()
            
            VStack(spacing: 12) {
                Text(NSLocalizedString(title ?? "", comment: ""))
                    .font(.body)
                    .fontWeight(.bold)
            
                Text(NSLocalizedString(message, comment: ""))
                    .multilineTextAlignment(.center)
            }
    
            Spacer()
            
            Button(action: buttonAction) {
                Text(NSLocalizedString(self.buttonTitle, comment: ""))
                    .font(.body)
                    .fontWeight(.medium)
                    .frame(height: 44)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.primary)
                    .foregroundColor(Color("buttonTitle"))
                .cornerRadius(5)
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 20)
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            EmptyStateView(
                title: "Failed To Load",
                message: "Try Again Message",
                buttonTitle: "Try Again",
                buttonAction: {})
            
            EmptyStateView(
                title: "Failed To Load",
                message: "Try Again Message",
                buttonTitle: "Try Again",
                buttonAction: {})
                .environment(\.locale, .init(identifier: "es"))
        }

    }
}
