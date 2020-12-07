//
//  ShapeDemo.swift
//  WeiboDemo
//
//  Created by ac on 2020/11/27.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

struct ShapeDemo: View {
    var body: some View {
        VStack{
            Circle()
                .foregroundColor(.green)
                .overlay(Text("圆形").foregroundColor(.white))
            Ellipse()
                .foregroundColor(.red)
                .overlay(Text("椭圆").foregroundColor(.white))
            Capsule()
                .foregroundColor(.gray)
                .overlay(Text("胶囊").foregroundColor(.white))
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.blue)
                .overlay(Text("圆角矩形").foregroundColor(.white))
            Rectangle()
                .foregroundColor(.orange)
                .overlay(Text("矩形").foregroundColor(.white))

            //多重嵌套
            Rectangle()
                .foregroundColor(.orange)
                .overlay(
                    RoundedRectangle(cornerRadius: 15).foregroundColor(.blue)
                )
                .overlay(
                    Capsule().foregroundColor(.gray)
                )
                .overlay(
                    Ellipse().foregroundColor(.red)
                )
                .overlay(
                    Circle().foregroundColor(.green)
                )            
        }
        .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30))
    }
}

struct ShapeDemo_Previews: PreviewProvider {
    static var previews: some View {
        ShapeDemo()
    }
}
