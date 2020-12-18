//
//  TapDemo.swift
//  WeiboDemo
//
//  Created by ac on 2020/12/11.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

struct TapDemo: View {
    var body: some View {
        HStack(alignment: .top){
            VStack(spacing:0.0){
    //            ModifiedContent(content: Text("tap-a").font(.system(size:30)), modifier: TestModifier())
    //            Text("tap-b")
    //                .font(.system(size:30))
    //                .background(Color(UIColor{ trait -> UIColor in
    //                    .lightGray
    //                }))
    //                .modifier(TestModifier())
    //                .modifier(ColorStyle())
    //            .setColor()
                Text("Title")
                    .textStyle(.title)
    //                .modifier(ColorStyle())
                Text("subtitle")
                    .textStyle(.subtitle)
                    .padding(10.0)
    //            Image(systemName: "moon.zzz")
    //                .frame(width: 100, height: 100)
    //                .font(.system(size: 30, weight: .bold))
    //            Image(systemName: "sun.max")
    //                .frame(width: 100, height: 100)
    //                .font(.system(size: 30, weight: .light))
    //            TextField("", text: .constant(""), onEditingChanged: { (b) in
    //
    //            }) {
    //
    //            }
    //            .textFieldStyle(RoundedBorderTextFieldStyle())
    //                .padding(.leading,30)
    //                .padding(.trailing,100)
    //
    //            SecureField("test", text: .constant(""))
    //            .textFieldStyle(RoundedBorderTextFieldStyle())
    //                .padding(.leading,30)
    //                .padding(.trailing,100)
                
                Image("1024")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200, alignment: .center)
                    .border(Color.green, width: 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.red, lineWidth: 10)
                    )
                    .hidden()
                    .frame(height:0)
                
                ZStack{
                    Text("\t\t\t\t").background(Color.red)
                        .cornerRadius(10)
                        .border(Color.green, width: 1)
                    Divider()
                    Text("asasddsasd")
                }.frame(height:30)
                HStack(spacing:60){
                    VStack{
                        ForEach(0..<3){
                            Text("\($0)")
                        }
                    }
                    VStack{
                        ForEach((1...3).map{$0},id: \.self){
                            Text("\($0)")
                            .bold()
                        }
                    }
                    .border(Color.red)
                    .cornerRadius(10)
                }
                Group{
                    ForEach(0..<3){
                        Text("True\($0)")
                    }
                }
            }
        }
    }
}

extension Text {
    enum Style {
        case title
        case subtitle
    }
    func textStyle(_ style:Style) -> some View{
        switch style {
        case .title:
            return self
                .font(.system(size:50,weight:.bold))
                .foregroundColor(.color(forTextStyle: style))
        case .subtitle:
            return self
                .font(.system(size: 40))
            .foregroundColor(.color(forTextStyle: style))
        }
    }
}

extension Color {
    static func color(forTextStyle style:Text.Style) -> Color {
        switch style {
        case .title:
            return Color(
                UIColor{trait in
                    switch trait.userInterfaceStyle {
                    case .dark: return .white
                    default: return .darkGray
                    }
                }
            )
        case .subtitle:
            return .blue
        }
    }
}

struct TestModifier : ViewModifier {
    @State var selected = false
    func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(selected ? Color.red : Color.clear,lineWidth: 2)
                .animation(.easeInOut)
        )
        .simultaneousGesture(
            TapGesture().onEnded{
                self.selected.toggle()
            }
        )
    }
}
struct ColorStyle : ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.red)
            .background(Color.green)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.blue)
        )
    }
}

extension Text{
    func setColor()->some View{
        self
            .foregroundColor(.green) 
            .background(Color.red)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue)
            )
    }
}

struct TapDemo_Previews: PreviewProvider {
    static var previews: some View {
        TapDemo()
    }
}
