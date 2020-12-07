//
//  URLSessionDemo.swift
//  WeiboDemo
//
//  Created by ac on 2020/12/7.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

struct URLSessionDemo: View {
    @State var text:String = ""
    var body: some View {
        VStack(spacing:20){
            Text(text)
            Button(action: {
                self.sendReqeust()
            }) {
                Text("Start").font(.largeTitle)
            }
            Button(action: {
                self.updateText("")
            }) {
                Text("Clear").font(.largeTitle)
            }
        }
    }
    func sendReqeust(){
        let url = "https://raw.githubusercontent.com/anmac/WeiboDemo/master/WeiboDemo/Resources/PostListData_recommend_1.json"
        HttpTool().GET(url: url) { (data, response, error) in
            if let error = error {
                self.updateText(error.localizedDescription)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200 else{
                self.updateText("Invalid response")
                return
            }
            guard let data = data else {
                self.updateText("no data")
                return
            } 
            guard let postList = try? HttpTool().dataToJson(PostList.self, from: data) else {
                self.updateText("Can not parse data")
                return
            }
            self.updateText("Post count = \(postList.list.count)")
        }
    }
    func updateText(_ text:String){
        DispatchQueue.main.async {
            self.text = text
        }
    }
    
}

class HttpTool {
    private let timeoutInterval = 15.0
    private func getRequest(url:String)->URLRequest{
        let url = URL(string:url)!
        var reqeust = URLRequest(url: url)
        reqeust.timeoutInterval = self.timeoutInterval
        reqeust.httpMethod = "GET"
        reqeust.httpBody = Data()
        reqeust.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return reqeust
    }
    func GET(url:String,
             handle:@escaping (Data?, URLResponse?, Error?) -> Void){
        var reqeust = getRequest(url: url)
        reqeust.httpMethod = "GET"
        URLSession.shared.dataTask(with: reqeust,completionHandler: handle).resume()
    }
    func POST(url:String,
              postDic:[String:String]=[:],
              handle:@escaping (Data?, URLResponse?, Error?) -> Void){
        var reqeust = getRequest(url: url)
        reqeust.httpMethod = "POST"
        reqeust.httpBody = jsonToData(json: postDic)
        URLSession.shared.dataTask(with: reqeust,completionHandler: handle).resume()
    }
    //json转为data
    func jsonToData(json:[String:String]=[:])->Data{
        return try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    }
    //data转为json
    func dataToJson<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable{
        return try JSONDecoder().decode(type, from: data)
    }
}

struct URLSessionDemo_Previews: PreviewProvider {
    static var previews: some View {
        URLSessionDemo()
    }
}
