//
//  CreateChatView.swift
//  ChatApp
//
//  Created by Vanessa Bergen on 2020-12-17.
//  Copyright © 2020 Vanessa Bergen. All rights reserved.
//

import SwiftUI

struct CreateChatView: View {
    
    @State private var chatName = ""
    @State private var isSelected = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack {
                    Text("Create New Room")
                    TextField("Enter Chat Name", text: self.$chatName,  onEditingChanged: { (edit) in
                               if edit {
                                   // focused
                                    self.isSelected = true
                               } else {
                                   // not focused
                                    self.isSelected = false
                               }
                        })
                        .textFieldStyle(MyTextFieldStyle(isSelected: self.$isSelected))
                        .frame(width: 0.9 * geo.size.width)
                    NavigationLink(destination: ContentView(chatName: self.chatName)) {
                        Text("Create!")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                    }
                        .frame(width: 0.9 * geo.size.width)
                        .background(Color.btnBlue)
                        
                    Button(action: {
                        
                    }) {
                        Text("Or Join Existing")
                    }
                        .padding()
                }
            }
            .navigationBarTitle("Enter Chat", displayMode: .inline)
        }
    }
}

struct CreateChatView_Previews: PreviewProvider {
    static var previews: some View {
        CreateChatView()
    }
}
