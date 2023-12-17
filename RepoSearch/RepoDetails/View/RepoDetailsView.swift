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
            RepoContributorsView(contributors: viewModel.contributors)
            RepoIssuesView(issues: viewModel.issues)
        }
        .overlay(content: {
            if viewModel.isListFetchingInProgress {
                ProgressView().progressViewStyle(.circular)
            }
        })
        .onAppear(perform: {
            guard let repoDetail = viewModel.repoDetail else { return }
            viewModel.fetchContributors(for: repoDetail)
            viewModel.fetchRepositoryIssues(for: repoDetail)
        })
        .navigationTitle(viewModel.repoDetail?.name ?? "|_|")
    }
}
