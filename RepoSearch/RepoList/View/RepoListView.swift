//
//  ContentView.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/16/23.
//

import SwiftUI

struct RepoListView: View {
    @ObservedObject var viewModel = RepoListViewModel()

    var body: some View {
        NavigationView {
            List {
                if let repos = self.viewModel.repositories {
                    ForEach(repos, id: \.id) { repo in
                        NavigationLink(destination: RepoDetailsView(viewModel: RepoDetailsViewModel(repo: repo))) {
                            RepoCell(repoDetails: repo)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .onAppear(perform: viewModel.fetchPublicRepos)
            .navigationBarTitle("GitHub Repositories")
            .overlay(content: {
                if viewModel.isListFetchingInProgress {
                    ProgressView().progressViewStyle(.circular)
                }
            })
        }.searchable(text: $viewModel.searchText, prompt: "Search Programming Language")
            .onChange(of: viewModel.searchText) { newValue in
                if newValue.isEmpty && viewModel.searchText.isEmpty {
                    viewModel.fetchRepositories()
                }
            }
            .onSubmit(of: .search) {
                viewModel.fetchRepositories()
            }
    }
}
