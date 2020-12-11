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
            Image(systemName: "moon.zzz")
                .frame(width: 100, height: 100)
                .font(.system(size: 30, weight: .bold))
            Image(systemName: "sun.max")
                .frame(width: 100, height: 100)
                .font(.system(size: 30, weight: .light))
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
