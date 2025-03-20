//
//  TagsView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 20/03/2025.
//

import SwiftUI

struct TagsView: View {
    @ObservedObject var viewModel = TagsViewModel()
    
    var body: some View {
        VStack(alignment: .leading){
            TextField("Enter tags", text: $viewModel.tagText, onCommit: {
                viewModel.addTag()
            })
            .padding()
            .background(Color.CFFDC9A.opacity(0.35))
            .cornerRadius(8)
            .padding(.top, 20)
            .padding(.horizontal,20)
            .padding(.bottom,0)

            VStack(alignment: .leading, spacing: 4){
            Text("Tags :")
                    .foregroundColor(Color.Ca35400)
                    .padding(.bottom, 5)
                ForEach(viewModel.rows, id:\.self){ rows in
                    HStack(spacing: 8){
                        ForEach(rows){ row in
                            Text(row.name)
                                .font(.system(size: 16))
                                .padding(.leading, 14)
                                .padding(.trailing, 30)
                                .padding(.vertical, 8)
                                .background(
                                    ZStack(alignment: .trailing){
                                        Capsule()
                                            .fill(Color.Cffb05c)
                                        Button{
                                            viewModel.removeTag(by: row.id)
                                        } label:{
                                            Image(systemName: "xmark.circle.fill")
                                                .frame(width: 15, height: 15)
                                                .padding(.trailing, 8)
                                                .foregroundColor(Color.Ca35400)
                                        }
                                    }
                                )
                        }
                    }
                    .frame(height: 28)
                    .padding(.bottom, 10)
                }
            }
            .padding(24)
            Spacer()
        }
    }
}

#Preview {
    TagsView(viewModel: TagsViewModel())
}
