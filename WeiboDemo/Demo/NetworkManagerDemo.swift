//
//  NetworkManagerDemo.swift
//  WeiboDemo
//
//  Created by ac on 2020/12/7.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

struct NetworkManagerDemo: View {
    @State var text:String = " "
    var body: some View {
        VStack(spacing:20){
            Text(String(describing: type(of: NetworkManagerDemo.self)))
            Text(text).font(.system(size:35))
            Button(action: {
                self.sendReqeust()
            }) {
                Text("Start").font(.largeTitle)
            }
            Button(action: {
                self.updateText(" ")
            }) {
                Text("Clear").font(.largeTitle)
            }
        }
    }
    func sendReqeust(){
        NetworkAPI.hotPostList(){ result in
            switch result {
            case let .success(postList):
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

struct NetworkManagerDemo_Previews: PreviewProvider {
    static var previews: some View {
        NetworkManagerDemo()
    }
}
