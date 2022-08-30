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
    private let displayData: AppDisplayData
    
    init(data: AppDisplayData) {
        self.displayData = data
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
                AppBasicInfoView(icon: self.$icon, displayData: self.displayData)
                    .onAppear {
                        self.displayData.fetchImage { image in
                            self.icon = image
                        }
                }
                Divider()
                AppDetailInfoView(displayData: self.displayData)
                Divider()
                makeScreenShots()
                Divider()
                Text(self.displayData.description ?? "")
                    .font(.caption)
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                if self.showToolbar {
                    Image(uiImage: self.icon ?? placeholderImg)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .cornerRadius(8)
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                } else {
                    Spacer()
                }
            }
            ToolbarItem(placement: .primaryAction) {
                if self.showToolbar {
                    if let appUrl = displayData.appUrl, appUrl.count > 0 {
                        Button {
                            openURL(URL(string: appUrl)!)
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
                    }
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
                .onAppear {
                    self.displayData.fetchScreenshot { image in
                        if let image = image {
                            self.screenShots.append(image)
                            
                            // Calculates the ideal image size for the screen size.
                            if self.idealSize == .zero, image.size.width < image.size.height {
                                self.idealSize.width = UIScreen.main.bounds.width * 0.6
                                self.idealSize.height =  self.idealSize.width * (image.size.height / image.size.width)
                            } else {
                                // Left and Right margin is 5.
                                self.idealSize.width = UIScreen.main.bounds.width - 10
                                self.idealSize.height =  self.idealSize.width * (image.size.height / image.size.width)
                            }
                        }
                    }
                }
                .frame(height: self.idealSize.height + 10) // Plus top, bottom margin
                .aspectRatio(contentMode: .fill)
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            }
            .frame(height:self.idealSize.height + 10)
    }
}

#if DEBUG
struct AppDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AppDetailView(data:Dummy.displayData)
    }
}
#endif
