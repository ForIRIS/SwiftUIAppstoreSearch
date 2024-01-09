//
//  AppDetailView.swift
//  SwiftUIAppstoreSearch
//
//

import SwiftUI

struct AppDetailView: View {
    @State private var icon: UIImage?
    @State private var screenShots: [UIImage] = [UIImage]()
    @State private var showToolbar: Bool = false
    @State private var idealSize: CGSize = .zero
    @Environment(\.openURL) var openURL
    private let placeholderImg = UIImage(named: "placeholder")!
    private let info: AppInfo
    
    init(info: AppInfo) {
        self.info = info
    }
    
    var body: some View {
        CustomScrollView(axes:.vertical, showsIndicators: true) { rect in
            if( rect.origin.y < -100 ) {
                self.showToolbar = true
            } else {
                self.showToolbar = false
            }
        } content: {
            LazyVStack(alignment:.leading) {
                AppBasicInfoView(info: self.info)
                Divider()
                makeScreenShots()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                if self.showToolbar {
                    Button {
                        
                        openURL(URL(string: info.appURL)!)
                    } label: {
                        Text("Get")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .alignmentGuide(HorizontalAlignment.center,
                                            computeValue: { d in
                                d[HorizontalAlignment.center]
                            })
                    }
                    .frame(width:56, height:28)
                    .background(.blue)
                    .cornerRadius(14)
                } else {
                    Spacer()
                }
            }
        }
    }
    
    // MARK - Screenshot lists
    func makeScreenShots() -> some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    if screenShots.count > 0 {
                        ForEach(screenShots, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: self.idealSize.width, height:self.idealSize.height)
                                .cornerRadius(12)
                        }
                    } else {
                        Text("")
                            .frame(width: self.idealSize.width, height:self.idealSize.height)
                    }
                }
                .frame(height: self.idealSize.height + 10) // Plus top, bottom margin
                .aspectRatio(contentMode: .fill)
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            }
            .frame(height:self.idealSize.height + 10)
    }
}

