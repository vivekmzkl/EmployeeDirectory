//
//  EmployeeItem.swift
//  EmployeeDirectory
//
//  Created by Vivek M on 31/05/22.
//

import Foundation

struct EmployeeItem {
    let id: Int
    let name, username, email: String
    let profileImage: String
    let phone: String?
    let website: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, username, email
        case profileImage = "profile_image"
        case phone, website
    }
}
