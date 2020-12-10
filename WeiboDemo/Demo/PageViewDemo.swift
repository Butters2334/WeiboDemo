//
//  PgeViewDemo.swift
//  WeiboDemo
//
//  Created by ac on 2020/11/30.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

struct PageView : View {
    let maxWidth  = UIScreen.main.bounds.width
    let maxHeight = UIScreen.main.bounds.height
    var body: some View {
        TabView {
            PostListView(.recommend)
                .frame(width:self.maxWidth)
            PostListView(.hot)
                .frame(width:self.maxWidth)
        }
        .frame(width:maxWidth,height: maxHeight)
//        .tabViewStyle(PageTabViewStyle())//iOS14 SwiftUI2.0
        
    }
}

struct PageViewDemo: View {
    var body: some View {
        PageView()
    }
}

struct PageViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        PageViewDemo()
    }
}
