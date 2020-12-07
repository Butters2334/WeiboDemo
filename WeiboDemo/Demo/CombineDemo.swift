//
//  CombineDemo.swift
//  WeiboDemo
//
//  Created by ac on 2020/12/2.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI
import Combine

class DataClass : ObservableObject {
    @Published var index : Int = 0
}

struct TestButton : View {
    @EnvironmentObject var dataClass : DataClass
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .overlay(
                Text("index = \(dataClass.index)")
                    .foregroundColor(.white)
                    .frame(width:200,height:100)
            )
            .onTapGesture {
                self.dataClass.index += 1
            }
            .foregroundColor(.blue)
            .frame(width:200,height:100)
    }
}

struct CombineDemo: View {
    var body: some View {
        VStack{
            ForEach(1..<10){_ in 
                TestButton()
            }
        }
    }
}

struct CombineDemo_Previews: PreviewProvider {
    static var previews: some View {
        CombineDemo().environmentObject(DataClass())
    }
}
