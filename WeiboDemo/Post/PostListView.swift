//
//  PostListView.swift
//  WeiboDemo
//
//  Created by ac on 2020/11/26.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI
import UIKit
import BBSwiftUIKit

struct RequestToast: View {
    @EnvironmentObject var userData:UserData
    var body: some View {
        Text(userData.loadingErrorText)
            .bold()
            .frame(width:200)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.white.opacity(0.8))
            )
            .animation(nil)
            .scaleEffect(userData.showLoadingError ? 1 : 0.5)
            .animation(.spring(dampingFraction:0.5))
            .opacity(userData.showLoadingError ? 1 :0)
            .animation(.easeInOut)
    }
}

struct PostListView: View {
    let category:PostListCategory
    @EnvironmentObject var userData:UserData
    init(_ category : PostListCategory){
        self.category = category
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().selectionStyle = .none
    }
    var body: some View {
        BBTableView(userData.postList(for: category).list) { post in
            NavigationLink(destination: PostDeatilView(post: post)){
                PostCell(post: post)
            }.buttonStyle(OriginalButtonStyle())
        }
        .bb_setupRefreshControl {
            $0.attributedTitle=NSAttributedString(string:"加载中")
        }
        .bb_pullDownToRefresh(isRefreshing: $userData.isRefreshing, refresh: {
            self.userData.refreshData(self.category)
        })
        .bb_pullUpToLoadMore(bottomSpace: 30) {
            self.userData.loadMoreData(self.category)
        }
        .overlay(
            RequestToast()
        )
        .onAppear {
            self.userData.refreshData(self.category)
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            PostListView(.recommend)
            .navigationBarTitle("Title")    //hidden必须设置
            .navigationBarHidden(true)
        }.environmentObject(UserData())
    }
}
