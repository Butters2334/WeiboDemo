//
//  PostCellToolButton.swift
//  WeiboDemo
//
//  Created by ac on 2020/11/26.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

struct PostCellToolButton: View {
    let image:String
    let text:String
    let color:Color
    let action:()->Void
    
    var body: some View {
        Button(action:action) {
            HStack(spacing:5){
                Image(systemName:image)
                    .resizable()
                    .scaledToFill()
                    .frame(width:18,height:18)
                Text(text)
                    .font(.system(size: 15))
            }
        }
        .foregroundColor(color)
        .buttonStyle(BorderlessButtonStyle())
    }
}

struct PostCellToolButton_Previews: PreviewProvider {
    static var previews: some View {
        PostCellToolButton(image: "heart", text: "点赞2", color: .red) {
            print("test")
        }
    }
}
