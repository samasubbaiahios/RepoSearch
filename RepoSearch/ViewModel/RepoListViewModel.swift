//
//  RepoListViewModel.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/16/23.
//

import Foundation
import Combine

class RepoListViewModel: ObservableObject {

    @Published private(set) var repositiries: [RepoModel]?
    var fetchedListOutput: CurrentValueSubject<Result<[RepoModel], Error>, Never> = CurrentValueSubject<Result<[RepoModel], Error>, Never>(.success([]))
    private var isListFetchingInProgress = false
    private var cancellable = Set<AnyCancellable>()  // store the publishers

    public init() {}

    /// Fetchs  information
    ///
    /// - Parameters:
    ///    - completionHandler: returns Boolean
    func fetchTopStories() {
        
        let req = NetworkRequest(resourcePath: RequestFactory.getAllPublicRepos.path, httpMethod: .get, queryParams: nil, requestContentType: .json, shouldIgnoreCacheData: true)
        let processor = NetworkService(RequestProcessor.shared)
        processor.loadAPIRequest(req).sink { (completion) in
            self.isListFetchingInProgress = false
            switch completion {
            case .failure(let error):
                self.fetchedListOutput.send(.failure(error))
                break
                
            case .finished:
            break
            }
        } receiveValue: { result in
            self.repositiries = result
            self.isListFetchingInProgress = false
            self.fetchedListOutput.send(.success(result)) // Notifying data.
        }
        .store(in: &cancellable)
    }

}
