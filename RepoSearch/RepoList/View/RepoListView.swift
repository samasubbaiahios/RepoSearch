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
                if let errorObj = self.viewModel.error {
                    ErrorView.init(error: errorObj)
                } else {
                    if let repos = self.viewModel.repositories {
                        ForEach(repos, id: \.id) { repo in
                            NavigationLink(destination: RepoDetailsView(viewModel: RepoDetailsViewModel(repo: repo))) {
                                RepoCell(repoDetails: repo)
                            }
                        }
                    }
                }
            }
            .refreshable(action: {
                viewModel.fetchPublicRepos()
            })
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

struct ErrorView: View {
    let error: Error
    
    var body: some View {
        HStack {
            Image("noInternet")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 64, height: 64)
            Text(CustomFormatter.errorHandlers(error: error))
        }
    }
}
