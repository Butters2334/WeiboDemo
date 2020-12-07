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
        
    }
    func updateText(_ text:String){
        DispatchQueue.main.async {
            self.text = text
        }
    }
}

struct URLSessionDemo_Previews: PreviewProvider {
    static var previews: some View {
        URLSessionDemo()
    }
}
