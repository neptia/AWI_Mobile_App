//
//  Tag.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 20/03/2025.
//

import SwiftUI

struct Tag: Identifiable, Hashable{
    var id = UUID().uuidString
    var name: String
    var size: CGFloat = 0
}
