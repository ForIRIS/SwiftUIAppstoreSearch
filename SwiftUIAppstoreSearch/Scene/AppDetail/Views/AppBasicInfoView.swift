//
//  AppBasicInfoView.swift
//  SwiftUIAppstoreSearch
//
//

import SwiftUI

struct AppBasicInfoView : View {
    @Binding var icon: UIImage?
    @Environment(\.openURL) private var openURL
    
    let displayData: AppDisplayData
    private let placeholderImg = UIImage(named: "placeholder")!
    
    var body: some View {
        HStack {
            Image(uiImage: icon ?? placeholderImg)
                .resizable()
                .frame(width: 120, height: 120)
                .cornerRadius(16)
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(displayData.title)
                            .font(.title2)
                            .fontWeight(.medium)
                            .lineLimit(2)
                        
                        Spacer(minLength: 2)
                        
                        if let seller = displayData.seller {
                            Text(seller)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                        } else {
                            Spacer(minLength: 10)
                        }
                        Spacer(minLength: 2)
                    }
                    Spacer()
                }
                
                Spacer()
                HStack {
                    if let appUrl = displayData.appUrl, appUrl.count > 0 {
                        Button {
                        } label: {
                            Text("Get")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .onTapGesture {
                                    openURL(URL(string: appUrl)!)
                                }
                        }
                        .frame(width:64, height:26)
                        .background(.blue)
                        .cornerRadius(13)
                    }

                    Spacer()
                    
                    Button {
                        guard let appurl = self.displayData.appUrl, let data = URL(string: appurl) else { return }
                        
                        let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
                        
                        if #available(iOS 15.0, *) {
                            UIApplication
                                .shared
                                .connectedScenes
                                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                                .first { $0.isKeyWindow }?
                                .rootViewController?
                                .present(av, animated: true)
                        } else {
                            UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true)
                        }
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 15))
        }
    }
}
