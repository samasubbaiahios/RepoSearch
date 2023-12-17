//
//  RepoDescriptionView.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/17/23.
//

import SwiftUI

struct RepoDescriptionView: View {
    let repoDetail: RepoModel?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SectionalView(sectionName: "Repo Name: ", details: repoDetail?.fullName ?? "-")
            Spacer()
            Text("Description:")
                .fontWeight(.bold)
            Spacer()
            Text(repoDetail?.description ?? "-")
            Spacer()
            HStack{
                VStack {
                    SectionalView(sectionName: "Created: ", details: repoDetail?.createdAt?.toDateString() ?? "-")
                    SectionalView(sectionName: "Last Updated:", details: repoDetail?.updatedAt?.toDateString() ?? "-")
                }
                Spacer()
                AvatarView(viewModel: AvatarViewModel(avatarURL: repoDetail?.user?.avatarURL?.toURL(), avatarTitle: repoDetail?.user?.login ?? "-"))
            }
        }
    }
}

struct SectionalView: View {
    let sectionName: String
    let details: String
    var body: some View {
        HStack(alignment: .top) {
            Text(sectionName)
                .fontWeight(.bold)
            Text(details)
            Spacer()
        }
    }
}
