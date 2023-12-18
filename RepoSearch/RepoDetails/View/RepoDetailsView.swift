//
//  RepoDetailsView.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/16/23.
//

import SwiftUI

struct RepoDetailsView: View {
    
    @ObservedObject var viewModel: RepoDetailsViewModel

    var body: some View {
        List{
            RepoDescriptionView(repoDetail: viewModel.repoDetail)
            if viewModel.contributors?.count ?? 0 > 0 {
                RepoContributorsView(contributors: viewModel.contributors)
            }
            if viewModel.issues?.count ?? 0 > 0 {
                RepoIssuesView(issues: viewModel.issues)
            }
        }
        .overlay(content: {
            if viewModel.isListFetchingInProgress {
                ProgressView().progressViewStyle(.circular)
            }
        })
        .onAppear(perform: {
            viewModel.fetchContributors()
            viewModel.fetchRepositoryIssues()
        })
        .navigationTitle(viewModel.repoDetail?.name ?? "|_|")
    }
}
