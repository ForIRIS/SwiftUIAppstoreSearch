//
//  SearchCell.swift
//  SwiftUIAppstoreSearch
//
//

import SwiftUI

struct SearchCell: View {
    @Binding private var displayData: AppDisplayData
    @Environment(\.openURL) var openURL
    
    private let placeholderImg = UIImage(named: "placeholder")!
    
    init(data: AppDisplayData) {
        self.displayData = data
    }
    
    var body : some View {
        VStack(alignment: .leading) {
            HStack {
                // App Icon image
                AsyncImage(url: displayData.icon) { image in
                    image.resizable()
                } placeholder: {
                    Image(uiImage: placeholderImg)
                }
                .frame(width: 50, height: 50)
                .cornerRadius(12)
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                
                
                // Title and Seller
                VStack(alignment: .leading) {
                    Text(displayData.title)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .lineLimit(2)

                    if let seller = displayData.seller {
                        Text(seller)
                            .font(.footnote)
                            .lineLimit(1)
                    } else {
                        Spacer(minLength: 10)
                    }
                }
                
                Spacer()
                
                // Goto appstore page
                if let appUrl = displayData.appUrl, appUrl.count > 0 {
                    Button {
                    } label: {
                        Text("Get")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .onTapGesture {
                                openURL(URL(string: appUrl)!)
                            }
                    }
                    .frame(width:56, height:26)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(13)
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                }
            }
            .frame(height: 60)
            
            /// ScreenShots Stack
            HStack(alignment: .center) {
                if displayData.screenshotUrls?.count > 0 {
                    ForEach(displayData.screenshotUrls, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .cornerRadius(8)
                    }
                } else {
                    GeometryReader { geometry in
                        Text("")
                            .frame(width: geometry.size.width, height: geometry.size.width * (16.0 / 9))
                    }
                }
            }
            .onAppear {
                self.displayData.fetchScreenshot { image in
                    if let image = image, self.screenShots.count < 3 {
                        if image.size.width < image.size.height || self.screenShots.count == 0 {
                            self.screenShots.append(image)
                        }
                    }
                }
            }
            .aspectRatio(16.0/9.0, contentMode: .fit)
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    SearchCell(data: Dummy.displayData)
        .previewDisplayName("SearchBookCell")
}
