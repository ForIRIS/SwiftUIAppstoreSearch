//
//  SearchCell.swift
//  SwiftUIAppstoreSearch
//
//

import SwiftUI

struct SearchCell: View {
    @State private var icon: UIImage?
    @State private var screenShots: [UIImage] = [UIImage]()
    @Environment(\.openURL) var openURL
    
    private let placeholderImg = UIImage(named: "placeholder")!
    private let displayData: AppDisplayData
    
    init(data: AppDisplayData) {
        self.displayData = data
    }
    
    var body : some View {
        VStack(alignment: .leading) {
            HStack {
                // App Icon image
                Image(uiImage: icon ?? placeholderImg)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .onAppear {
                        self.displayData.fetchImage { image in
                            self.icon = image
                        }
                    }
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
                if screenShots.count > 0 {
                    ForEach(screenShots, id: \.self) { image in
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

#if DEBUG
struct SearchBookCell_Previews : PreviewProvider {
    static var previews: some View {
        SearchCell(data: Dummy.displayData)
            .previewDisplayName("SearchBookCell")
    }
}
#endif
