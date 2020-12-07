//
//  RoundedRectangleDemo.swift
//  WeiboDemo
//
//  Created by ac on 2020/12/2.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

//struct Text3 : View {
//    @State var cornerRadius : CGFloat = 10.0
//    var body: some View {
//        VStack{
//            RoundedRectangleDemo(contentSize:CGSize(width: 300, height: 300),cornerRadius: $cornerRadius) {
//                Rectangle()
//                    .frame(width:300,height:300)
//                    .foregroundColor(.gray)
//            }
//            Button(action: {
//                self.cornerRadius += 10
//            }) {
//                Text("cornerRadius + 10")
//            }
//        }
//    }
//}
//
////只是预览功能
//struct RoundedRectangleDemo_Previews: PreviewProvider {
//    static var previews: some View {
//        Text3()
//    }
//}
//
////尝试使用UIKit切圆角的api
//struct RoundedRectangleDemo<Content:View>: UIViewControllerRepresentable {
//
//    @Binding var cornerRadius : CGFloat
//    let content : Content
//    let contentSize : CGSize
//
//    //圆角可变动,通过外部传入
//    init(contentSize : CGSize,
//         cornerRadius : Binding<CGFloat>,
//         content : ()->Content){
//
//        self.contentSize = contentSize
//        self._cornerRadius = cornerRadius
//        self.content = content()
//    }
//
//    //创建VC,将传入View封装为VC
//    func makeUIViewController(context: Context) ->  UIViewController {
//        let vc = UIViewController()
//
//        //要注意host的frame是不能修改的
//        let host = UIHostingController(rootView: content)
//        vc.addChild(host)
//        vc.view.addSubview(host.view)
//        host.didMove(toParent: vc)
//        context.coordinator.host = host
//
//        let hostView = context.coordinator.host.view!
//        hostView.frame = CGRect(origin: .zero, size: contentSize)
//        hostView.backgroundColor = .red
//        hostView.layer.masksToBounds=true
//
//        return vc
//    }
//    //需要变更view参数的部分代码写到update函数中
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//        let hostView = context.coordinator.host.view!
//        //外部修改cornetRadius时,Binding会响应
//        hostView.layer.cornerRadius = cornerRadius
//    }
//
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(self)
//    }
//    class Coordinator : NSObject {
//        let parent: RoundedRectangleDemo
//        var host: UIHostingController<Content>!
//
//        init(_ parent:RoundedRectangleDemo){
//            self.parent = parent
//        }
//    }
//}



//在SwiftUi中使用UIkit封装的功能
struct RoundedRectangleDemo_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectangleDemo(contentSize:CGSize(width: 300, height: 300),cornerRadius: 100) {
            Rectangle()
        }
    }
}
//尝试使用UIKit切圆角的api
struct RoundedRectangleDemo<Content:View>: UIViewControllerRepresentable {
    var cornerRadius : CGFloat
    let content : Content
    let contentSize : CGSize
    //圆角可变动,通过外部传入
    init(contentSize : CGSize,
         cornerRadius : CGFloat,
         content : ()->Content){
        self.contentSize = contentSize
        self.cornerRadius = cornerRadius
        self.content = content()
    }
    //创建VC,将传入View封装为VC
    func makeUIViewController(context: Context) ->  UIViewController {
        let vc = UIViewController()
        //要注意host的frame是不能修改的
        let host = UIHostingController(rootView: content)
        vc.addChild(host)
        vc.view.addSubview(host.view)
        host.didMove(toParent: vc)
        context.coordinator.host = host
        //区别哪些功能是静态不需要变动的
        host.view.frame = CGRect(origin: .zero, size: contentSize)
        host.view.layer.masksToBounds=true
        return vc
    }
    //需要变更view参数的部分代码写到update函数中
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        let hostView = context.coordinator.host.view!
        //外部修改cornetRadius时,Binding会响应
        hostView.layer.cornerRadius = cornerRadius
    }
    //类似委托
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    //封装一个对象由于传递委托
    class Coordinator : NSObject {
        var host: UIHostingController<Content>!
    }
}
