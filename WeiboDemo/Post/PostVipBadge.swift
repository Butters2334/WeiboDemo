//
//  PostVipBadge.swift
//  WeiboDemo
//
//  Created by ac on 2020/11/26.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

struct PostVipBadge: View {
    let vip:Bool
    var body: some View {
        Group{
            if vip {
                Text("V")
                .bold()
                .font(.system(size: 11))
                .frame(width: 15, height: 15)
                .foregroundColor(.yellow)
                .background(Color.red)
                .clipShape(Circle())
                .overlay(RoundedRectangle(cornerRadius: 7.5).stroke(Color.white, lineWidth: 1))
            }
        }
    }
}

struct PostVipBadge_Previews: PreviewProvider {
    static var previews: some View {
        PostVipBadge(vip:true)
    }
}
