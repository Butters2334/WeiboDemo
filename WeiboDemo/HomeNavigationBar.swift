//
//  HomeNavigationBar.swift
//  WeiboDemo
//
//  Created by ac on 2020/11/30.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

private let kLabelWidth:CGFloat = 60
private let kLabelHeight:CGFloat = 24

struct HomeNavigationBar: View {
    
    @Binding var leftPercent:CGFloat //0左,1右
    
    var body: some View {
        HStack(alignment: .top, spacing: 0){
            Button(action: {
                print("camera event")
            }) {
                Image(systemName: "camera")
                .resizable()
                .scaledToFill()
                    .frame(width:kLabelHeight,height: kLabelHeight)
                    .padding(.horizontal,15)
                    .padding(.top,5)
                    .foregroundColor(.black)
            }
            Spacer()
            
            VStack(spacing:3){
                HStack (spacing:0){
                    Text("推荐")
                        .bold()
                        .frame(width:kLabelWidth,height: kLabelHeight)
                        .padding(.top,5)
                        .opacity(Double(1-self.leftPercent*0.5))
                        .onTapGesture {
                            withAnimation{
                                self.leftPercent = 0
                            }
                        }
                    Spacer()
                    Text("热门")
                        .bold()
                        .frame(width:kLabelWidth,height: kLabelHeight)
                        .padding(.top,5)
                        .opacity(Double(0.5+self.leftPercent*0.5))
                        .onTapGesture {
                            withAnimation {
                                self.leftPercent = 1
                            }
                        }
                }.font(.system(size: 20))
            
                //动态撑满
                GeometryReader() {
                    geometry in
                    RoundedRectangle(cornerRadius: 2)
                        .foregroundColor(.orange)
                        .frame(width:30,height:4)
                        //在更新Xcode到12之后出现了偏移的bug
                        .offset(x:geometry.size.width*(self.leftPercent-0.5)+kLabelWidth*(0.5-self.leftPercent))
                        //.offset(x:self.leftPercent==0 ? kLabelWidth*0.25 : geometry.size.width-30-kLabelWidth*0.25)
                }.frame(height:6)
            }
            .frame(width:UIScreen.main.bounds.width*0.4)

            Spacer()
            Button(action: {
                print("add event")
            }) {
                Image(systemName: "plus.circle.fill")
                .resizable()
                .scaledToFill()
                    .frame(width:kLabelHeight,height: kLabelHeight)
                    .padding(.horizontal,15)
                    .padding(.top,5)
                    .foregroundColor(.orange)
            }
        }.frame(width:UIScreen.main.bounds.width)
    }
}

struct HomeNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavigationBar(leftPercent: .constant(1))
    }
}
