//
//  UserData.swift
//  WeiboDemo
//
//  Created by ac on 2020/11/30.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI
import Combine

class UserData: ObservableObject{
    @Published var recommendPostList = PostList(list: [])
    @Published var hotPostList = PostList(list: [])
    @Published var isRefreshing  = false
    @Published var isLoadingMore = false
    @Published var loadingError: Error?
    
    private var recommendPostDic: [Int:Int] = [:]// id: index
    private var hotPostDic : [Int:Int] = [:]
    
    init() {
        resetDic()
    }
    func resetDic(){
        recommendPostDic = [:]
        for i in 0..<recommendPostList.list.count {
            let post = recommendPostList.list[i]
            recommendPostDic[post.id] = i
        }
        hotPostDic = [:]
        for i in 0..<hotPostList.list.count {
            let post = hotPostList.list[i]
            hotPostDic[post.id] = i
        }
    }
}


extension UserData {
    var showLoadingError:Bool { loadingError != nil }
    var loadingErrorText:String {loadingError?.localizedDescription ?? ""}
    
    func postList(for category:PostListCategory) -> PostList {
        switch category {
            case .recommend:return recommendPostList
            case .hot:return hotPostList
        }
    }
    func post(forId id:Int)->Post? {
        if let index = recommendPostDic[id] {
            return recommendPostList.list[index]
        }
        if let index = hotPostDic[id] {
            return hotPostList.list[index]
        }
        return nil
    }
    func update(_ post : Post){
        if let index = recommendPostDic[post.id] {
            recommendPostList.list[index] = post
        }
        if let index = hotPostDic[post.id] {
            hotPostList.list[index] = post
        }
    }
    //下拉刷新数据
    func refreshData(for category:PostListCategory,list:[Post]){
        switch category {
            case .recommend:
                recommendPostList = PostList(list: list)
            case .hot:
                hotPostList = PostList(list: list)
        }
        resetDic()
    }
    //加载更多数据
    func appendData(for category:PostListCategory,list:[Post]){
        switch category {
            case .recommend:
                recommendPostList.list.append(contentsOf: list)
            case .hot:
                hotPostList.list.append(contentsOf: list)
        }
        resetDic()
    }
    func refreshData(_ category:PostListCategory){
        self.sendRequest(category){ list in
            self.isRefreshing = false
            self.refreshData(for: category, list: list)
        }
    }
    func loadMoreData(_ category:PostListCategory){
        if self.isLoadingMore { return }
        self.isLoadingMore = true
        self.sendRequest(category){ list in
            self.isLoadingMore = false
            self.appendData(for: category, list: list)
        }
    }
    func sendRequest(_ category:PostListCategory,completion:@escaping ([Post])->Void){
        let requestBlock: (Result<PostList,Error>)->Void = { result in
            print("send request")
            self.isLoadingMore = false
            switch result {
            case let .success(postList):
                completion(postList.list)
            case let .failure(error):
                self.loadingError = error
                DispatchQueue.main.asyncAfter(deadline: .now()+1){
                    self.loadingError = nil
                }
            }
        }
        switch category {
        case .recommend:
            NetworkAPI.recommendPostList(requestBlock)
        case .hot:
            NetworkAPI.hotPostList(requestBlock)
        }
    }
}



enum PostListCategory{
    case recommend,hot
}

