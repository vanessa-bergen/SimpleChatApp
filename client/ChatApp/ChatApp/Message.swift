//
//  Message.swift
//  ChatApp
//
//  Created by Vanessa Bergen on 2020-12-14.
//  Copyright © 2020 Vanessa Bergen. All rights reserved.
//

import SwiftUI

class Message: Codable {
    private(set) var _id: String
    private(set) var handle: String
    private(set) var message: String
    
    init(handle: String, message: String) {
        self._id = UUID().uuidString
        self.message = message
        self.handle = handle
    }
}
