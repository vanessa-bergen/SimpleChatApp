//
//  MyTextFieldStyle.swift
//  ChatApp
//
//  Created by Vanessa Bergen on 2020-12-17.
//  Copyright © 2020 Vanessa Bergen. All rights reserved.
//

import SwiftUI

struct MyTextFieldStyle: TextFieldStyle {
    @Binding var isSelected: Bool
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 2, style: .continuous)
                .stroke(isSelected ? Color.btnBlue : Color.borderGrey, lineWidth: 1)
        )
    }
}
