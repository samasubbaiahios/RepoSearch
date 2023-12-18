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
        viewModel.fetchContributors()

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
        viewModel.fetchRepositoryIssues()

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchContributorsFailure() {
        // Given
        let mockRepo = RepoModel(id: 1, openIssues: 0, watchers: 0, nodeID: "MDEwOlJlcG9zaXRvcnkx", name: "grit", fullName: "mojombo/grit", description: "**Grit is no longer maintained. Check out libgit2/rugged.** Grit gives you object oriented read/write access to Git repositories via Ruby.", url: "https://api.github.com/repos/mojombo/grit", visibility: nil, user: User(login: "mojombo", nodeID: "MDQ6VXNlcjE=", avatarURL: "https://avatars.githubusercontent.com/u/1?v=4", url: "https://api.github.com/users/mojombo", type: "User", id: 1, contributions: 20), createdAt: nil, updatedAt: nil, pushedAt: nil, archived: false, disabled: false)
        let mockError = NSError(domain: "testDomain", code: 42, userInfo: nil)
        let mockResult: Result<Users, Error> = .failure(mockError)

        let expectation = XCTestExpectation(description: "Fetch contributors failed")

        // When
        viewModel.usersListOutput
            .sink { result in
                switch result {
                case .success:
                    XCTFail("Fetch contributors should fail")
                case .failure(let error):
                    XCTAssertEqual(error as NSError, mockError)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // Triggering the fetch
        viewModel.fetchContributors()

        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertFalse(viewModel.isListFetchingInProgress)
        XCTAssertNil(viewModel.contributors)
    }
    
    
    // MARK: - Test Fetch Repository Issues

//    func testFetchRepositoryIssuesSuccess() {
//        // Given
//        let mockRepo = RepoModel(id: 1, openIssues: 0, watchers: 0, nodeID: "MDEwOlJlcG9zaXRvcnkx", name: "grit", fullName: "mojombo/grit", description: "**Grit is no longer maintained. Check out libgit2/rugged.** Grit gives you object oriented read/write access to Git repositories via Ruby.", url: "https://api.github.com/repos/mojombo/grit", visibility: nil, user: User(login: "mojombo", nodeID: "MDQ6VXNlcjE=", avatarURL: "https://avatars.githubusercontent.com/u/1?v=4", url: "https://api.github.com/users/mojombo", type: "User", id: 1, contributions: 20), createdAt: nil, updatedAt: nil, pushedAt: nil, archived: false, disabled: false)
//        let mockIssues = [Issue(title: "Supo",
//                                nodeID: "nil",
//                                url: nil,
//                                repositoryURL: nil,
//                                commentsURL: nil,
//                                assignee: nil,
//                                authorAssociation:nil,
//                                state: nil,
//                                body: nil,
//                                id: 3,
//                                number:  0,
//                                comments: 0,
//                                draft: false,
//                                locked: false,
//                                createdAt: nil,
//                                updatedAt: nil,
//                                closedAt: nil,
//                                user: User(login: "mojombo", nodeID: "MDQ6VXNlcjE=", avatarURL: "https://avatars.githubusercontent.com/u/1?v=4", url: "https://api.github.com/users/mojombo", type: "User", id: 1, contributions: 20))]
//        let mockResult: Result<Issues, Error> = .success(mockIssues)
//
//        let expectation = XCTestExpectation(description: "Repository issues fetched successfully")
//
//        // When
//        viewModel.issuesListOutput
//            .sink { result in
//                switch result {
//                case .success(let issues):
//                    XCTAssertEqual(issues as [Issue], mockIssues)
//                    expectation.fulfill()
//                case .failure:
//                    XCTFail("Fetch repository issues should not fail")
//                }
//            }
//            .store(in: &cancellables)
//
//        // Triggering the fetch
//        viewModel.fetchRepositoryIssues()
//
//        // Then
//        wait(for: [expectation], timeout: 1.0)
//        XCTAssertFalse(viewModel.isListFetchingInProgress)
//        XCTAssertEqual(viewModel.issues, mockIssues)
//    }
    
    func testFetchRepositoryIssuesFailure() {
        // Given
        let mockRepo = RepoModel(id: 1, openIssues: 0, watchers: 0, nodeID: "MDEwOlJlcG9zaXRvcnkx", name: "grit", fullName: "mojombo/grit", description: "**Grit is no longer maintained. Check out libgit2/rugged.** Grit gives you object oriented read/write access to Git repositories via Ruby.", url: "https://api.github.com/repos/mojombo/grit", visibility: nil, user: User(login: "mojombo", nodeID: "MDQ6VXNlcjE=", avatarURL: "https://avatars.githubusercontent.com/u/1?v=4", url: "https://api.github.com/users/mojombo", type: "User", id: 1, contributions: 20), createdAt: nil, updatedAt: nil, pushedAt: nil, archived: false, disabled: false)
        let mockError = NSError(domain: "testDomain", code: 42, userInfo: nil)
        let mockResult: Result<Issues, Error> = .failure(mockError)

        let expectation = XCTestExpectation(description: "Fetch repository issues failed")

        // When
        viewModel.issuesListOutput
            .sink { result in
                switch result {
                case .success:
                    XCTFail("Fetch repository issues should fail")
                case .failure(let error):
                    XCTAssertEqual(error as NSError, mockError)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // Triggering the fetch
        viewModel.fetchRepositoryIssues()

        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertFalse(viewModel.isListFetchingInProgress)
        XCTAssertNil(viewModel.issues)
    }
}
