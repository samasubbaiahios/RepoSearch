//
//  RepoModel.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/16/23.
//

import Foundation

// MARK: - PublicRepos
struct PublicRepos: Codable {
    let totalCount: Int
    let items: [RepoModel]
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}

// MARK: - RepoModel
struct RepoModel: Codable {
    let id, openIssues, watchers: Int
    var nodeID, name, fullName, description, url, visibility: String?
    let user: User?
    let createdAt, updatedAt, pushedAt: Date?
    let archived, disabled: Bool

    enum CodingKeys: String, CodingKey {
        case id, name, description, url, archived, disabled, visibility, watchers
        case nodeID = "node_id"
        case fullName = "full_name"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case openIssues = "open_issues"
        case user = "owner"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.openIssues = try container.decodeIfPresent(Int.self, forKey: .openIssues) ?? 0
        self.watchers = try container.decodeIfPresent(Int.self, forKey: .watchers) ?? 0
        self.nodeID = try? container.decode(String.self, forKey: .nodeID)
        self.name = try? container.decode(String.self, forKey: .name)
        self.fullName = try? container.decode(String.self, forKey: .fullName)
        self.description = try? container.decode(String.self, forKey: .description)
        self.url = try? container.decode(String.self, forKey: .url)
        self.visibility = try? container.decodeIfPresent(String.self, forKey: .visibility)
        self.user = try container.decodeIfPresent(User.self, forKey: .user)
        self.createdAt = try? container.decodeIfPresent(Date.self, forKey: .createdAt)
        self.updatedAt = try? container.decodeIfPresent(Date.self, forKey: .updatedAt)
        self.pushedAt = try? container.decodeIfPresent(Date.self, forKey: .pushedAt)
        self.archived = try container.decodeIfPresent(Bool.self, forKey: .archived) ?? false
        self.disabled = try container.decodeIfPresent(Bool.self, forKey: .disabled) ?? false
    }
}
