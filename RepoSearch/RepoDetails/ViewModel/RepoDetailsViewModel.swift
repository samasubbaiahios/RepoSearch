//
//  RepoDetailsViewModel.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/17/23.
//

import Foundation
import Combine

class RepoDetailsViewModel: ObservableObject {

    @Published var contributors: Users?
    @Published var issues: Issues?

    private(set) var repoDetail: RepoModel?
    
    @Published private(set) var isListFetchingInProgress = false
    private var cancellable = Set<AnyCancellable>()  // store the publishers

    var usersListOutput: CurrentValueSubject<Result<Users, Error>, Never> = CurrentValueSubject<Result<Users, Error>, Never>(.success([]))
    var issuesListOutput: CurrentValueSubject<Result<Issues, Error>, Never> = CurrentValueSubject<Result<Issues, Error>, Never>(.success([]))

    
    public init(repo: RepoModel) {
        repoDetail = repo
    }

    /// Fetch Contributors of Repository
    ///
    /// - Parameters:
    ///    - completionHandler: returns Boolean
    func fetchContributors(for repo: RepoModel) {
        isListFetchingInProgress = true
        guard let user = repo.user?.login,
              let repoName = repo.name else {
            isListFetchingInProgress = false
            return
        }
        let contributorsPath = RequestFactory.getContributors(repo: repoName, owner: user)
        let publicRepoReq = NetworkRequest(resourcePath: contributorsPath.path,
                                           httpMethod: .get,
                                           queryParams: contributorsPath.parameters,
                                           requestContentType: .json,
                                           shouldIgnoreCacheData: true)
        let processor = NetworkService(RepoContributorsServiceInteractor())
        processor.loadAPIRequest(publicRepoReq).sink { (completion) in
            self.isListFetchingInProgress = false
            switch completion {
            case .failure(let error):
                self.usersListOutput.send(.failure(error))
                break
                
            case .finished:
                break
            }
        } receiveValue: { result in
            DispatchQueue.main.async {
                let issuesResult = result.sorted { $0.contributions > $1.contributions }
                let slicedResult = result.count > 3 ? Array(issuesResult.prefix(3)):result
                self.contributors = slicedResult
                self.isListFetchingInProgress = false
                self.usersListOutput.send(.success(slicedResult)) // Notifying data.
            }
        }
        .store(in: &cancellable)
    }

    /// Fetchs Repositories Issues
    ///
    /// - Parameters:
    ///    - completionHandler: returns Boolean
    func fetchRepositoryIssues(for repo: RepoModel) {
        isListFetchingInProgress = true
        guard let user = repo.user?.login,
              let repoName = repo.name else {
            isListFetchingInProgress = false
            return
        }
        let issuesPath = RequestFactory.getIssuesFor(repo: repoName, owner: user)
        let publicRepoReq = NetworkRequest(resourcePath: issuesPath.path,
                                           httpMethod: .get,
                                           queryParams: issuesPath.parameters,
                                 requestContentType: .json,
                                 shouldIgnoreCacheData: true)
        let processor = NetworkService(RepoIssuesListServiceInteractor())
        processor.loadAPIRequest(publicRepoReq).sink { (completion) in
            self.isListFetchingInProgress = false
            switch completion {
            case .failure(let error):
                self.issuesListOutput.send(.failure(error))
                break
                
            case .finished:
                break
            }
        } receiveValue: { result in
            DispatchQueue.main.async {
                let issuesResult = result.sorted { $0.updatedAt ?? Date() > $1.updatedAt ?? Date() }
                let slicedResult = result.count > 3 ? Array(issuesResult.prefix(3)):result
                self.issues = slicedResult
                self.isListFetchingInProgress = false
                self.issuesListOutput.send(.success(slicedResult)) // Notifying data.
            }
        }
        .store(in: &cancellable)
    }
}
