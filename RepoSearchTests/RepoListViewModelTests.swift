//
//  RepoListViewModelTests.swift
//  RepoSearchTests
//
//  Created by Venkata Sama on 12/18/23.
//

import XCTest
import Combine
@testable import RepoSearch

class RepoListViewModelTests: XCTestCase {

    var viewModel: RepoListViewModel!

    override func setUp() {
        super.setUp()
        viewModel = RepoListViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testFetchPublicRepos() {
        // Set up an expectation for the async operation
        let expectation = XCTestExpectation(description: "Fetch public repos")

        // Set up a cancellable to capture the result
        var cancellable: AnyCancellable?

        // Subscribe to the publisher and fulfill the expectation when the value is received
        cancellable = viewModel.$repositories
            .dropFirst() // Ignore the initial nil value
            .sink { repos in
                XCTAssertNotNil(repos)
                expectation.fulfill()
                cancellable?.cancel()
            }

        // Call the method to trigger the network request
        viewModel.fetchPublicRepos()

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchRepositories() {
        // Set up an expectation for the async operation
        let expectation = XCTestExpectation(description: "Fetch language-specific repos")

        // Set up a cancellable to capture the result
        var cancellable: AnyCancellable?

        // Set a value for searchText
        viewModel.searchText = "Swift"

        // Subscribe to the publisher and fulfill the expectation when the value is received
        cancellable = viewModel.$repositories
            .dropFirst() // Ignore the initial nil value
            .sink { repos in
                XCTAssertNotNil(repos)
                expectation.fulfill()
                cancellable?.cancel()
            }

        // Call the method to trigger the network request
        viewModel.fetchRepositories()

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
    }
}
