//
//  RepoDetailsViewModelTests.swift
//  RepoSearchTests
//
//  Created by Venkata Sama on 12/17/23.
//

import XCTest
import Combine
@testable import RepoSearch

class RepoDetailsViewModelTests: XCTestCase {

    var viewModel: RepoDetailsViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = Set<AnyCancellable>()
        let repoModel = RepoModel(id: 1, openIssues: 0, watchers: 0, nodeID: "MDEwOlJlcG9zaXRvcnkx", name: "grit", fullName: "mojombo/grit", description: "**Grit is no longer maintained. Check out libgit2/rugged.** Grit gives you object oriented read/write access to Git repositories via Ruby.", url: "https://api.github.com/repos/mojombo/grit", visibility: nil, user: User(login: "mojombo", nodeID: "MDQ6VXNlcjE=", avatarURL: "https://avatars.githubusercontent.com/u/1?v=4", url: "https://api.github.com/users/mojombo", type: "User", id: 1, contributions: 20), createdAt: nil, updatedAt: nil, pushedAt: nil, archived: false, disabled: false)
        viewModel = RepoDetailsViewModel(repo: repoModel)
    }

    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchContributors() {
        // Set up an expectation for the async operation
        let expectation = XCTestExpectation(description: "Fetch contributors")

        // Set up a cancellable to capture the result
        var cancellable: AnyCancellable?

        // Subscribe to the publisher and fulfill the expectation when the value is received
        cancellable = viewModel.$contributors
            .dropFirst() // Ignore the initial nil value
            .sink { contributors in
                XCTAssertNotNil(contributors)
                expectation.fulfill()
                cancellable?.cancel()
            }

        // Call the method to trigger the network request
        viewModel.fetchContributors(for: viewModel.repoDetail!)

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchRepositoryIssues() {
        // Set up an expectation for the async operation
        let expectation = XCTestExpectation(description: "Fetch repository issues")

        // Set up a cancellable to capture the result
        var cancellable: AnyCancellable?

        // Subscribe to the publisher and fulfill the expectation when the value is received
        cancellable = viewModel.$issues
            .dropFirst() // Ignore the initial nil value
            .sink { issues in
                XCTAssertNotNil(issues)
                expectation.fulfill()
                cancellable?.cancel()
            }

        // Call the method to trigger the network request
        viewModel.fetchRepositoryIssues(for: viewModel.repoDetail!)

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
    }
}
