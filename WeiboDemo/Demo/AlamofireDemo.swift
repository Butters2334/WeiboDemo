//
//  AlamofireDemo.swift
//  WeiboDemo
//
//  Created by ac on 2020/12/7.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI
import Alamofire

struct AlamofireDemo: View {
    @State var text:String = ""
    var body: some View {
        VStack(spacing:20){
            Text(String(describing: type(of: AlamofireDemo.self)))
            Text(text).font(.system(size:35))
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
        AF.request(url).responseData { response in
            switch response.result {
            case let .success(data):
                guard let postList = try? JSONDecoder().decode(PostList.self, from: data) else {
                    self.updateText("Can not parse data")
                    return
                }
                self.updateText("Post count = \(postList.list.count)")
            case let .failure(error):
                self.updateText(error.localizedDescription)
            }
        }
    }
    func updateText(_ text:String){
        self.text = text
    }
    
}

struct AlamofireDemo_Previews: PreviewProvider {
    static var previews: some View {
        AlamofireDemo()
    }
}
