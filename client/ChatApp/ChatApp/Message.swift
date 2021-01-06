//
//  Message.swift
//  ChatApp
//
//  Created by Vanessa Bergen on 2020-12-14.
//  Copyright © 2020 Vanessa Bergen. All rights reserved.
//

import SwiftUI

class Message: Codable, Fetchable {
    static var apiBase = "message"
    
    private(set) var _id: String
    private(set) var handle: String
    private(set) var message: String
    private(set) var date: String
    private(set) var chat: Chat
    
    //using static so that the dateFormatter is created the first time it is called, after that it will reuse the same instance
    private static let dateFormatter: DateFormatter = DateFormatter()
    var dateFormatted: String {
        Message.dateFormatter.date(fromJSON: date)
    }
    
    
    enum CodingKeys: CodingKey {
        case _id, handle, message, date, chat
    }
    init(chat: Chat, handle: String, message: String) {
        self._id = UUID().uuidString
        self.message = message
        self.handle = handle
        self.date = ""
        self.chat = chat
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_id, forKey: ._id)
        try container.encode(handle, forKey: .handle)
        try container.encode(message, forKey: .message)
        try container.encode(chat.name, forKey: .chat)
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        _id = try container.decode(String.self, forKey: ._id)
        handle = try container.decode(String.self, forKey: .handle)
        message = try container.decode(String.self, forKey: .message)
        date = try container.decode(String.self, forKey: .date)
        chat = try container.decode(Chat.self, forKey: .chat)

    }
    
    
}
