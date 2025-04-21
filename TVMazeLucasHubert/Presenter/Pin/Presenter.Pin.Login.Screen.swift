//
//  Presenter.Pin.Login.Screen.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 20/04/25.
//

import SwiftUI

extension Presenter.Pin.Login {
    struct Screen: View {
        @State private var pinInput = ""
        @State private var showError = false
        
        @Binding var showHome: Bool
        
        var body: some View {
            NavigationStack {
                VStack(spacing: 20) {
                    GroupBox {
                        SecureField("Enter your PIN", text: $pinInput)
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)
                            .font(.title)
                    }
                    
                    Button("Login") {
                        KeychainService.shared.retrievePIN { savedPin in
                            if pinInput == savedPin {
                                showHome = true
                            } else {
                                showError = true
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button("Use Face ID") {
                        KeychainService.shared.retrievePIN { pin in
                            if pin != nil {
                                var error: NSError?
                                if KeychainService.shared.context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                                    let reason = "We need to unlock your data."
                                    KeychainService.shared.context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                                        if success {
                                            print("Authenticated")
                                            showHome = true
                                        } else {
                                            print(authenticationError?.localizedDescription ?? "Unknown error")
                                        }
                                    }
                                    
                                } else if let error = error {
                                    print("Biometric authentication not available: \(error.localizedDescription)")
                                    // Handle the case where biometrics cannot be used
                                }
                            } else {
                                showError = true
                            }
                        }
                    }
                }
                .padding()
                .alert("Authentication error", isPresented: $showError) {
                    Button("OK", role: .cancel) {}
                }
            }
        }
    }
}
