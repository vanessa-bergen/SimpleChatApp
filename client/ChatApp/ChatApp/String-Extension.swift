//
//  String-Extension.swift
//  ChatApp
//
//  Created by Vanessa Bergen on 2020-12-31.
//  Copyright © 2020 Vanessa Bergen. All rights reserved.
//

import Foundation

extension String {
    var boolValue: Bool {
        return (self as NSString).boolValue
    }
}
