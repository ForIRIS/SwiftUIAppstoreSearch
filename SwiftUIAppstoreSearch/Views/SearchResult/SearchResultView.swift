//
//  SearchResultView.swift
//  SwiftUIAppstoreSearch
//
//  Created by KAK KYOO LEE on 2024-01-08.
//

import SwiftUI

struct SearchResultView: View {
    let list: [AppInfo]
    
    var body: some View {
        List(list) { info in
            Text("List")
        }
    }
}

#Preview {
    SearchResultView(list:[])
}
