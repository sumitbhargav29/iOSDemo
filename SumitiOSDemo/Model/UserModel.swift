//
//  UserModel.swift
//  SumitiOSDemo
//
//  Created by SamMac on 03/05/24.
//

import Foundation

// MARK: - PostModel
class PostModel: Codable {
    let userID, id: Int?
    let title, body: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
    
    init(userID: Int?, id: Int?, title: String?, body: String?) {
        self.userID = userID
        self.id = id
        self.title = title
        self.body = body
    }
}


