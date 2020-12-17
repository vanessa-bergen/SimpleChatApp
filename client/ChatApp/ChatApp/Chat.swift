//
//  Chat.swift
//  ChatApp
//
//  Created by Vanessa Bergen on 2020-12-17.
//  Copyright © 2020 Vanessa Bergen. All rights reserved.
//

import SwiftUI

class Chat: Codable {
    private var name: String
    
    init(name: String) {
        self.name = name
    }
}
