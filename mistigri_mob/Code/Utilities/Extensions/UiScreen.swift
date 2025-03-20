//
//  UiScreen.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 20/03/2025.
//
import SwiftUI

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.width
}

extension String{
    func getSize() -> CGFloat{
        let font = UIFont.systemFont(ofSize: 16)
        let attributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: attributes)
        return size.width
    }
}
