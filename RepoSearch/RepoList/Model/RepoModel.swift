//
//  RepoModel.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/16/23.
//

import Foundation

// MARK: - LanguageRepos
struct LanguageRepos: Codable {
    let totalCount: Int
    let items: [RepoModel]
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}

// MARK: - RepoModel
struct RepoModel: Codable, Identifiable {
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
    
    init(id: Int,
         openIssues: Int = 0,
         watchers: Int = 0,
         nodeID: String?,
         name: String?,
         fullName: String?,
         description: String?,
         url: String?,
         visibility: String?,
         user: User?,
         createdAt: Date?,
         updatedAt: Date?,
         pushedAt: Date?,
         archived: Bool = false,
         disabled: Bool = false
    ) {
        self.id = id
        self.openIssues = openIssues
        self.watchers = watchers
        self.nodeID = nodeID
        self.name = name
        self.fullName = fullName
        self.description = description
        self.url = url
        self.visibility = visibility
        self.user = user
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.pushedAt = pushedAt
        self.archived = archived
        self.disabled = disabled
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
        let createdAtStr = try? container.decode(String.self, forKey: .createdAt)
        let updatedAtStr = try? container.decode(String.self, forKey: .updatedAt)
        let pushedAtStr = try? container.decode(String.self, forKey: .pushedAt)
        self.createdAt = CustomFormatter.dateFormatter.date(from: createdAtStr ?? "") ?? nil
        self.updatedAt = CustomFormatter.dateFormatter.date(from: updatedAtStr ?? "") ?? nil
        self.pushedAt = CustomFormatter.dateFormatter.date(from: pushedAtStr ?? "") ?? nil
        self.archived = try container.decodeIfPresent(Bool.self, forKey: .archived) ?? false
        self.disabled = try container.decodeIfPresent(Bool.self, forKey: .disabled) ?? false
    }
}
