//
//  RepoContributorsView.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/17/23.
//

import SwiftUI

struct RepoContributorsView: View {
    let contributors: Users?
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Image("contributors")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                Text("Top Contributors")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(contributors ?? [], id: \.id) { contributor in
                        AvatarView(viewModel: AvatarViewModel(avatarURL: contributor.avatarURL?.toURL(), avatarTitle: contributor.login ?? "-"))
                    }
                }
            }
        }
    }
}
