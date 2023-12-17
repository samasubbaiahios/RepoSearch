//
//  RequestFactory.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/16/23.
//

import Foundation

enum RequestFactory {
    
    case getAllPublicRepos
    case getRepoFor(topic: String)
    case getLanguageSpecificRepos(language: String)
    case getIssuesFor(repo: String, owner: String)
    case getContributors(repo: String, owner: String)
    
    var path: String {
        switch self {
        case .getAllPublicRepos:
            return "/repositories"
        case .getRepoFor(_):
            return "/search/repositories"
        case .getLanguageSpecificRepos(_):
            return "/search/repositories"
        case .getIssuesFor(let repo, let owner):
            return "/repos/\(owner)/\(repo)/issues"
        case .getContributors(let repo, let owner):
            return "/repos/\(owner)/\(repo)/contributors"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAllPublicRepos,
                .getRepoFor,
                .getLanguageSpecificRepos,
                .getIssuesFor,
                .getContributors:
            return .get
        }
    }
    
    var headers: HTTPContentType? {
        switch self {
        case .getAllPublicRepos,
                .getRepoFor,
                .getLanguageSpecificRepos,
                .getIssuesFor,
                .getContributors:
            return .json
        }
    }
    
    var parameters: [String: String]? {
        switch self {
        case .getRepoFor(let topic):
            return ["q": topic]
        case .getLanguageSpecificRepos(let language):
            return ["q": "language:\(language)"]
        default:
            return nil
        }
    }
}
