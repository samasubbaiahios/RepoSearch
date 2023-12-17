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
                        .padding(.vertical, 6)
                    SectionalView(sectionName: "Last Updated:", details: repoDetail?.updatedAt?.toDateString() ?? "-")
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Owner:")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    AvatarView(viewModel: AvatarViewModel(avatarURL: repoDetail?.user?.avatarURL?.toURL(), avatarTitle: repoDetail?.user?.login ?? "-"))
                }
                .padding(.trailing, 6.0)

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
                .font(.subheadline)
                .fontWeight(.bold)
            Text(details)
            Spacer()
        }
    }
}
