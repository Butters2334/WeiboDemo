//
//  CommentTextView.swift
//  WeiboDemo
//
//  Created by ac on 2020/12/4.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

struct CommentTextView: UIViewRepresentable {
    @Binding var text : String
    
    let beginEdittingOnAppear : Bool

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.backgroundColor = .systemGray6
        view.font = .systemFont(ofSize: 18)
        view.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        view.delegate = context.coordinator
        view.text = text
        return view
    }
    func updateUIView(_ uiView: UITextView, context: Context) {
        if beginEdittingOnAppear &&
            !context.coordinator.didBecomeFirstResponder &&
            uiView.window != nil &&
            !uiView.isFirstResponder {
            
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator : NSObject,UITextViewDelegate {
        let parent : CommentTextView
        var didBecomeFirstResponder : Bool = false
        
        init(_ view : CommentTextView) {
            self.parent = view
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}

struct CommentTextView_Previews: PreviewProvider {
    static var previews: some View {
        CommentTextView(text: .constant(""),beginEdittingOnAppear: true)
    }
}
