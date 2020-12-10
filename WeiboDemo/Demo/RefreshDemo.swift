//
//  RefreshDemo.swift
//  WeiboDemo
//
//  Created by ac on 2020/12/9.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI
import BBSwiftUIKit

struct RefreshDemo: View {
    @State var list: [Int] = (0..<15).map {$0}
    @State var isRefreshing = false
    @State var isLoadingMore = false
    @State private var state = ""
    var body: some View {
        VStack{
            Text(state != "" ? "state = \(state)" : " ")
            BBTableView(list){i in
                Text("Text \(i)")
                    .frame(width:100)
                    .padding()
                    .background(i%2==0 ? Color(UIColor.green) : Color.green)
            }
            .bb_setupRefreshControl {
                $0.tintColor = .blue
                $0.attributedTitle = NSAttributedString(string: "refresh ...", attributes: [.foregroundColor:UIColor.blue])
            }
            .bb_pullDownToRefresh(isRefreshing: $isRefreshing) {
                self.state = "refresh"
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    self.state = ""
                    self.list = (0 ..< 15).map{$0}
                    self.isRefreshing = false
                }
            }
            .bb_pullUpToLoadMore(bottomSpace: 30) {
                if self.isLoadingMore || self.list.count >= 30 { return }
                self.state = "load more"
                self.isLoadingMore = true
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    self.state = ""
                    self.isLoadingMore = false
                    let count = self.list.count
                    let more = count ..< count+3
                    self.list.append(contentsOf:more)
                }
            }
        }
    }
}

struct RefreshDemo_Previews: PreviewProvider {
    static var previews: some View {
        RefreshDemo()
    }
}
