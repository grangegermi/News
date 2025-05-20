//
//  CustomAlert.swift
//  News
//
//  Created by Даша Волошина on 20.05.25.
//

import Foundation
import SwiftUI

class AlertManager: ObservableObject {
    @Published var showAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    
    var item: CustomAlertButton = .blockButton
    var onBlock: (() -> Void)?
    var onCancel: (() -> Void)?
    
    func showCustomAlert(title: String, message: String, item: CustomAlertButton, onBlock: @escaping () -> Void, onCancel: @escaping () -> Void) {
        self.alertTitle = title
        self.alertMessage = message
        self.item = item
        self.onBlock = onBlock
        self.onCancel = onCancel
        self.showAlert = true
    }
    
    func dismiss() {
        showAlert = false
        onBlock = nil
        onCancel = nil
    }
}

enum CustomAlertButton: CaseIterable,Identifiable {
    case blockButton
    case unblockButton
    
    var id: Int { return hashValue }
}

extension CustomAlertButton{
    var title: LocalizedStringKey {
        switch self{
        case .blockButton:
            return  "Block"
        case .unblockButton:
            return "Unblock"
        }
    }
}

struct CustomAlert: View {
    let title: String
    let message: String
    var item: CustomAlertButton
    let onBlock: () -> Void
    let onCancel: () -> Void
      
    var body: some View {
        VStack(spacing: Spacing.middle) {
            Text(title)
                .font(.headline)
                .multilineTextAlignment(.center)
            Text(message)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            
            Divider()
            
            Button(action: onBlock) {
                Text(item.title)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
            }
            Divider()
            
            Button(action: onCancel) {
                Text("Cancel")
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .background(.thinMaterial)
        .cornerRadius(Sizes.cornerRadiusBig)
        .shadow(radius: Sizes.cornerRadiusMiddle)
        .padding(.horizontal, Spacing.big)
    }
}
