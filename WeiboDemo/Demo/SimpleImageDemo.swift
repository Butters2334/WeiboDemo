//
//  SimpleImage.swift
//  WeiboDemo
//
//  Created by ac on 2020/12/8.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

struct SimpleImageDemo: View {
    let url : URL?
    @State private var data: Data?
    private var image: UIImage? {
        if let data = self.data {
            return UIImage(data: data)
        }
        return nil
    }
    @State private var loading:Bool = false
    var body: some View {
        let image = self.image
        return VStack{
            Group {
                if image != nil {
                    Image(uiImage: image!)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                }else{
                    Color.gray
                }
            }
            .frame(height:300)
            .overlay(
                ActivityIndicator(isAnimating: $loading, style: .large)
                    .foregroundColor(.red)
            )
            Button(action: {
                if let url = self.url{
                    DispatchQueue.global().async {
                        DispatchQueue.main.async {
                            self.loading = true
                            self.data = Data()
                        }
                        guard let data = try? Data(contentsOf: url) else{
                            return
                        }
                        DispatchQueue.main.async {
                            self.loading = false
                            self.data = data
                        }
                    }
                }
            }) {
                Text("down image")
            }//.onAppear(perform: T##(() -> Void)?##(() -> Void)?##() -> Void)
        }
    }
}

struct SimpleImage_Previews: PreviewProvider {
    static var previews: some View {
        SimpleImageDemo(url: URL(string: "https://raw.githubusercontent.com/anmac/WeiboDemo/master/WeiboDemo/Resources/4e7f0c83gy1gam2misv31j21hc0u016k.jpg"))
    }
}
