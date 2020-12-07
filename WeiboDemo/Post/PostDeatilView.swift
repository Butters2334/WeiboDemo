//
//  PostDeatilView.swift
//  WeiboDemo
//
//  Created by ac on 2020/11/27.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

struct PostDeatilView: View {
    let post:Post
    var body: some View {
        List{
            PostCell(post: post)
            ForEach(1...10,id:\.self){ i in
                Text("评论\(i)")
            }
        }.navigationBarTitle("Detail", displayMode: NavigationBarItem.TitleDisplayMode.inline)
    }
}

struct PostDeatilView_Previews: PreviewProvider {
    static var previews: some View {
        PostDeatilView(post: UserData().hotPostList.list[0])
            .environmentObject(UserData())
    }
}
