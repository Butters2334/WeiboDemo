//
//  HomeView.swift
//  WeiboDemo
//
//  Created by ac on 2020/11/30.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI
import UIKit

struct HomeView: View {
    
    @State var leftPercent:CGFloat// = 0
    
    let maxWidth = UIScreen.main.bounds.width
    let maxHeight = UIScreen.main.bounds.height
    var body: some View {
        NavigationView {
            GeometryReader{geometry in
                HScrollViewController(pageWidth: geometry.size.width, contentSize: CGSize(width: geometry.size.width*2, height: geometry.size.height),leftPercent:self.$leftPercent) {
                    HStack(spacing:0){
                        PostListView(.recommend)
                            .frame(width:self.maxWidth)
                        PostListView(.hot)
                            .frame(width:self.maxWidth)
                    }
                } 
            }
            .navigationBarItems(trailing: HomeNavigationBar(leftPercent: $leftPercent))
            .navigationBarTitle("首页",displayMode: .inline)
        }
    .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(leftPercent: 0).environmentObject(UserData())
    }
}
