//
//  PostImageCell.swift
//  WeiboDemo
//
//  Created by ac on 2020/11/27.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI
//import SDWebImageSwiftUI

private let kImageSpace:CGFloat = 6

struct PostImageCell: View {
    let images:[String]
    let width : CGFloat
    var body: some View {
        Group {
            if images.count==1 {
                loadImage(images[0])
                    .resizable()
                    .scaledToFill()
                    .frame(width:width,height: width*0.75)
                    .clipped()
            }else if images.count == 2 {
                PostImageCellRow(images: images, width: width)
            }else if images.count == 3 {
                PostImageCellRow(images: images, width: width)
            }else if images.count == 4 {
                VStack (spacing:kImageSpace){
                    PostImageCellRow(images: Array(images[0...1]), width: width)
                    PostImageCellRow(images: Array(images[2...3]), width: width)
                }
            }else if images.count == 5 {
                VStack (spacing:kImageSpace){
                    PostImageCellRow(images: Array(images[0...1]), width: width)
                    PostImageCellRow(images: Array(images[2...4]), width: width)
                }
            }else if images.count == 6 {
                VStack (spacing:kImageSpace){
                    PostImageCellRow(images: Array(images[0...2]), width: width)
                    PostImageCellRow(images: Array(images[3...5]), width: width)
                }
            }else{
               Text("不会出现6张图片的")
            }
        }
    }
}

struct PostImageCellRow:View {
    let images:[String]
    let width:CGFloat
    
    var itemWidth :CGFloat {
        (self.width-kImageSpace*CGFloat(self.images.count-1))/CGFloat(self.images.count)
    }
    var body: some View {
        HStack(spacing:kImageSpace){
            ForEach(images,id:\.self){
                image in
                loadImage(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width:self.itemWidth,height: self.itemWidth)
                    .clipped()
            }
        }
    }
}


struct PostImageCell_Previews: PreviewProvider {
    static var previews: some View {
        //要主要这里写了六个测试,所以要找有六张图片的数据
        let images = UserData().recommendPostList.list[0].images
        let width = UIScreen.main.bounds.width-15*2
        return Group{
            PostImageCell(images: Array(images[0...5]) ,width: width)
            PostImageCell(images: Array(images[0...4]) ,width: width)
            PostImageCell(images: Array(images[0...3]) ,width: width)
            PostImageCell(images: Array(images[0...2]) ,width: width)
            PostImageCell(images: Array(images[0...1]) ,width: width)
            PostImageCell(images: Array(images[0...0]) ,width: width)
        }
        .previewLayout(.fixed(width: width, height: 300))
    }
}
