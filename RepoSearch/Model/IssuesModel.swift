//
//  IssuesModel.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/17/23.
//

import Foundation

typealias Issues = [Issue]

// MARK: - Issue
struct Issue: Codable {
    let title, nodeID, url, repositoryURL, commentsURL, assignee, authorAssociation, state, body: String?
    let id, number, comments: Int
    let draft, locked: Bool
    let createdAt, updatedAt, closedAt: Date?
    let user: User

    enum CodingKeys: String, CodingKey {
        case url, id, number, title, user, state, locked, assignee, comments, draft, body
        case repositoryURL = "repository_url"
        case commentsURL = "comments_url"
        case nodeID = "node_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case closedAt = "closed_at"
        case authorAssociation = "author_association"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.number = try container.decode(Int.self, forKey: .number)
        self.comments = try container.decode(Int.self, forKey: .comments)

        self.url = try? container.decode(String.self, forKey: .url)
        self.nodeID = try? container.decodeIfPresent(String.self, forKey: .nodeID)
        self.repositoryURL = try? container.decode(String.self, forKey: .repositoryURL)
        self.title = try? container.decode(String.self, forKey: .title)
        self.commentsURL = try? container.decode(String.self, forKey: .commentsURL)
        self.assignee = try? container.decode(String.self, forKey: .assignee)
        self.authorAssociation = try? container.decode(String.self, forKey: .authorAssociation)
        self.state = try? container.decode(String.self, forKey: .state)
        self.body = try? container.decode(String.self, forKey: .body)
        self.createdAt = try? container.decodeIfPresent(Date.self, forKey: .createdAt)
        self.updatedAt = try? container.decodeIfPresent(Date.self, forKey: .updatedAt)
        self.closedAt = try? container.decodeIfPresent(Date.self, forKey: .closedAt)
        self.draft = try container.decodeIfPresent(Bool.self, forKey: .draft) ?? false
        self.locked = try container.decodeIfPresent(Bool.self, forKey: .locked) ?? false
        self.user = try container.decode(User.self, forKey: .user)
    }
}
