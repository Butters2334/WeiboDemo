//
//  QueueDemo.swift
//  WeiboDemo
//
//  Created by ac on 2020/12/9.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

struct QueueDemo: View {
    var body: some View {
        print("test1")
//        DispatchQueue.main.sync {
//            print("test2")
//        }
//        DispatchQueue.main.async {
//            print("test2a")
//        }
        DispatchQueue.main.asyncAfter(deadline:.now()){
            print("test2b")
        }
        print("test3")
        return Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct QueueDemo_Previews: PreviewProvider {
    static var previews: some View {
        QueueDemo()
    }
}
