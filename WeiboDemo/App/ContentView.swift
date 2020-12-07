//
//  ContentView.swift
//  WeiboDemo
//
//  Created by ac on 2020/11/26.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        Text("Hello, World!")
        HomeView(leftPercent:1).environmentObject(UserData())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//        Text("Hello, World!2")
    }
}
