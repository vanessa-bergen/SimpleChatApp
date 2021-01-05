//
//  SocketManager.swift
//  ChatApp
//
//  Created by Vanessa Bergen on 2020-12-14.
//  Copyright © 2020 Vanessa Bergen. All rights reserved.
//

import Foundation
import Starscream

class SocketManager: ObservableObject, WebSocketDelegate {
    @Published var messages = [Message]()
    var socket: WebSocket!
    var isConnected = false
    let server = WebSocketServer()
    var apiCalls = APICalls()
    
    init() {
        
        var request = URLRequest(url: URL(string: "http://localhost:4000")!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
        
    }
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            isConnected = true
            //print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            isConnected = false
            //print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
            let data = string.data(using: .utf8)!
            self.decodeMessage(from: data)
        case .binary(let data):
            print("Received data: \(data.count)")
            self.decodeMessage(from: data)
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            handleError(error)
        }
    }
    
    func handleError(_ error: Error?) {
        if let e = error as? WSError {
            print("websocket encountered an error: \(e.message)")
        } else if let e = error {
            print("websocket encountered an error: \(e.localizedDescription)")
        } else {
            print("websocket encountered an error")
        }
    }
    
    func join(in chat_id: String) {
        guard let json = try? JSONEncoder().encode(["room" : chat_id ]) else {
            print("failed to encode chat room")
            return
        }
        socket.write(data: json) {
            print("joined")
        }
    }
    // TODO: change this to pass in chat object
    func send(in chat: String, with handle: String, for message: String) {
//        let data = Message(handle: handle, message: message)
//
//        guard let json = try? JSONEncoder().encode(data) else {
//            print("Failed to encode message")
//            return
//        }
//
//        socket.write(data: json) {
//            print("sent message \(json)")
//        }
        let message = Message(chat: Chat(name: chat), handle: handle, message: message)
        apiCalls.sendData(Message.self, for: message) { (result) in
            switch result {
            case .success((let data, let response)):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // decode message sent from server to Message type
    func decodeMessage(from message: Data) {
        if let decodedMsg = try? JSONDecoder().decode(Message.self, from: message) {
            print(decodedMsg.message)
            self.messages.append(decodedMsg)
        } else {
            print("Invalid response from server")
        }
    }
    
    func loadMessages(for chatName: String) {
        // load old messages here, will want to only load a certain amount
        print("load messages for chat \(chatName)")
        apiCalls.getMessages(for: chatName) { (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                    self.messages = data
                    print("messages \(self.messages)")
                }
            case .failure(let error):
                print("error")
            }
        }
    }
    
}

