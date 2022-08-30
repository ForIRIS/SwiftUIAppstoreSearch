//
//  StarRatingView.swift
//  SwiftUIAppstoreSearch
//
//


import SwiftUI

struct StarRatingView : View {
    private let maxStar = 5
    var value : Float
    
    init(_ value: Float ) {
        self.value = value
    }
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0 ..< maxStar, id:\.self) { index in
                ZStack(alignment: .leading) {
                    if self.value - Float(index) > 1 {
                        fullStar
                            .scaledToFill()
                            .frame(width: 10, height: 10, alignment: .leading)
                    } else if self.value - Float(index) > 0 {
                        emptyStar
                            .scaledToFill()
                            .frame(width: 10, height: 10, alignment: .leading)
                        fullStar
                            .scaledToFill()
                            .frame(width: 10 * CGFloat(max(0,value - Float(index))), height: 10, alignment: .leading)
                            .clipped()
                    } else {
                        emptyStar
                            .scaledToFill()
                            .frame(width: 10, height: 10, alignment: .leading)
                    }
                }
            }
        }
    }
    
    private var fullStar: some View {
        Image(systemName: "star.fill")
            .resizable()
            .foregroundColor(.gray)
    }
    
    private var emptyStar: some View {
        Image(systemName: "star")
            .resizable()
            .foregroundColor(.gray)
    }
}
