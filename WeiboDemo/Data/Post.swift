//
//  Post.swift
//  WeiboDemo
//
//  Created by ac on 2020/11/26.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostList:Codable {
    var list: [Post]
}

//Data Model
struct Post :Codable,Identifiable{
    let id:Int
    let avatar: String
    let vip: Bool
    let date:String
    let name:String
    
    var isFollowed:Bool
    
    let text:String
    let images:[String]
    
    var commentCount:Int
    var likeCount:Int
    var isLiked:Bool
 
}

extension Post: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool{
        lhs.id == rhs.id
    }
}

extension Post{
    var commentCountText: String {
        if commentCount <= 0 {return "评论"}
        if commentCount < 1000 {return "\(commentCount)"}
        return String(format:"%.1fk",Double(commentCount)/1000)
    }
    var likeCountText:String {
        if likeCount <= 0 {return "点赞"}
        if likeCount < 1000 {return "\(likeCount)"}
        return String(format:"%.1fk",Double(likeCount)/1000)
    }
}


func loadPostListData(_ fileName:String)->PostList{
    guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
        fatalError("Can not findd \(fileName) in main bundle")
    }
    guard let data = try? Data(contentsOf: url) else{
        fatalError("Can not load \(url)")
    }
    guard let list = try? JSONDecoder().decode(PostList.self, from: data) else {
        fatalError("Can not parse post list json data")
    }
    return list
}

func loadImage(_ name:String)->WebImage{
    return WebImage(url: URL(string:NetworkAPIBaseURL+name))
        .placeholder{ Color.gray }
        .resizable()
//    return Image(uiImage: UIImage(named: name)!)
}
