//
//  StringExtensions.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 08/03/2025.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    func localized(arguments: CVarArg...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
}
