//
//  GameCreationRequest.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 19/03/2025.
//

import SwiftUI

struct GameCreationRequest: Encodable {
    let name: String
    let editors: String
    let tags: [String]
}
