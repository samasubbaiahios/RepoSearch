//
//  UserModel.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/17/23.
//

import Foundation

// MARK: - User
struct User: Codable {
    let login, nodeID, avatarURL, url, type: String?
    let id: Int

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case url, type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.login = try? container.decodeIfPresent(String.self, forKey: .login)
        self.nodeID = try? container.decodeIfPresent(String.self, forKey: .nodeID)
        self.avatarURL = try? container.decode(String.self, forKey: .avatarURL)
        self.url = try? container.decode(String.self, forKey: .url)
        self.type = try? container.decode(String.self, forKey: .type)
    }
}
