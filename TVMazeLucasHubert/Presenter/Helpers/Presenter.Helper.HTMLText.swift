//
//  Presenter.Helper.HTMLText.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 18/04/25.
//

import Foundation
import SwiftUI

extension Presenter.Helpers{
    struct HTMLTextView {
        public static func makeText(html: String) -> Text {
            guard let nsAttributedString = try? NSAttributedString(data: Data(html.utf8), options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil),
               var attributedString = try? AttributedString(nsAttributedString, including: \.uiKit)
            else { return Text(html) }
            
            for run in attributedString.runs {
                let range = run.range
                attributedString[range].font = .system(size: 18, weight: .regular)
                attributedString[range].foregroundColor = .primary
            }
            
            return Text(attributedString)
        }
    }
}
