//
//  PostListView.swift
//  WeiboDemo
//
//  Created by ac on 2020/11/26.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI
import UIKit

struct PostListView: View {
    let category:PostListCategory
    
    @EnvironmentObject var userData:UserData
    
//    var postList:PostList{
//        switch category {
//        case .hot:
//            return loadPostListData("PostListData_hot_1.json")
//        case .recommend:
//            return loadPostListData("PostListData_recommend_1.json");
//        }
//    }
    
    init(_ category : PostListCategory){
        self.category = category
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().selectionStyle = .none
//        UITableViewCell.appearance().backgroundColor = .red
    }
    
    var body: some View {
        return List{
            ForEach(userData.postList(for: category).list){
                post in
                ZStack{
                    PostCell(post: post)
                    NavigationLink(destination: PostDeatilView(post: post)){
                        EmptyView()
                    }.hidden()
                }.listRowInsets(EdgeInsets())
            }
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            PostListView(.hot)
            .navigationBarTitle("Title")    //hidden必须设置
            .navigationBarHidden(true)
        }.environmentObject(UserData())
    }
}
