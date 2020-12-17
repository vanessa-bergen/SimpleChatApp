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
    @State private var createNew = true
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack {
                    Text(self.createNew ? "Create New Chat Room" : "Join Existing Chat Room")
                        .font(.headline)
                        .foregroundColor(Color.btnBlue)
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
                        Text(self.createNew ? "Create!" : "Join!")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                    }
                        .frame(width: 0.9 * geo.size.width)
                        .contentShape(Rectangle())
                        .background(Color.btnBlue)
                        
                    VStack(spacing: 10) {
                        Divider()
                        Text("OR")
                            .font(.headline)
                            .foregroundColor(Color.gray)
                        Divider()
                    }
                        .frame(width: 0.9 * geo.size.width)
                    
                    Button(action: {
                        self.createNew.toggle()
                    }) {
                        Text(self.createNew ? "Join Existing Chat" : "Create New Chat")
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
