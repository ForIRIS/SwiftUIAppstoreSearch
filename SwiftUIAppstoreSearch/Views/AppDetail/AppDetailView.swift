//
//  AppDetailView.swift
//  SwiftUIAppstoreSearch
//
//

import SwiftUI
import CachedAsyncImage

struct AppDetailView: View {
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
                if !info.releaseNotes.isEmpty {
                    Text("Release notes")
                        .font(.subheadline)
                        .padding()
                    Text(info.releaseNotes)
                        .font(.caption)
                        .padding(.horizontal)
                }
                
                if !info.appDescription.isEmpty {
                    Text("Description")
                        .font(.subheadline)
                        .padding()
                    Text(info.appDescription)
                        .font(.caption)
                        .padding(.horizontal)
                }
            }
        }
        .background(
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        idealSize = proxy.size
                    }
            }
        )
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                if self.showToolbar {
                    CachedAsyncImage(url: URL(string:info.iconUrl)) { image in
                        image
                            .resizable()
                            .frame(width: 30, height: 30)
                            .cornerRadius(4)
                    } placeholder: {
                        Image(uiImage: placeholderImg)
                    }
                } else {
                    Spacer()
                }
            }
            
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
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.flexible())]) {
                ForEach(info.screenshots, id: \.self) { imageUrl in
                    if let (width, height) = info.getScreenshotSize() {
                        CachedAsyncImage(url: URL(string: imageUrl)) {
                            $0.resizable()
                              .aspectRatio(CGSize(width: width, height: height), contentMode: .fit)
                              .frame(maxWidth: self.idealSize.width - 20, maxHeight: self.idealSize.width)
                              .cornerRadius(8)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
    }
}

