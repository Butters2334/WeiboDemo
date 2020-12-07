//
//  StateDemo.swift
//  WeiboDemo
//
//  Created by ac on 2020/12/3.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

struct StateDemo: View {
    @State var index:Int = 0
    var body: some View {
        VStack(spacing:30){
            Text("index = \(index)")
            
            Button(action: {
                self.index += 1
            }) {
                Text("index + 1")
            }
        }
    }
}

struct StateDemo_Previews: PreviewProvider {
    static var previews: some View {
        StateDemo()
    }
}
