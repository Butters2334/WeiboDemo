//
//  PostCell.swift
//  WeiboDemo
//
//  Created by ac on 2020/11/26.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

struct PostCellNameDate:View {
    let name : String
    let date : String
    var body: some View{
        VStack(alignment: .leading, spacing: 5){
            Text(name)
                .font(.system(size: 16))
                .foregroundColor(.init(red: 244/255, green: 99/255, blue: 4/255))
            Text(date)
                .font(.system(size: 11))
                .foregroundColor(.gray)
        }
    }
}
struct PostCellFollowed :View{
    let action: () -> Void
    var body: some View{
        Button(action:action) {
            Text("关注")
                .font(.system(size: 14))
                .foregroundColor(.orange)
                .frame(width:50,height:26)
                .overlay(RoundedRectangle(cornerRadius: 13).stroke(Color.orange,lineWidth: 1))
        }.buttonStyle(BorderlessButtonStyle())
    }
}
struct PostCellHead:View{
    let avatar:String
    let vip:Bool
    var body: some View{
        loadImage(avatar)
            .resizable()
            .scaledToFill()
            .frame(width:50,height: 50)
            .clipShape(Capsule())
            .overlay(
                PostVipBadge(vip: vip)
                .offset(x: 16, y: 16)
            )

    }
}

struct PostCell: View {
    
    let post:Post
    var bindingPost : Post {
        userData.post(forId: post.id)!
    }
    
    @State var presentComent : Bool = false
    
    @EnvironmentObject var userData:UserData
    
    let maxWidth = UIScreen.main.bounds.width-15*2

    var body: some View {
        var post = bindingPost
        return VStack(alignment: .leading, spacing: 10) {
            //用户栏
            HStack(spacing:10){
                PostCellHead(avatar: post.avatar,vip: post.vip)
                PostCellNameDate(name: post.name, date: post.date)
                Spacer()
                if !post.isFollowed {
                    PostCellFollowed {
                        post.isFollowed = true
                        self.userData.update(post)
                    }
                }
            }
            //主内容
            Text(post.text)
                .font(.system(size:17))
                .foregroundColor(Color.black.opacity(0.7))
            //是否显示图片栏
            if !post.images.isEmpty{
                PostImageCell(images: post.images ,width: maxWidth)
            }
            //分割线
            Divider()
            //评论点赞栏
            HStack{
                Spacer()
                PostCellToolButton(image: "message", text: post.commentCountText, color: .black) {
                    self.presentComent = true
                }.sheet(isPresented: $presentComent) {
                    //注意模态推出的环境变量不和nav同步
                    CommentInputView(post: post)
                        .environmentObject(self.userData)
                }
                Spacer()
                    .overlay(
                        Divider()
                            .frame(width:1,height:20)
                    )
                PostCellToolButton(image: post.isLiked ? "heart.fill" : "heart", text: post.likeCountText, color: post.isLiked ? .red : .black) {
                    
                    post.isLiked = !post.isLiked
                    post.likeCount += post.isLiked ? 1 : -1
                    self.userData.update(post)
                }
                Spacer()
            }
            //最后一个长方块作为分割
            Rectangle()
                .padding(.horizontal,-15)
                .frame(height:10)
                .foregroundColor(.init(red: 238/255, green: 238/255, blue: 238/255))
        }
        .frame(width:maxWidth)
        .padding(.top, 15)
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(post: UserData().postList(for: .recommend).list[2]).environmentObject(UserData())
    }
}
