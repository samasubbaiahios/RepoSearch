//
//  RepoListViewModel.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/16/23.
//

import Foundation
import Combine

class RepoListViewModel: ObservableObject {

    @Published var repositories: [RepoModel]?
    @Published var searchText = ""

    private var fetchedListOutput: CurrentValueSubject<Result<[RepoModel], Error>, Never> = CurrentValueSubject<Result<[RepoModel], Error>, Never>(.success([]))
    @Published private(set) var isListFetchingInProgress = false
    @Published private(set) var error: Error?

    private var cancellable = Set<AnyCancellable>()  // store the publishers

    public init() {}

    /// Fetchs  All GitHub Public Repositories
    ///
    /// - Parameters:
    ///    - completionHandler: returns Boolean
    func fetchPublicRepos() {
        error = nil
        if !Reachability.isConnectedToNetwork() {
            self.isListFetchingInProgress = false
            error = NetworkErrorTypes.noInternetConnection
            self.fetchedListOutput.send(.failure(NetworkErrorTypes.noInternetConnection))
        }
        
        isListFetchingInProgress = true
        let request = RequestFactory.getAllPublicRepos
        let publicRepoReq = NetworkRequest(resourcePath: request.path,
                                           httpMethod: .get,
                                           queryParams: request.parameters,
                                           requestContentType: .json,
                                           shouldIgnoreCacheData: true)
        let processor = NetworkService(RepoServiceInteractor())
        processor.loadAPIRequest(publicRepoReq)
            .receive(on: DispatchQueue.main) // Ensure UI updates run on the main thread
            .sink { (completion) in
                self.isListFetchingInProgress = false
                switch completion {
                case .failure(let error):
                    self.fetchedListOutput.send(.failure(error))
                    break
                    
                case .finished:
                    break
                }
            } receiveValue: { result in
                self.repositories = result
                self.isListFetchingInProgress = false
                self.fetchedListOutput.send(.success(result)) // Notifying data.
            }
            .store(in: &cancellable)
    }

    /// Fetchs  Specific Language Repositories
    ///
    /// - Parameters:
    ///    - completionHandler: returns Boolean
    func fetchRepositories() {
        error = nil
        if !Reachability.isConnectedToNetwork() {
            self.isListFetchingInProgress = false
            error = NetworkErrorTypes.noInternetConnection
            self.fetchedListOutput.send(.failure(NetworkErrorTypes.noInternetConnection))
        }
        isListFetchingInProgress = true
        let languagePath = RequestFactory.getLanguageSpecificRepos(language: searchText)
        let publicRepoReq = NetworkRequest(resourcePath: languagePath.path,
                                           httpMethod: .get,
                                           queryParams: languagePath.parameters,
                                           requestContentType: .json,
                                           shouldIgnoreCacheData: true)
        let processor = NetworkService(LanguagesRepoServiceInteractor())
        processor.loadAPIRequest(publicRepoReq)
            .receive(on: DispatchQueue.main) // Ensure UI updates run on the main thread
            .sink { (completion) in
                self.isListFetchingInProgress = false
                switch completion {
                case .failure(let error):
                    self.fetchedListOutput.send(.failure(error))
                    break
                    
                case .finished:
                    break
                }
            } receiveValue: { result in
                self.repositories = result.items
                self.isListFetchingInProgress = false
                self.fetchedListOutput.send(.success(result.items)) // Notifying data.
            }
            .store(in: &cancellable)
    }
}
