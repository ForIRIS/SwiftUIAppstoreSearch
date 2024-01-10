//
//  AppBasicInfoView.swift
//  SwiftUIAppstoreSearch
//
//

import SwiftUI
import CachedAsyncImage

struct AppBasicInfoView : View {
    @Environment(\.openURL) private var openURL
    
    let info: AppInfo
    private let placeholderImg = UIImage(named: "placeholder")!
    
    var body: some View {
        HStack {
            CachedAsyncImage(url: URL(string:info.iconUrl)) { image in
                image
                    .resizable()
                    .frame(width: 120, height: 120)
                    .cornerRadius(16)
            } placeholder: {
                Image(uiImage: placeholderImg)
            }
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(info.name)
                            .font(.title2)
                            .fontWeight(.medium)
                            .lineLimit(2)
                        
                        Text(info.seller)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                        
                        Spacer(minLength: 2)
                    }
                    Spacer()
                }
                
                Spacer()
                HStack {
                    if let appUrl = URL(string: info.appURL) {
                        Button {
                            openURL(appUrl)
                        } label: {
                            Text("Get")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .frame(width:64, height:26)
                        .background(.blue)
                        .cornerRadius(13)
                    }

                    Spacer()
                    
                    Button {
                        guard let data = URL(string: info.appURL) else { return }
                        
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

#Preview {
    AppBasicInfoView(info: AppInfo(id: 1, name: "Test"))
}
