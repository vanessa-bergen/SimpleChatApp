//
//  Message.swift
//  ChatApp
//
//  Created by Vanessa Bergen on 2020-12-14.
//  Copyright © 2020 Vanessa Bergen. All rights reserved.
//

import SwiftUI

class Message: Codable {
    var _id: String
    var handle = ""
    var message = ""
    
    init(handle: String, message: String) {
        self._id = UUID().uuidString
        self.message = message
        self.handle = handle
    }
}
