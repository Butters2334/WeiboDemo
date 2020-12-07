//
//  KetboardResponder.swift
//  WeiboDemo
//
//  Created by ac on 2020/12/4.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

//监控键盘高度变动
class keyboardResponder : ObservableObject {
    @Published var keyboardHeight : CGFloat = 0
    
    var keyboardShow : Bool {keyboardHeight > 0}
    
    init(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        //iOS9
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillHide(_ notifiction : Notification){
        keyboardHeight = 0
    }
    @objc private func keyboardWillShow(_ notifiction : Notification){
        guard let frame = notifiction.userInfo?[UIWindow.keyboardFrameEndUserInfoKey] as? CGRect else{
            return
        }
        keyboardHeight = frame.height
    }
}
