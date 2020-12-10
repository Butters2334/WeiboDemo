//
//  CommentInput.swift
//  WeiboDemo
//
//  Created by ac on 2020/12/4.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

struct CommentInputView: View {
    let post:Post
    
    //获取环境中的变量
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var userData : UserData
    
    @ObservedObject private var keyboardResponse = keyboardResponder()
    
    @State private var text : String  = ""
    @State private var showEmptyTextHUD : Bool = false
    
    var body: some View {
        VStack{
            
            CommentTextView(text: $text ,beginEdittingOnAppear: true)
            
            HStack(spacing:0){
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text("取消").padding()
                }
                Spacer()
                Button(action: {
                    if self.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        self.showEmptyTextHUD = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                            self.showEmptyTextHUD = false
                        }
                        
                        return
                    }
                    print(self.text)
                    
                    var post = self.post
                    post.commentCount += 1
                    self.userData.update(post)
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text("发送").padding()
                }
            }
            .font(.system(size:13))
            .foregroundColor(.black)
        }
        .overlay(
            Text("评论不能为空")
                .scaleEffect(showEmptyTextHUD ? 1 : 0.5)
                .animation(.spring(dampingFraction:0.5))
                .opacity(showEmptyTextHUD ? 1 :0)
                .animation(.easeInOut)
        )
        .padding(.bottom,keyboardResponse.keyboardHeight)
        .edgesIgnoringSafeArea(keyboardResponse.keyboardShow ? .bottom : [])
    }
}

struct CommentInput_Previews: PreviewProvider {
    static var previews: some View {
        CommentInputView(post: loadPostListData("PostListData_recommend_1.json").list[0])
    }
}
