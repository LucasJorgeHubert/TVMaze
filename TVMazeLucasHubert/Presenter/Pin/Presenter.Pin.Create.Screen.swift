//
//  PINCreationView.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 20/04/25.
//

import Foundation
import SwiftUI

extension Presenter.Pin.Create {
    struct Screen: View {
        @State private var pin = ""
        @State private var confirmation = ""
        @State private var showAlert = false
        
        var body: some View {
            VStack(spacing: 20) {
                SecureField("Enter a PIN", text: $pin)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                
                SecureField("Repeat PIN", text: $confirmation)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                
                Button("Save PIN") {
                    if pin == confirmation, KeychainService.shared.savePIN(pin) {
                        showAlert = true
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .alert("PIN saved successfully!", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            }
        }
    }
}
