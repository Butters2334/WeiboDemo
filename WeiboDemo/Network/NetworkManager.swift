//
//  NetworkManager.swift
//  WeiboDemo
//
//  Created by ac on 2020/12/7.
//  Copyright © 2020 ancc. All rights reserved.
//

import Foundation
import Alamofire


let NetworkAPIBaseURL = "https://raw.githubusercontent.com/anmac/WeiboDemo/master/WeiboDemo/Resources/"

//缺少网络模块对外响应
class NetworkManager {
    static let shared = NetworkManager()
    private init(){}//避免外部另外创建对象
    
    var commonHeaders: HTTPHeaders {["user_id":"123","token":"XXOOXXOOXXOO"]}
    
    typealias NMResult = Result<Data,Error>
    typealias NMCompletion = (NMResult) -> Void
    typealias NMRequest = DataRequest

    @discardableResult
    func requestGet(path:String,
                    parameters:Parameters?,
                    completion:@escaping NMCompletion)->NMRequest{
        AF.request(NetworkAPIBaseURL + path ,
                   parameters: parameters ,
                   headers: commonHeaders,
                   requestModifier: {$0.timeoutInterval = 15})
            .responseData { response in
                switch response.result {
                case let .success(data): completion(.success(data))
                case let .failure(error):completion(self.handleError(error))
                }
        }
    }
    
    @discardableResult
    func requestPost(path:String,
                    parameters:Parameters?,
                    completion:@escaping NMCompletion)->NMRequest{
        AF.request(NetworkAPIBaseURL + path ,
                   method:.post,
                   parameters: parameters ,
                   encoding: JSONEncoding.prettyPrinted,
                   headers: commonHeaders,
                   requestModifier: {$0.timeoutInterval = 15})
            .responseData { response in
                switch response.result {
                case let .success(data): completion(.success(data))
                case let .failure(error):completion(self.handleError(error))
                }
        }
    }
    
    private func handleError(_ error:AFError)->NMResult{
        //网络问题集中处理
        if let underlyingError = error.underlyingError {
            let nserror = underlyingError as NSError
            let code = nserror.code
            if  code == NSURLErrorNotConnectedToInternet ||
                code == NSURLErrorTimedOut ||
                code == NSURLErrorInternationalRoamingOff ||
                code == NSURLErrorDataNotAllowed ||
                code == NSURLErrorCannotFindHost ||
                code == NSURLErrorCannotConnectToHost ||
                code == NSURLErrorNetworkConnectionLost {
                var userInfo = nserror.userInfo
                userInfo[NSLocalizedDescriptionKey] = "网络连接有问题!"
                let currentError = NSError(domain: nserror.domain, code: code, userInfo: userInfo)
                return .failure(currentError)
            }
        }
        return .failure(error)
    }
}
