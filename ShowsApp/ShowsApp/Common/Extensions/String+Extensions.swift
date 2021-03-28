//
//  String+Extensions.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 28/03/21.
//

import Foundation


extension String {
    static let empty = ""
    
    var htmlDecoded: String {
        guard let stringData = data(using: .utf8) else {
            return ""
        }
        let attributedString = try? NSAttributedString(
            data: stringData,
            options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ],
            documentAttributes: nil
        )
        return attributedString?.string ?? ""
    }
}
