//
//  SDImgeDemo.swift
//  WeiboDemo
//
//  Created by ac on 2020/12/8.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct SDImgeDemo: View {
    @State private var url : URL?
    @State private var loading:Bool = false
    @State private var state : String = ""
    var body: some View {
        return VStack{
            WebImage(url: url,isAnimating:$loading)
                .placeholder{ Color.gray }
                .resizable()
                .onSuccess(perform: { _ in
                    self.state = "success"
//                    SDWebImageManager.shared.imageCache.clear(with: .all) {}
                })
                .onFailure(perform: { _ in
                    self.state = "failure"
                })
                .scaledToFill()
                .clipped()
                .frame(height:300)
            Button(action: {
                self.url = self.url != nil ? nil : URL(string: "https://raw.githubusercontent.com/anmac/WeiboDemo/master/WeiboDemo/Resources/4e7f0c83gy1gam2misv31j21hc0u016k.jpg")
            }) {
                Text("down SDImage")
            }
            Text("state = \(state)")
        }
    }
}

struct SDImgeDemo_Previews: PreviewProvider {
    static var previews: some View {
        SDImgeDemo()
    }
}
