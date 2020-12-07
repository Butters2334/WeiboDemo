//
//  extension.swift
//  WeiboDemo
//
//  Created by ac on 2020/12/3.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

extension View {
    func setBorderColor(_ c: Color) -> some View {
        self
            .padding(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(c,lineWidth:1)
            )
    }
}
