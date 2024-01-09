//
//  SuggestionView.swift
//  SwiftUIAppstoreSearch
//
//

import SwiftUI
import SwiftData

struct SuggestionView : View {
    var suggestedList:[AppModel]
    
    let colums: [GridItem] = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            VStack(alignment:.leading) {
                HStack {
                    Text("Suggested")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                LazyVGrid(columns: colums) {
                    let lastLineStart = suggestedList.count - 1
                    ForEach(0..<suggestedList.count, id: \.self) { index in
                        SuggestedViewCell(model: suggestedList[index])
                        if index < lastLineStart {
                            Rectangle()
                                .fill(index < lastLineStart ? Color.gray.opacity(0.1) : Color.clear)
                                .frame(height: 1, alignment: .bottom)
                                .padding(.leading, 60)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    SuggestionView(suggestedList: [])
}
