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
        VStack(alignment:.leading) {
            HStack {
                Text("Suggested")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            LazyHGrid(rows: colums) {
                ForEach(suggestedList, id: \.self) {
                    SuggestedViewCell(model: $0)
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    SuggestionView(suggestedList: [])
}
