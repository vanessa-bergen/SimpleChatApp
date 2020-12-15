//
//  ContentView.swift
//  ChatApp
//
//  Created by Vanessa Bergen on 2020-12-14.
//  Copyright © 2020 Vanessa Bergen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var service = SocketManager()
    @State private var output = ""
    @State private var handle = ""
    @State private var message = ""
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ScrollView {
                    ForEach(self.service.messages, id: \.id) { chat in
                        HStack {
                            Text("\(chat.handle): ")
                                .bold()
                            Text(chat.message)
                            Spacer()
                        }
                        .padding([.leading, .trailing], 5)
                        .padding([.top, .bottom], 1)
                        
                    }.frame(maxWidth: .infinity)
                        
                }
                .border(Color.purple)
                .padding()
                    
                    
                TextField("Handle", text: self.$handle)
                    .border(Color.purple)
                    .frame(width: 0.9 * geo.size.width)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                UITextViewWrapper(text: self.$message, placeholder: "Message")
                    .border(Color.purple)
                    .frame(width: 0.9 * geo.size.width, height: 0.2 * geo.size.height)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                Button(action: {
                    // Send message here
                    self.service.send(with: self.handle, for: self.message)
                }) {
                    Text("Send!")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                }
                .background(Color.purple)
                .cornerRadius(25)
                .padding(.bottom)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
