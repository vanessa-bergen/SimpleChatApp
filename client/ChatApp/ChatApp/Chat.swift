//
//  Chat.swift
//  ChatApp
//
//  Created by Vanessa Bergen on 2020-12-17.
//  Copyright © 2020 Vanessa Bergen. All rights reserved.
//

import SwiftUI

class Chat: Codable, Fetchable {
    static var apiBase = "chat"
    
    private(set) var _id: String
    private(set) var name: String
    
    init(name: String) {
        self._id = UUID().uuidString
        self.name = name
    }
}
