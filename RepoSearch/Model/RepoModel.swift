//
//  RepoModel.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/16/23.
//

import Foundation

// MARK: - Repos
struct Repos: Codable {
    let totalCount: Int
    let items: [Item]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}

// MARK: - Item
struct Item: Codable {
    let id: Int
    let nodeID, name, fullName: String
    let owner: Owner
    let description: String
    let url: String
    let createdAt, updatedAt, pushedAt: Date
    let archived, disabled: Bool
    let visibility: String
    let openIssues, watchers: Int

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case owner, description, url
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case archived, disabled, visibility
        case openIssues = "open_issues"
        case watchers
    }
}

// MARK: - Owner
struct Owner: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL, url: String
    let type: String

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case url, type
    }
}

// MARK: - Issue
struct Issue: Codable {
    let url, repositoryURL, commentsURL: String
    let id: Int
    let nodeID: String
    let number: Int
    let title: String
    let user: User
    let state: String
    let locked: Bool
    let assignee: String?
    let comments: Int
    let createdAt, updatedAt: Date
    let closedAt: Date?
    let authorAssociation: String
    let draft: Bool
    let body: String?

    enum CodingKeys: String, CodingKey {
        case url
        case repositoryURL = "repository_url"
        case commentsURL = "comments_url"
        case id
        case nodeID = "node_id"
        case number, title, user, state, locked, assignee, comments
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case closedAt = "closed_at"
        case authorAssociation = "author_association"
        case draft, body
    }
}

// MARK: - User
struct User: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL, url: String
    let type: String

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case url, type
    }
}

typealias Issues = [Issue]
struct RepoModel {
/*
 https://api.github.com/search/repositories?q=language:swift
 Repo Model:
 Name
 full_name
 description
 language - optional
 Backend
 id
 url

 https://api.github.com/repos/vsouza(owner_name)/awesome-ios(name)/contributors
 OwnerModel: (this is common for both repo list owners object and collaborator api obis)
 login
 Id
 avatarUrl
 Type

 https://api.github.com/repos/vsouza(owner_name)/awesome-ios(name)/issues
 Issues:
 Id
 Title
 State
 Created
 Updated
 Url


*/
}
