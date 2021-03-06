//
//  ContentView.swift
//  ChatApp
//
//  Created by Vanessa Bergen on 2020-12-14.
//  Copyright © 2020 Vanessa Bergen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode
    var chat: Chat?
    @ObservedObject var service: SocketManager
    @State private var output = ""
    @State private var handle = ""
    @State private var message = ""
    @State private var showingAlert = false
    
    var body: some View {
        
        GeometryReader { geo in
            VStack {
                ScrollView {
                    ForEach(self.service.messages, id: \._id) { msg in
                        VStack {
                            Text(msg.message)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.btnBlue.opacity(0.7))
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                
                            
                            HStack {
                                Text("\(msg.handle) ")
                                    .font(.footnote)
                                Spacer()
                                Text(msg.dateFormatted)
                                    .font(.footnote)
                            }
                        }
                        .padding([.leading, .trailing], 5)
                        .padding([.top, .bottom], 5)
                        
                    }.frame(maxWidth: .infinity)
                        
                }
                .background(Color.backgroundGrey)
                .border(Color.borderGrey)
                .padding()
                    
                    
                TextField("Handle", text: self.$handle)
                    .border(Color.borderGrey)
                    .frame(width: 0.9 * geo.size.width)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                UITextViewWrapper(text: self.$message, placeholder: "Message")
                    .border(Color.borderGrey)
                    .frame(width: 0.9 * geo.size.width, height: 0.2 * geo.size.height)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                Button(action: {
                    // Send message here
                    // save to unwrap chat, since we make sure the chat exists when this view opens
                    self.service.send(in: self.chat!, with: self.handle, for: self.message)
                }) {
                    Text("Send!")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                }
                .frame(width: 0.9 * geo.size.width)
                .background(Color.btnBlue)
                .padding(.bottom)
                
            }
            .navigationBarTitle(self.chat != nil ? "\(self.chat!.name)" : "")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()

                    }) {
                        Text("Exit Chat")
                    }
            )
            .navigationBarBackButtonHidden(true)
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Unexpected Error Occurred"),
                message: Text("Please try again."),
                dismissButton: .default(Text("OK!")) {
                    self.presentationMode.wrappedValue.dismiss()
                }
            )
        }
        .onAppear {
            self.initChat()
        }
    }
    
    func initChat() {
        // check that chat exists, otherwise return an error
        guard let chat = self.chat else {
            self.showingAlert = true
            return
        }
        // load existing messages in chat
        self.service.loadMessages(for: chat.name)
    }
}
