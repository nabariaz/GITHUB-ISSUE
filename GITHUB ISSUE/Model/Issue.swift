//
//  Issue.swift
//  GITHUB ISSUE
//
//  Created by Naba Riaz on 9/9/22.
//

import Foundation

/// This is an Issue struct that contains all the objects to be decoded by JSON decoder
struct Issue: Codable {
    let url: String?
    let title: String?
    let user: User?
    let state: String?
    let comments: Int?
    let created_at: String?
}

/// This is a User struct whih is present inside the Issue struct
struct User: Codable {
    let login: String?
}
