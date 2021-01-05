//
//  CreateChatView.swift
//  ChatApp
//
//  Created by Vanessa Bergen on 2020-12-17.
//  Copyright © 2020 Vanessa Bergen. All rights reserved.
//

import SwiftUI

struct CreateChatView: View {
    @ObservedObject var service = SocketManager()
    @State private var chatName = ""
    @State private var isSelected = false
    @State private var createNew = true
    @State private var errorShown = false
    @State private var action: Int? = 0
    @State private var errMsg = ""
    
    var disabled: Bool {
        return self.chatName.isEmpty
    }
    var apiCalls = APICalls()
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack(spacing: 10) {
                    NavigationLink(destination: ContentView(chatName: self.chatName, service: self.service), tag: 1, selection: self.$action) {
                        EmptyView()
                    }
                    Text(self.createNew ? "Create New Chat Room" : "Join Existing Chat Room")
                        .font(.headline)
                        .foregroundColor(Color.btnBlue)
                        .padding()
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
                        // add red outline to textfield if there is an error when trying to create the chat
                        .overlay(
                            RoundedRectangle(cornerRadius: 2)
                                .stroke(Color.red, lineWidth: 2)
                                .opacity(self.errorShown ? 1 : 0)
                        )
                        .frame(width: 0.9 * geo.size.width)
                    if self.errorShown {
                        Text(self.errMsg)
                            .foregroundColor(.red)
                            .frame(width: 0.9 * geo.size.width)
                    }
                    Button(action: {
                        self.enterChat()
                    }) {
                    Text(self.createNew ? "Create!" : "Join!")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth:.infinity)
                        
                    }
                        
                    
                        .disabled(self.disabled)
                        .frame(width: 0.9 * geo.size.width)
                        .background(Color.btnBlue)
                        .onTapGesture {
                            if self.disabled {
                                print("disabled")
                                self.errMsg = "Please enter a chat name."
                                withAnimation {
                                    self.errorShown = true
                                }
                            }
                        }
                        
                    VStack(spacing: 10) {
                        Divider()
                            .padding(.top)
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
    func enterChat() {
        if self.createNew {
            let newChat = Chat(name: self.chatName)
            self.apiCalls.sendData(Chat.self, for: newChat) { (result) in
                switch result {
                case .success((_, let response)):
                    print(response)
                    self.errorShown = false
                    self.action = 1
                case .failure(let error):
                    print(error.localizedDescription)
                    self.errMsg = error.localizedDescription
                    self.errorShown = true
                }
            }
        } else {
            self.apiCalls.getChat(for: self.chatName) { (result) in
                switch result {
                case .success(let response):
                    if response {
                        self.errorShown = false
                        self.action = 1
                    } else {
                        self.errMsg = "Chat Name does not exist. Please create new chat."
                        self.errorShown = true
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
    }
}

struct CreateChatView_Previews: PreviewProvider {
    static var previews: some View {
        CreateChatView()
    }
}
