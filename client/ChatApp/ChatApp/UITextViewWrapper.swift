//
//  UITextViewWrapper.swift
//  ChatApp
//
//  Created by Vanessa Bergen on 2020-12-14.
//  Copyright © 2020 Vanessa Bergen. All rights reserved.
//

import SwiftUI

struct UITextViewWrapper: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    var placeholderActive = true
    var textColor: UIColor {
        return placeholderActive ? UIColor.placeholderText : UIColor.black
    }
    
    func makeUIView(context: Context) -> UITextView {
        
        let view = UITextView()
        view.delegate = context.coordinator
        
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.textAlignment = .left
        view.font = UIFont.preferredFont(forTextStyle: .body)
        view.adjustsFontForContentSizeCategory = true
        
        view.text = placeholder
        view.textColor = textColor
        
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {

    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: UITextViewWrapper
        
        init(_ parent: UITextViewWrapper) {
            self.parent = parent
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if parent.text.isEmpty {
                textView.text = nil
            }
            self.parent.placeholderActive = false
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if parent.text.isEmpty {
                textView.text = parent.placeholder
                self.parent.placeholderActive = true
                textView.textColor = parent.textColor
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            if !parent.placeholderActive {
                self.parent.text = textView.text
            }
            textView.textColor = parent.textColor
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}


