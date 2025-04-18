//
//  Preview.extension.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 17/04/25.
//

import Foundation
import SwiftUI

struct PreviewWrapper<Content: View>: View {
    let content: () -> Content
    
    var body: some View {
        content()
            .tint(.indigo) // Aqui você define a cor padrão pro preview
    }
}
