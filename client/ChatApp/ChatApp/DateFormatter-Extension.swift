//
//  DateFormatter-Extension.swift
//  ChatApp
//
//  Created by Vanessa Bergen on 2021-01-06.
//  Copyright © 2021 Vanessa Bergen. All rights reserved.
//

import Foundation

extension DateFormatter {
    // convert date string from server to Date object then to String
    func date(fromJSON dateString: String) -> String {
        // JSON Date from server comes in the form : "2021-01-06T14:05:35.048Z"
        self.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
        self.timeZone = TimeZone(abbreviation: "UTC")
        self.locale = Locale(identifier: "en_US_POSIX")
        let convertedDate = self.date(from: dateString)
        
        self.dateFormat = "yyyy-MM-dd h:mm a"
        self.timeZone = TimeZone.current
        guard let date = convertedDate else {
            print("Error converting date")
            return ""
        }
        return self.string(from: date)
    }
}
