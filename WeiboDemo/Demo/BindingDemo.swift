//
//  BindingDemo.swift
//  WeiboDemo
//
//  Created by ac on 2020/12/3.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

struct BindingDemo: View {
    @Binding var bIndex : Int
    init(bIndex:Binding<Int>){
        self._bIndex = bIndex
    }
    var body: some View {
        VStack(spacing:30){
            Text("bIndex = \(bIndex)")
            Button(action: {
                self.bIndex += 1
            }) {
                Text("index + 1")
            }
        }
    }
}


struct StateView : View {
    @State var sIndex : Int = 0
    var body: some View {
        VStack(spacing:20){
            //传递sIndex的指针
            BindingDemo(bIndex: $sIndex)
                .setBorderColor(.red)
            //传递sIndex的指针
            BindingDemo(bIndex: $sIndex)
                .setBorderColor(.gray)
            VStack{
                Text("sIndex = \(sIndex)")
                Button(action: {
                    self.sIndex += 1
                }) {
                    Text("index + 1")
                }
            }
            .setBorderColor(.orange)
        }
    }
}

struct BindingDemo_Previews: PreviewProvider {
    static var previews: some View {
        StateView()
    }
}
