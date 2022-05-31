//
//  Alert+Extension.swift
//  EmployeeDirectory
//
//  Created by Vivek M on 31/05/22.
//

import SwiftUI

extension Alert {
    static func alert(title: String? = nil,
                      message: String? = nil,
                      completionHandler: (() -> ())? = nil) -> Alert {
        
        let dismissButtonTitle = "OK"
        let title = Text(title ?? "Note")
        let message: Text? = message == nil ? nil : Text(message ?? "")
        return Alert(
            title: title,
            message: message,
            dismissButton: .cancel(Text(dismissButtonTitle), action: {
                completionHandler?()
            })
        )
    }
}
