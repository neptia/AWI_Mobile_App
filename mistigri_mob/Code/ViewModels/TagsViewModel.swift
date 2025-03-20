//
//  TagsViewModel.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 20/03/2025.
//

import SwiftUI

class TagsViewModel: ObservableObject{

    @Published var rows: [[Tag]] = []
    @Published var tags: [Tag] = []
    @Published var tagText = ""


    init(){
        getTags()
    }

    func getTags(){
        var rows: [[Tag]] = []
        var currentRow: [Tag] = []

        var totalWidth: CGFloat = 0

        let screenWidth = UIScreen.screenWidth - 10
        let tagSpaceing: CGFloat = 14 /*Leading Padding*/ + 30 /*Trailing Padding*/ + 6 + 6 /*Leading & Trailing 6, 6 Spacing*/

        if !tags.isEmpty{

            for index in 0..<tags.count{
                self.tags[index].size = tags[index].name.getSize()
            }

            tags.forEach{ tag in

                totalWidth += (tag.size + tagSpaceing)

                if totalWidth > screenWidth{
                    totalWidth = (tag.size + tagSpaceing)
                    rows.append(currentRow)
                    currentRow.removeAll()
                    currentRow.append(tag)
                }else{
                    currentRow.append(tag)
                }
            }

            if !currentRow.isEmpty{
                rows.append(currentRow)
                currentRow.removeAll()
            }

            self.rows = rows
        }else{
            self.rows = []
        }
    }

    func addTag(){
        tags.append(Tag(name: tagText))
        tagText = ""
        getTags()
    }

    func removeTag(by id: String){
        tags = tags.filter{ $0.id != id }
        getTags()
    }

    func getAllTagsName() -> [String] {
        var tagNames: [String] = []
        tags.forEach{ tagNames.append($0.name) }
        return tagNames
    }

}
