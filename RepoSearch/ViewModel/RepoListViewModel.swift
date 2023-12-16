//
//  RepoListViewModel.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/16/23.
//

import Foundation

class RepoListViewModel {
//    private let networking: AppsService = AppsService.init()
//    var appsInfo = [RepoModel]()
    @Published private(set) var repositiries: [RepoModel] = []

    public init() {}

    /// Fetchs  information
    ///
    /// - Parameters:
    ///    - completionHandler: returns Boolean
    func fetchTopStories() {
//        let url = URL(string: "https://hacker-news.firebaseio.com/v0/beststories.json")!
//        let request = APIRequest(url: url)
//        request.perform { [weak self] (ids: [Int]?) -> Void in
//            guard let ids = ids?.prefix(10) else { return }
//            for (index, id) in ids.enumerated() {
//                self?.fetchStory(withID: id) { story in
//                    self?.stories[index] = story
//                }
//            }
//        }
    }



}
