//
//  UserModel.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/17/23.
//

import Foundation

typealias Users = [User]

// MARK: - User
struct User: Codable, Identifiable {
    let login, nodeID, avatarURL, url, type: String?
    let id, contributions: Int

    enum CodingKeys: String, CodingKey {
        case login, id, contributions, url, type
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
    }
    
    init (login: String?,
          nodeID: String?,
          avatarURL: String?,
          url: String?,
          type: String?,
          id: Int,
          contributions: Int
    ) {
        
        self.id = id
        self.login = login
        self.nodeID = nodeID
        self.avatarURL = avatarURL
        self.url = url
        self.type = type
        self.contributions = contributions
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.login = try? container.decodeIfPresent(String.self, forKey: .login)
        self.nodeID = try? container.decodeIfPresent(String.self, forKey: .nodeID)
        self.avatarURL = try? container.decode(String.self, forKey: .avatarURL)
        self.url = try? container.decode(String.self, forKey: .url)
        self.type = try? container.decode(String.self, forKey: .type)
        self.contributions = try container.decodeIfPresent(Int.self, forKey: .contributions) ?? 0
    }
}
