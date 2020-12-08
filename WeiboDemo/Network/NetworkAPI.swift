//
//  NetworkAPI.swift
//  WeiboDemo
//
//  Created by ac on 2020/12/8.
//  Copyright © 2020 ancc. All rights reserved.
//

import Foundation

//缺少登录状态判断
class NetworkAPI {
    @discardableResult
    static func recommendPostList(_ completion: @escaping (Result<PostList,Error>)->Void)->NetworkManager.NMRequest{
        NetworkManager.shared.requestGet(path: "PostListData_recommend_1.json", parameters: nil) { result in
            switch result {
            case let .success(data):
                completion(parseData(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    @discardableResult
    static func hotPostList(_ completion: @escaping (Result<PostList,Error>)->Void)->NetworkManager.NMRequest{
        NetworkManager.shared.requestGet(path: "PostListData_hot_1.json", parameters: nil) { result in
            switch result {
            case let .success(data):
                completion(parseData(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    private static func parseData<T:Decodable>(_ data:Data) -> Result<T,Error> {
        guard let decodedData = try? JSONDecoder().decode(T.self,from:data) else {
            let error = NSError(domain: "NetworkAPIError", code: 1002, userInfo: [NSLocalizedDescriptionKey:"Can not parse data"])
            return .failure(error)
        }
        return .success(decodedData)
    }
}
